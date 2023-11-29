import 'package:flutter/material.dart';

import 'package:estados/models/usuario.dart';

import 'package:estados/services/usuario_service.dart';

class Page1 extends StatelessWidget {
  const Page1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page 1'),
      ),
      body: StreamBuilder(
        stream: usuarioService.usuarioStream,
        builder: (BuildContext context, AsyncSnapshot snapshot){
          return snapshot.hasData
            ? InformacionUsuario( usuarioService.usuario )
            : Center( child: const Text('No hay informacion del usuario'), );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon( Icons.access_alarm_sharp ),
        onPressed: () => Navigator.pushNamed(context, 'page2')
      ),
    );
  }
}

class InformacionUsuario extends StatelessWidget {

  final Usuario? usuario;
  const InformacionUsuario( this.usuario );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('General', style: TextStyle( fontSize: 18, fontWeight: FontWeight.bold ),),
          Divider(),
          ListTile( title: Text('Nombre: ${ usuario?.nombre }') ),
          ListTile( title: Text('Edad: ${ usuario?.edad.toString() }') ),

          Text('Profesiones', style: TextStyle( fontSize: 18, fontWeight: FontWeight.bold ),),
          Divider(),
          ListTile( title: Text('Profesion 1') ),
          ListTile( title: Text('Profesiones 2') ),
          ListTile( title: Text('Profesiones 3') ),
        ],
      ),
    );
  }
}