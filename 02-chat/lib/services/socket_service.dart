import 'package:flutter/material.dart';

import 'package:chat/global/environment.dart';

import 'package:chat/services/auth-service.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus {
  onLine,
  offLine,
  connecting
}

class SocketService with ChangeNotifier {

  ServerStatus _serverStatus = ServerStatus.connecting;
  IO.Socket? _socket;

  ServerStatus get serverStatus => this._serverStatus;
  IO.Socket? get socket => this._socket;
  Function? get emit => this._socket?.emit;

  SocketService();
  
  void connect() async {

    final token = await AuthService.getToken();

    // Dart client
    _socket = IO.io('http://${Environment.socketUrl}', {
      'transports': ['websocket'],
      'autoConnect': true,
      'forceNew': true,
      'extraHeaders': {
        'x-token': token
      }
    });

    _socket?.on('connect', (_) {
      this._serverStatus = ServerStatus.onLine;
      notifyListeners();
    });

    _socket?.on('connecting', (_) {
      this._serverStatus = ServerStatus.connecting;
      notifyListeners();
    });

    _socket?.on('disconnect', (_) {
      this._serverStatus = ServerStatus.offLine;
      notifyListeners();
    });

    // socket.on('nuevo-mensaje', ( payload ) {
    //   print(' Nuevo mensaje');
    //   print(' nombre:' + payload['nombre']);
    //   print(' mensaje:' + payload['mensaje']);
    //   print(' mensaje2:' + (payload.containsKey('mensaje2') ? payload['mensaje2'] : 'No hay'));
    // });


    
  }

  void disconnect() {
    this._socket?.disconnect();
  }

}