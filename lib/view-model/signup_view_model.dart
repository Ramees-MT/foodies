import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodies/routes/route_names.dart';
import 'package:foodies/services/apiservices.dart';
import 'package:foodies/services/firebase_authservices.dart';


class Signupviewmodel extends ChangeNotifier {
  final _firebaseauthservice = Firebaseauthservices();

  bool loading = false;

  // Method to set loading state
  void setLoading(bool value) {
    loading = value;
    notifyListeners(); // Notify listeners to update the UI
  }

  // Signup with Google and manage loading state
  Future<void> Signupwithgoogle(BuildContext context) async {
    setLoading(true); // Start loading
    try {
      await _firebaseauthservice.Signinwithgoogle();
      Navigator.pushNamed(context, AppRoutes.bottomnavpage);
    } on FirebaseAuthException catch (e) {
      // Handle Firebase Auth exceptions if needed
      print(e.message);
    } catch (e) {
      // Handle other types of exceptions if needed
      print(e.toString());
    } finally {
      setLoading(false); // Stop loading
    }
  }
  Future<void> register(
      {
      required String phone,

      required String email,

        required String username,
      required String password,
      required BuildContext context}) async {
    setLoading(true);
    try {
      await ApiService().registerUser(
        username: username,
        email: email,
        phone: phone,
        password: password,
       
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Register success'),
        ));
      Navigator.pushNamed(context, AppRoutes.bottomnavpage);

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
        
      );

    } finally {
      setLoading(false); // Stop loading
    }
  }
  
}
