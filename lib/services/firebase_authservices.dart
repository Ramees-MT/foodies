import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Firebaseauthservices {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? _user;
  Future<void> Signinwithgoogle() async {
    try {
      print('999999999999999999');
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return; // User canceled the sign-in

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      print('==============ooooooooooooo==========');

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      print('========================');

      UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      _user = userCredential.user;
      print('---------------------------------------');

      print(_user!.email);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      await _googleSignIn.signOut();
    } catch (e) {
      rethrow;
    }
  }
}
