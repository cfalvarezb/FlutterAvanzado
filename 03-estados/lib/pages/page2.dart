import 'package:flutter/material.dart';

class Page2 extends StatelessWidget {
  const Page2({super.key});

  @override
  Widget build(BuildContext context) {
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
                  onPressed: () {}),
              MaterialButton(
                  child: Text('Cambiar Edad',
                      style: TextStyle(color: Colors.white)),
                  color: Colors.blue,
                  onPressed: () {}),
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
