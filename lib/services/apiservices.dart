import 'dart:convert'; // For jsonEncode
import 'package:foodies/utils/apiconst.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  // Function to register a user
  Future<void> registerUser({
    required String username,
    required String password,
    required String email,
    required String phone,
  }) async {
    final String url = '$baseurl/registration/';
    print(url);

    // Prepare the registration data
    final Map<String, String> registrationData = {
      'username': username,
      'password': password,
      'email': email,
      'phone': phone
    };

    print(registrationData);

    try {
      // Make the HTTP POST request
      final response = await http.post(
        Uri.parse(url),
        body: registrationData,
      );

      if (response.statusCode == 200) {
        print('Registration successful: ${response.body}');
      } else {
        String message = jsonDecode(response.body)['message'];

        throw Exception(message);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> loginUser({
    required String password,
    required String email,
  }) async {
    final String url = '$baseurl/login/';
    print(url);

    // Prepare the registration data
    final Map<String, String> logindata = {
      'password': password,
      'email': email,
    };

    print(logindata);

    try {
      // Make the HTTP POST request
      final response = await http.post(
        Uri.parse(url),
        body: logindata,
      );

      if (response.statusCode == 200) {
        print('Registration successful: ${response.body}');

        final decodeddata = jsonDecode(response.body);

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString(
          'isLoggedIn',decodeddata['data']['login_id'].toString()
        );
      } else {
        String message = jsonDecode(response.body)['message'];

        throw Exception(message);
      }
    } catch (e) {
      rethrow;
    }
  }
}
