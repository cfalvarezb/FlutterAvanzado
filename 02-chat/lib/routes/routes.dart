
import 'package:chat/pages/chat_page.dart';
import 'package:chat/pages/loading_page.dart';
import 'package:chat/pages/login_page.dart';
import 'package:chat/pages/register_page.dart';
import 'package:chat/pages/usuarios_page.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> appRoutes = {

  'usuarios': (_) => UsuariosPage(),
  'register': (_) => RegisterPage(),
  'login': (_) => LoginPage(),
  'chat': (_) => ChatPage(),
  'loading': (_) => LoadingPage()
  
};