import 'package:estados/models/usuario.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:estados/bloc/user/user_bloc.dart';


class Page1 extends StatelessWidget {
  const Page1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page 1'),
        actions: [
          IconButton(
            onPressed: ()  {
              BlocProvider.of<UserBloc>(context, listen: false).add(DeleteUser());
            }, 
            icon: const Icon( Icons.delete_outline )
          )
        ],
      ),
      body: BlocBuilder<UserBloc, UserState>(builder: (context, state) {

        return ( state.existUser ) 
          ? InformacionUsuario( user: state.user! )
          : const Center(
            child: Text('No hay usuario seleccionado'),
          );
          
      }),
      floatingActionButton: FloatingActionButton(
        child: Icon( Icons.access_alarm_sharp ),
        onPressed: () => Navigator.pushNamed(context, 'page2')
      ),
    );
  }
}

class InformacionUsuario extends StatelessWidget {

  final Usuario user;

  const InformacionUsuario({
    super.key, 
    required this.user
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
          ListTile( title: Text('Nombre: ${user.nombre}') ),
          ListTile( title: Text('Edad: ${user.edad}') ),

          Text('Profesiones', style: TextStyle( fontSize: 18, fontWeight: FontWeight.bold ),),
          Divider(),
          ...user.profesiones.map(
            (profesion) => 
              ListTile( 
                title: Text('${profesion} ${user.profesiones.length}') 
          )).toList()
        ],
      ),
    );
  }
}