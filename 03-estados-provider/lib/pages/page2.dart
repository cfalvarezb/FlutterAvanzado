import 'package:estados/models/usuario.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:estados/services/usuario_service.dart';
class Page2 extends StatelessWidget {
  const Page2({super.key});

  @override
  Widget build(BuildContext context) {

    final usuarioService = Provider.of<UsuarioService>(context);

    return Scaffold(
        appBar: AppBar(
          title: (usuarioService.extisteUsuario) 
            ? Text('Nombre: ${usuarioService.usuario?.nombre}') 
            : Text('Pagina 2'),
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
                      nombre: 'nombre2', 
                      edad: 33, 
                      profesiones: [
                        'FullStackDeveloper',
                        'nativo'
                    ]);
                    usuarioService.usuario = newUser;
                  }),
              MaterialButton(
                  child: Text('Cambiar Edad',
                      style: TextStyle(color: Colors.white)),
                  color: Colors.blue,
                  onPressed: () {
                    usuarioService.cambiarEdad(10);
                  }),
              MaterialButton(
                  child: Text('Añadir Profesion',
                      style: TextStyle(color: Colors.white)),
                  color: Colors.blue,
                  onPressed: () {
                    usuarioService.agregarProfesion();
                  }),
            ],
          ),
        ));
  }
}
