// food_service.dart
import 'dart:convert';
import 'package:foodies/model/products_model.dart';
import 'package:foodies/utils/apiconst.dart';
import 'package:http/http.dart' as http;

class FoodService {
  Future<List<Product>> fetchFoods(String query) async {
    if (query.isEmpty) return [];

    final String url = '$baseurl/search/?search_query=$query';

    try {
      // Making an HTTP GET request
      final response = await http.get(Uri.parse(url));

      // Check if the response status code is 200 (OK)
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);

        // Check if the response indicates success and contains the 'suggestion' key
        if (jsonResponse['success'] == true && jsonResponse.containsKey('suggestion')) {
          final List<dynamic> data = jsonResponse['suggestion'];
          
          // Convert the list of dynamic items to a list of Product objects
          return data.map((item) => Product.fromJson(item)).toList();
        } else {
          // Handle unexpected response format or error messages
          final message = jsonResponse['message'] ?? 'Unexpected response format';
          throw Exception('Failed to load foods: $message');
        }
      } else {
        // Handle non-200 status codes
        throw Exception('Failed to load foods: ${response.reasonPhrase}');
      }
    } catch (e) {
      // Catch and handle any errors
      throw Exception('Error fetching foods: $e');
    }
  }
}
