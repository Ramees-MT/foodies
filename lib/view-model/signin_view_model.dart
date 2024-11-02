import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodies/routes/route_names.dart';
import 'package:foodies/services/apiservices.dart';
import 'package:foodies/services/firebase_authservices.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import SharedPreferences

class SigninViewModel extends ChangeNotifier {
  final _firebaseauthservice = Firebaseauthservices();
  bool loading = false;

  // Method to set loading state
  void setLoading(bool value) {
    loading = value;
    notifyListeners(); // Notify listeners to update the UI
  }

  // Method to save login state using SharedPreferences
  Future<String?> saveLoginState(bool isLoggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', isLoggedIn);
    return prefs.getString('userId');
  }

  // Method to sign in with Google and manage loading state
  Future<void> signinWithGoogle(BuildContext context) async {
    setLoading(true); // Start loading
    try {
      await _firebaseauthservice.Signinwithgoogle();
      
      // Save the login state as true
     

      // Navigate to the bottom navigation page
      Navigator.pushNamed(context, AppRoutes.bottomnavpage);
    } on FirebaseAuthException catch (e) {
      print(e.message);
    } catch (e) {
      print(e.toString());
    } finally {
      setLoading(false); // Stop loading
    }
  }

  // Method to log in with email and password
  Future<void> login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    setLoading(true);
    try {
      // Call the API to log in
      await ApiService().loginUser(
        email: email,
        password: password,
      );

      // Save the login state as true
  

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login success'),
        ),
      );

      // Navigate to the bottom navigation page
      Navigator.pushNamed(context, AppRoutes.bottomnavpage);
    } catch (e) {
      // Show error message
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
