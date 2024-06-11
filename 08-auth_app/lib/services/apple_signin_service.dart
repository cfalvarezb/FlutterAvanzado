import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AppleSingInService {

  static String cliendId = 'com.example.service';
  static String redirectUri = 'https://googlesignin-2r08.onrender.com/callbacks/sign_in_with_apple';

  static void signIn() async {
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        webAuthenticationOptions: WebAuthenticationOptions(
          clientId: cliendId,
          redirectUri: Uri.parse(redirectUri)
        )
      );

      print(credential);
      print(credential.authorizationCode);// ID Token google
      // Now send the credential (especially `credential.authorizationCode`) to your server to create a session
      // after they have been validated with Apple (see `Integration` section for more information on how to do this)
      final signInWithAppleEndpoint = Uri(
        scheme: 'https',
        host: 'googlesignin-2r08.onrender.com',
        path: '/sign_in_with_apple',
        queryParameters: {
          'code': credential.authorizationCode,
          'firstName': credential.givenName,
          'lastName': credential.familyName,
          'useBundleId': Platform.isIOS ? 'true' : 'false',
          if ( credential.state != null ) 'state': credential.state
        }
      );

      final session = await http.post(signInWithAppleEndpoint);

      print('Response of my service');
      print(session.body);
    } catch (e) {
      print('Error on signIn');
      print(e.toString());
    }
  }

}