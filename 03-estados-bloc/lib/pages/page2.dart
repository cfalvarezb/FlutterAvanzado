import 'package:estados/models/usuario.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:estados/bloc/user/user_bloc.dart';

class Page2 extends StatelessWidget {
  const Page2({super.key});

  @override
  Widget build(BuildContext context) {

    final userBloc = BlocProvider.of<UserBloc>(context, listen: false);

    return Scaffold(
        appBar: AppBar(
          title: Text('Page 2'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MaterialButton(
                  child: Text('Establecer Usuario',
                      style: TextStyle(color: Colors.white)),
                  color: Colors.blue,
                  onPressed: () {

                    final newUser = Usuario(
                      nombre: 'Fernando', 
                      edad: 30, 
                      profesiones: ['Profesion', 'Profesion']
                    );

                    userBloc.add( ActivateUser(newUser) );
                  }),
              MaterialButton(
                  child: Text('Cambiar Edad',
                      style: TextStyle(color: Colors.white)),
                  color: Colors.blue,
                  onPressed: () {
                    userBloc.add( ChangeUserAge(33) );
                  }),
              MaterialButton(
                  child: Text('Añadir Profesion',
                      style: TextStyle(color: Colors.white)),
                  color: Colors.blue,
                  onPressed: () {
                    final profesion = [ 'profesion' ];
                    userBloc.add( AddProfesion( 'Nueva profesion' ) );
                  }),
            ],
          ),
        ));
  }
}
