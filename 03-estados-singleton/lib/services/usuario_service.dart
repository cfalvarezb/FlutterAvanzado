import 'package:estados/models/usuario.dart';

import 'dart:async';


class _UsuarioService {
    Usuario? _usuario;

    StreamController<Usuario?> _usuarioStreamController = StreamController<Usuario>.broadcast();

    Usuario? get usuario => _usuario;

    bool get existUser => ( _usuario != null ) ? true : false;

    Stream<Usuario?> get usuarioStream => _usuarioStreamController.stream;

    void cargarUsuario( Usuario user ) {
        _usuario = user;
        _usuarioStreamController.add(user);
    }

    void cambiarEdad( int edad ) {
      _usuario?.edad = edad;
      _usuarioStreamController.add(_usuario);
    }

    dispose(){
      _usuarioStreamController.close();
    }
}

final usuarioService = _UsuarioService();