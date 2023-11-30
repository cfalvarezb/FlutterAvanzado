import 'package:estados/models/usuario.dart';
import 'package:flutter/material.dart';

class UsuarioService with ChangeNotifier {
  Usuario? _usuario;

  Usuario? get usuario => _usuario;
  bool get extisteUsuario => ( _usuario != null ) ? true : false;

  set usuario( Usuario? user ) {
    _usuario = user;
    notifyListeners();
  }

  void cambiarEdad( int edad ) {
    _usuario?.edad = edad;
    notifyListeners();
  }

  void removerUsuario() {
    _usuario = null;
    notifyListeners();
  }

  void agregarProfesion() {
    _usuario?.profesiones.add('Profesion ${ _usuario?.profesiones.length ?? 0 + 1}');
    notifyListeners();
  }

}