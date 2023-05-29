import 'dart:io';

import 'package:chat/widgets/chat_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin{

  final _textController = TextEditingController();
  final _focusNode = FocusNode();

  final List<ChatMessage> _messages = [];

  bool _estaEscribiendo = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Column(
          children: [
            SizedBox( height: 3 ),
            CircleAvatar(
              child: Text('TE', style: TextStyle( fontSize: 12 )),
              backgroundColor: Colors.blue[100],
              maxRadius: 13,
            ),
            SizedBox( height: 3 ),
            Text('Melisa flores', style: TextStyle( color: Colors.black87, fontSize: 10 ),)
          ],
        ),
        centerTitle: true,
        elevation: 1,
      ),
      body: Container(
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: this._messages.length,
                itemBuilder: (_, i) => this._messages[i],
                reverse: true,
              )
            ),
            Divider( height: 5 ),
            //TODO Caja de texto
            Container(
              color: Colors.white,
              height: 50,
              child: _inputChat(),
            )
          ],
        ),
      ),
   );
  }

  Widget _inputChat(){
    return SafeArea(
      child: Container(
        margin: EdgeInsets.symmetric( horizontal: 8 ),
        child: Row(
          children: [
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: (value) {
                  
                },
                onChanged: (value) {
                  validateIsTypping(value);
                },
                decoration: InputDecoration.collapsed(
                  hintText: 'Enviar Mensaje'
                ),
                focusNode: _focusNode,
              )
            ),

            //Boton de enviar
            Container(
              margin: EdgeInsets.symmetric( horizontal: 4.0 ),
              child: Platform.isIOS 
              ? CupertinoButton(
                  child: Text('Enviar'),
                  onPressed: _estaEscribiendo 
                      ? () => _handleSubmit(_textController.text.trim()) 
                      : null,
                )
              : Container(
                margin: EdgeInsets.symmetric( horizontal: 4.0 ),
                child: IconTheme(
                  data: IconThemeData(
                    color: Colors.blue[400]
                  ),
                  child: IconButton(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    icon: Icon( Icons.send ),
                    onPressed: _estaEscribiendo 
                      ? () => _handleSubmit(_textController.text.trim())
                      : null
                  ),
                ),
              )
            )

          ],
        ),
      )
    );
  }

  void _handleSubmit( String text ){

    if ( text.length == 0 ) return;

    print(text);
    _textController.clear();
    _focusNode.requestFocus();

    final newMessage = ChatMessage(
      texto: 
      text, 
      uid: '123',
      animationController: AnimationController(
        vsync: this,
        duration: Duration( milliseconds: 400 )
      ),
    );
    _messages.insert( 0, newMessage );
    newMessage.animationController.forward();

    setState(() {
      _estaEscribiendo = false;
    });
  }
  
  void validateIsTypping( String value ) {
    setState(() {
      if ( value.trim().length > 0 ) {
        _estaEscribiendo = true;
      } else {
        _estaEscribiendo = false;
      }
    });  
  }

  @override
  void dispose() {
    // TODO: Off of socket
    for( ChatMessage message in _messages ) {
      message.animationController.dispose();
    }
    super.dispose();
  }

}