import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:chat/models/messages_response.dart';
import 'package:chat/models/usuario.dart';

import 'package:chat/services/auth-service.dart';

import 'package:chat/global/environment.dart';

class ChatService with ChangeNotifier {

  Usuario? usuarioTo;

  Future<List<Message>> getChat( String usuarioID ) async {

    var url = Uri.http(Environment.apiUrl, '/api/messages/$usuarioID');

    final res = await http.get( url, 
      headers: {
        'Content-Type': 'application/json',
        'x-token': await AuthService.getToken() ?? "No Token"
      }
    );

    final messagesReponse = messagesReponseFromJson( res.body );
    return messagesReponse.messages;

  }

}