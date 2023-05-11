import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:band_names/models/band.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Band> bands = [
    Band(id: '1', name: 'Metallica1', votes: 1),
    Band(id: '1', name: 'Metallica2', votes: 2),
    Band(id: '1', name: 'Metallica3', votes: 3),
    Band(id: '1', name: 'Metallica4', votes: 4),
    Band(id: '1', name: 'Metallica5', votes: 5),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Band Names'),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: ListView.builder(
        itemCount: bands.length,
        itemBuilder: (BuildContext context, int index) => _bandTile(bands[index])
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewBand,
        elevation: 1,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _bandTile( Band band ) {
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
        print("Id: ${band.id}");
      },
      child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.blue[100],
            child: Text( band.name!.substring(0,2) ),
          ),
          title: Text(band.name!),
          trailing: Text('${ band.votes }', style: const TextStyle( fontSize: 20 ),),
          onTap: () {
            print('${band.name}');
          },
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
        this.bands.add( Band(id: DateTime.now().toString(), name: name, votes: 0 ) );
        setState(() {
        });
      }

      Navigator.pop(context);

  }

}