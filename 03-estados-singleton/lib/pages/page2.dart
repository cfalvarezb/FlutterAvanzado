import 'package:estados/models/usuario.dart';
import 'package:flutter/material.dart';
import 'package:estados/services/usuario_service.dart';

class Page2 extends StatelessWidget {
  const Page2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: StreamBuilder(
            stream: usuarioService.usuarioStream,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              return snapshot.hasData
                ? Text('Nombre: ${ snapshot.data.nombre }')
                : Text('Pagina 2');
            },
          ),
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
                    final nuevoUsuario = Usuario(nombre: "nombre", edad: 28, profesiones: ["profesiones"]);
                    usuarioService.cargarUsuario(nuevoUsuario);
                  }),
              MaterialButton(
                  child: Text('Cambiar Edad',
                      style: TextStyle(color: Colors.white)),
                  color: Colors.blue,
                  onPressed: () {
                    usuarioService.cambiarEdad(20);
                  }),
              MaterialButton(
                  child: Text('Añadir Profesion',
                      style: TextStyle(color: Colors.white)),
                  color: Colors.blue,
                  onPressed: () {}),
            ],
          ),
        ));
  }
}
