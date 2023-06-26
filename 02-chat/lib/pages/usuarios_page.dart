import 'package:chat/services/usuarios_service.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:provider/provider.dart';

import 'package:chat/services/chat_service.dart';
import 'package:chat/services/auth-service.dart';
import 'package:chat/services/socket_service.dart';

import 'package:chat/models/usuario.dart';


class UsuariosPage extends StatefulWidget {

  @override
  State<UsuariosPage> createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {

  RefreshController _refreshController = RefreshController(initialRefresh: false);

  final usuarioService = UsuariosService();
  List<Usuario> usuarios = [];
  
  // [
  //     Usuario(online: true, email: 'pepito1@gmail.com', nombre: 'pepe1', uid: '1'),
  //     Usuario(online: true, email: 'pepito2@gmail.com', nombre: 'pepe2', uid: '2'),
  //     Usuario(online: false, email: 'pepito3@gmail.com', nombre: 'pepe3', uid: '3'),
  //     Usuario(online: false, email: 'pepito4@gmail.com', nombre: 'pepe4', uid: '4')
  // ];

  @override
  void initState() {
    this._cargarUsuarios();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final socketService = Provider.of<SocketService>(context);

    final authService = Provider.of<AuthService>(context);
    final usuario = authService.usuario;

    return Scaffold(
      appBar: AppBar(
        title: Text(usuario?.nombre ?? 'Sin nombre', style: const TextStyle( color: Colors.black54 ),),
        elevation: 1,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon( Icons.exit_to_app, color: Colors.black54, ),
          onPressed: () {
            socketService.disconnect();
            Navigator.pushReplacementNamed(context, 'login');
            AuthService.deleteToken();
          },
        ),
        actions: [
          Container(
            margin: EdgeInsets.only( right: 10 ),
            // child: Icon( Icons.check_circle, color: Colors.blue, ),
            child: ( socketService.serverStatus == ServerStatus.onLine ) ? 
              Icon( Icons.check_circle, color: Colors.blue[300]) :
              (socketService.serverStatus == ServerStatus.connecting) ? 
                  Icon( Icons.album_outlined, color: Colors.green ) : 
                  Icon( Icons.offline_bolt, color: Colors.red )

          )
        ],
      ),
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        onRefresh: _cargarUsuarios,
        header: WaterDropHeader(
          complete: Icon( Icons.check, color: Colors.blue[400] ),
          waterDropColor: Colors.blue[400]!,
        ),
        child: _listViewUsuarios(),
      )
   );
  }

  ListView _listViewUsuarios() {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder: (_, i) => _usuarioListTile( usuarios[i] ), 
      separatorBuilder: (_, i) => Divider(), 
      itemCount: usuarios.length
    );
  }

  ListTile _usuarioListTile(Usuario usuario) {
    return ListTile(
        title: Text(usuario.nombre),
        subtitle: Text(usuario.email),
        leading: CircleAvatar( 
          child: Text(usuario.nombre.substring(0,2)),
          backgroundColor: Colors.blue[100],
         ),
         trailing: Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: ( usuario.online ) ? Colors.green[300] : Colors.red,
            borderRadius: BorderRadius.circular(100)
          ),
         ),
         onTap: () {
          print(usuario.nombre);
          final chatService = Provider.of<ChatService>(context, listen: false);
          chatService.usuarioTo = usuario;
          Navigator.pushNamed(context, 'chat');
         },
      );
  }

  void _cargarUsuarios() async{
    usuarios = (await usuarioService.getUsuarios()) ?? [];
    setState(() {});
    //await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }
}