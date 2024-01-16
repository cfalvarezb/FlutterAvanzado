import 'package:estados/bloc/usuario/usuario_cubit.dart';
import 'package:estados/models/usuario.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Page2 extends StatelessWidget {
  const Page2({super.key});

  @override
  Widget build(BuildContext context) {

    final usuarioCubit = context.read<UsuarioCubit>();

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
                    final newUser = Usuario(nombre: 'nombre', edad: 0, profesiones: ['profesion 1','profesion 2']);
                    usuarioCubit.seleccionarUsuario(newUser);

                  }),
              MaterialButton(
                  child: Text('Cambiar Edad',
                      style: TextStyle(color: Colors.white)),
                  color: Colors.blue,
                  onPressed: () {
                    usuarioCubit.cambiarEdad(30);
                  }),
              MaterialButton(
                  child: Text('Añadir Profesion',
                      style: TextStyle(color: Colors.white)),
                  color: Colors.blue,
                  onPressed: () {
                    usuarioCubit.agregarProfesion();
                  }),
            ],
          ),
        ));
  }
}
