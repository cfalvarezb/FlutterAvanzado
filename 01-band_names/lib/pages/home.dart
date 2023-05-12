import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';

import 'package:band_names/models/band.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';
import 'package:band_names/services/socket_service.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Band> bands = [
    // Band(id: '1', name: 'Metallica1', votes: 1),
    // Band(id: '1', name: 'Metallica2', votes: 2),
    // Band(id: '1', name: 'Metallica3', votes: 3),
    // Band(id: '1', name: 'Metallica4', votes: 4),
    // Band(id: '1', name: 'Metallica5', votes: 5),
  ];

  @override
  void initState() {
    // TODO: implement initState
    final socketService = Provider.of<SocketService>(context, listen: false);
    socketService.socket?.on('active-bands', _handleActiveBands);
    super.initState();
  }

  _handleActiveBands( dynamic payload ) {
      bands = ( payload as List ).map((band) => Band.fromMap(band)).toList();
      setState(() {});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    final socketService = Provider.of<SocketService>(context, listen: false);
    socketService.socket?.off('active-bands');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final socketService = Provider.of<SocketService>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Band Names'),
        backgroundColor: Colors.white,
        elevation: 1,
        actions: [
          Container(
            margin: EdgeInsets.only( right: 10 ),
            child: (socketService.serverStatus == ServerStatus.onLine) ? 
                      Icon( Icons.check_circle, color: Colors.blue[300]) :
                      (socketService.serverStatus == ServerStatus.connecting) ? 
                        Icon( Icons.album_outlined, color: Colors.green ) : 
                        Icon( Icons.offline_bolt, color: Colors.red ),
          )
        ],
      ),
      body: Column(
        children: [
          _showGraph(),
          Expanded (
            child: ListView.builder(
              itemCount: bands.length,
              itemBuilder: (BuildContext context, int index) => _bandTile(bands[index])
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewBand,
        elevation: 1,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _bandTile( Band band ) {

    final socketService = Provider.of<SocketService>(context, listen: false);

    return Dismissible(
      key: Key(band.id!),
      direction: DismissDirection.startToEnd,
      background: Container(
        padding: EdgeInsets.only( left: 8.0 ),
        color: Colors.red,
        child: const Align(
          alignment: Alignment.centerLeft,
          child: Text("Delete Band", style: TextStyle( color: Colors.white ),)
          ),
      ),
      onDismissed: (direction) {
        print("Direction: $direction");
        socketService.socket?.emit('delete-band', { 'id': band.id });
      },
      child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.blue[100],
            child: Text( band.name!.substring(0,2) ),
          ),
          title: Text(band.name!),
          trailing: Text('${ band.votes }', style: const TextStyle( fontSize: 20 ),),
          onTap: () => socketService.socket?.emit('vote-band', { 'id': band.id })
      ),
    );
  }

  _addNewBand() {

    final textController = TextEditingController();

    if ( Platform.isAndroid ) {
        return showDialog(
          context: context, 
          builder: (context) {
            return AlertDialog(
              title: Text('New Band Name'),
              content: TextField(
                controller: textController,
              ),
              actions: <Widget>[
                  MaterialButton(
                    elevation: 5,
                    onPressed: () => _addBandToList( textController.text ),
                    textColor: Colors.blue,
                    child: const Text('Add')
                  )
              ],
            );
          },
        );
    }

    showCupertinoDialog(
      context: context, 
      builder: (context) {
        return CupertinoAlertDialog(
            title: Text('New Band Name'),
            content: CupertinoTextField(
              controller: textController,
            ),
            actions: <Widget>[
                CupertinoDialogAction(
                  isDefaultAction: true,
                  onPressed: () => _addBandToList( textController.text ),
                  child: const Text('Add')
                ),
                CupertinoDialogAction(
                  isDestructiveAction: true,
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Dismiss')
                )
            ],
        );
      },
    );
    
  }

  void _addBandToList( String name ){

      if ( name.length > 1 ) {
        // Podemos agregarlo
        final socketService = Provider.of<SocketService>(context, listen: false);
        socketService.socket?.emit('add-band', { 'name': name });
      }

      Navigator.pop(context);

  }

  //Mostrar Grafica
  Widget _showGraph() {

    Map<String, double> dataMap = {};

    bands.forEach((band) {
      dataMap.putIfAbsent(band.name!, () => band.votes!.toDouble());
    });

    final List<Color> colorList = [
        Colors.blue[50]!,
        Colors.blue[200]!,
        Colors.pink[50]!,
        Colors.pink[200]!,
        Colors.yellow[50]!,
        Colors.yellow[200]!,
    ];

    return PieChart(
      dataMap: dataMap,
      animationDuration: Duration(milliseconds: 800),
      chartLegendSpacing: 32,
      chartRadius: MediaQuery.of(context).size.width / 3.2,
      colorList: colorList,
      initialAngleInDegree: 0,
      chartType: ChartType.disc,
      ringStrokeWidth: 32,
      //centerText: "Bands",
      legendOptions: LegendOptions(
        showLegendsInRow: false,
        legendPosition: LegendPosition.right,
        showLegends: true,
        legendShape: BoxShape.circle,
        legendTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      chartValuesOptions: ChartValuesOptions(
        showChartValueBackground: false,
        showChartValues: true,
        showChartValuesInPercentage: false,
        showChartValuesOutside: false,
        decimalPlaces: 1,
      ),
      // gradientList: ---To add gradient colors---
      // emptyColorGradient: ---Empty Color gradient---
    );
  }

}