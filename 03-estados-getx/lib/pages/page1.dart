import 'package:estados/controllers/usuario_controller.dart';
import 'package:estados/models/usuario.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:estados/pages/page2.dart';

class Page1 extends StatelessWidget {
  const Page1({super.key});

  @override
  Widget build(BuildContext context) {

    final usuarioCtrl = Get.put( UsuarioController() );

    return Scaffold(
      appBar: AppBar(
        title: Text('Page 1'),
      ),
      body: Obx(() => usuarioCtrl.existeUsuario.value
      ? InformacionUsuario( usuario: usuarioCtrl.usuario.value)
      : NoInfo()
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon( Icons.access_alarm_sharp ),
        //onPressed: () => Navigator.pushNamed(context, 'page2')
        //onPressed: () => Get.to( const Page2() )
        onPressed: () => Get.toNamed('/page2', arguments: {
          'nombre': 'Fernando',
          'edad': 35
        })
      ),
    );
  }
}

class NoInfo extends StatelessWidget {
  const NoInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("No hay usuario seleccionado")
        ),
    );
  }
}

class InformacionUsuario extends StatelessWidget {

  final Usuario usuario;
  const InformacionUsuario({
    Key? key,
    required this.usuario
  });

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
          ListTile( title: Text('Nombre: ${this.usuario.nombre}') ),
          ListTile( title: Text('Edad: ${this.usuario.edad}') ),

          Text('Profesiones', style: TextStyle( fontSize: 18, fontWeight: FontWeight.bold ),),
          Divider(),
          ...this.usuario.profesiones.map((profesion) => 
            ListTile( title: Text(profesion) )
          )
        ],
      ),
    );
  }
}