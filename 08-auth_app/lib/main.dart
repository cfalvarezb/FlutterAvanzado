import 'package:auth_app/services/apple_signin_service.dart';
import 'package:auth_app/services/google_signin_service.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AuthApp - Google - Apple ',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Material App Bar'),
          actions: [
            IconButton(
              onPressed: () {
                //TODO Sing out
                GoogleSignInService.signOut();
              }, 
              icon: const Icon( FontAwesomeIcons.doorOpen )
            )
          ],
        ),
        body: Container(
          padding: const EdgeInsets.all(10),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaterialButton(
                  splashColor: Colors.transparent,
                  minWidth: double.infinity,
                  height: 40,
                  color: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon( FontAwesomeIcons.google, color: Colors.white ),
                      Text(
                        'Sing with google', 
                        style: TextStyle( 
                          color: Colors.white, 
                          fontSize: 17 
                        ),
                      )
                    ],
                  ),
                  onPressed: () {
                    //TODO Sign in with google
                    GoogleSignInService.signInWithGoogle();
                  }
                ),
                const SignInWithAppleButton(
                    onPressed: AppleSingInService.signIn
                )
              ],
            ),
          ),
        )
      ),
    );
  }
}