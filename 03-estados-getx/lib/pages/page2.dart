import 'package:estados/controllers/usuario_controller.dart';
import 'package:estados/models/usuario.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Page2 extends StatelessWidget {
  const Page2({super.key});

  @override
  Widget build(BuildContext context) {

    print(Get.arguments);
    final usuarioCtrl = Get.find<UsuarioController>();

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
                    usuarioCtrl.cargarUsuario(Usuario(nombre: 'nombre', edad: 9, profesiones: ['profesion']));
                    Get.snackbar(
                      'Usuario Establecido', 
                      'Cristian es el nombre del parcero',
                      backgroundColor: Colors.blue,
                      boxShadows: [
                        BoxShadow(
                          color: Colors.black38,
                          blurRadius: 10
                        )
                      ]);
                  }),
              MaterialButton(
                  child: Text('Cambiar Edad',
                      style: TextStyle(color: Colors.white)),
                  color: Colors.blue,
                  onPressed: () {
                    usuarioCtrl.cambiarEdad(10);
                  }),
              MaterialButton(
                  child: Text('Añadir Profesion',
                      style: TextStyle(color: Colors.white)),
                  color: Colors.blue,
                  onPressed: () {
                    usuarioCtrl.agregarProfesion('Profesion #${usuarioCtrl.profesionesCount + 1}');
                  }),
              MaterialButton(
                  child: Text('Cambiar Tema',
                      style: TextStyle(color: Colors.white)),
                  color: Colors.blue,
                  onPressed: () {
                    Get.changeTheme( Get.isDarkMode ? ThemeData.light() : ThemeData.dark());
                  }),
            ],
          ),
        ));
  }
}
