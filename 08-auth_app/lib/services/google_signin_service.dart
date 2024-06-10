import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as  http;

class GoogleSignInService {


  static final GoogleSignIn _googleSignIn = GoogleSignIn(
      // Optional clientId
      serverClientId: '734847631308-fhcp4vkpllldeftqik7qorodb2o43102.apps.googleusercontent.com',
      scopes: [
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );

  static Future<GoogleSignInAccount?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? account = await _googleSignIn.signIn();
      final googleKey = await account?.authentication;

      print('ID TOKEN');
      print(googleKey?.idToken);
      print(account);

      // TODO: Call a rest service to own backend
      final signInWithGoogleEndpoint = Uri(
        scheme: 'https',
        host: 'apple-google-sign-in.herokuapp.com',
        path: '/google'
      );

      return account;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future signOut() async {
    await _googleSignIn.signOut();
  }

}