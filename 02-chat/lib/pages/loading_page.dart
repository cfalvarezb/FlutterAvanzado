import 'package:flutter/material.dart';

import 'package:chat/pages/login_page.dart';
import 'package:chat/pages/usuarios_page.dart';

import 'package:chat/services/auth-service.dart';
import 'package:chat/services/socket_service.dart';

import 'package:provider/provider.dart';


class LoadingPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: checkLoginState( context ),
        builder: (context, snapshot) {
          return Center(
            child: Text('Espere...'),
          );
        },
      ),
   );
  }

  Future checkLoginState( BuildContext context ) async {

    final authService = Provider.of<AuthService>(context, listen: false);
    final authenticate = await authService.isLoggedIn();

    final socketService = Provider.of<SocketService>(context, listen: false);

    if ( authenticate ) {
      //Navigator.pushNamed(context, 'usuarios');
      //Another way to do navigation
      socketService.connect();
      Navigator.pushReplacement(
        context, 
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => UsuariosPage(),
          transitionDuration: Duration( milliseconds: 0 )
        )
      );
    } else {
      Navigator.pushReplacement(
        context, 
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => LoginPage(),
          transitionDuration: Duration( milliseconds: 0 )
        )
      );
    }

  }
}