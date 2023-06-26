import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import 'package:chat/models/usuarios_response.dart';
import 'package:chat/services/auth-service.dart';
import 'package:chat/global/environment.dart';
import 'package:chat/models/usuario.dart';


class UsuariosService {

  Future<List<Usuario>?> getUsuarios() async {
    try {
      var url = Uri.http(Environment.apiUrl, '/api/usuarios');

      final res = await http.get( url, 
        headers: {
          'Content-Type': 'application/json',
          'x-token': await AuthService.getToken() ?? "No Token"
        }
      );

      final usuariosReponse = usuariosReponseFromJson( res.body );
      return usuariosReponse.usuarios;
    } catch (e) {
      return null;
    }
  }
}