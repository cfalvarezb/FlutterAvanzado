import 'package:flutter/material.dart';

class BotonAzul extends StatelessWidget {

  final String text;
  final Function()? onPressed;

  const BotonAzul({
    super.key,
    required this.text,
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
            style: ButtonStyle( 
                elevation: MaterialStateProperty.all(2),
                backgroundColor: MaterialStatePropertyAll(Colors.black87),
                shape: MaterialStatePropertyAll(StadiumBorder())
            ),
            onPressed: onPressed,
            child: Container(
              width: double.infinity,
              height: 50,
              child: Center(
                child: Text(text, style: TextStyle( fontSize: 16 ), ),
              ),
            ),
          );
  }
}