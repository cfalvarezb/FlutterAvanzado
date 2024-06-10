import 'package:flutter/material.dart';

class CustomSnackBar extends SnackBar {

  CustomSnackBar({
    super.key,
    required String message,
    String btnLabel = 'OK',
    super.duration = const Duration( seconds: 2 ),
    VoidCallback? onOk
  }) : super (
    content: Text(message),
    action: SnackBarAction(label: btnLabel, onPressed: (){
      if ( onOk != null ) {
        onOk();
      }
    })
  );

} 