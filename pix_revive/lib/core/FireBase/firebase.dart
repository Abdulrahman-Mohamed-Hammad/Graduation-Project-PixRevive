import 'package:google_sign_in/google_sign_in.dart';

class FirebaseProvider {
  static late GoogleSignIn googleAuth;

  static Future<void> init() async {
    googleAuth = GoogleSignIn.instance;
    await googleAuth.initialize();
  }

  static Future<GoogleSignInAccount?> signInwithGoogle() async {
    try {
      var result = await googleAuth.authenticate();
      return result;
    } catch (e) {
      return null;
    }
  }
}
