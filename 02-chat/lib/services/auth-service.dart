import 'dart:convert';
import 'dart:ffi';
import 'package:chat/models/login_response.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../global/environment.dart';
import '../models/usuario.dart';

class AuthService with ChangeNotifier {

  Usuario? usuario;
  bool _autenticando = false;
  bool get autenticando => _autenticando;
  set autenticando( bool value ) {
    _autenticando = value;
    notifyListeners();
  }

  final _storage = const FlutterSecureStorage();

  //Token Getters
  static Future<String?> getToken() async {
    final _storage = const FlutterSecureStorage();
    final token = await _storage.read(key: 'token');
    return token; 
  }

  static Future<void> deleteToken() async {
    final _storage = const FlutterSecureStorage();
    final token = await _storage.delete(key: 'token');
  }

  Future<bool> login(String email, String password) async {

    autenticando = true;

    final data = {
      'email': email,
      'password': password
    };

    var url = Uri.http(Environment.apiUrl, '/api/login');
    print(url);
    final res = await http.post( url, 
      body: jsonEncode(data),
      headers: {
        'Content-Type': 'application/json'
      }
    );

    print(res.body);
    autenticando = false;

    if ( res.statusCode == 200 ) {
      final loginResponse = loginResponseFromJson(res.body);
      usuario = loginResponse.usuario;

      await this._saveToken(loginResponse.token);

      return true;
    } else {
      return false;
    }

  }

  Future register(String name, String email, String password) async {
      autenticando = true;

      final data = {
        'nombre': name,
        'email': email,
        'password': password
      };

      var url = Uri.http(Environment.apiUrl, '/api/login/new');
      print(url);
      final res = await http.post( url, 
        body: jsonEncode(data),
        headers: {
          'Content-Type': 'application/json'
        }
      );

      print(res.body);
      autenticando = false;

      if ( res.statusCode == 200 ) {
        final loginResponse = loginResponseFromJson(res.body);
        usuario = loginResponse.usuario;

        await this._saveToken(loginResponse.token);
        return true;
      } else {
        final respBody = jsonDecode(res.body);
        return respBody['msg'];
      }
  }

  Future<bool> isLoggedIn() async {
    final token = await _storage.read(key: 'token');

    var url = Uri.http(Environment.apiUrl, '/api/login/renew');
    print(url);

    final res = await http.get( url, 
      headers: {
        'Content-Type': 'application/json',
        'x-token': token ?? 'No Token'
      }
    );

    print(res.body);

    if ( res.statusCode == 200 ) {
      final loginResponse = loginResponseFromJson(res.body);
      usuario = loginResponse.usuario;
      await this._saveToken(loginResponse.token);
      return true;
    } else {
      logout();
      return false;
    }
  }

  Future _saveToken( String token ) async {
    return await _storage.write(
      key: 'token',
      value: token,
    );
  }

  Future logout() async {
    return await _storage.delete(
      key: 'token'
    );
  }
} 