import 'package:flutter/material.dart';
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

  SocketService() {
    this._initConfig();
  }
  
  void _initConfig() {
    // Dart client
    _socket = IO.io('https://example-flutter-advance.onrender.com', {
      'transports': ['websocket'],
      'autoConnect': true
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

}