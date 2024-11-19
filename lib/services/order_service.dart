import 'dart:convert';

import 'package:foodies/utils/apiconst.dart';
import 'package:http/http.dart' as http;

class OrderService {
  Future<Map<String, dynamic>> placeOrder(String userId, String itemid) async {
    final url = Uri.parse('$baseurl/placeorder/$userId');

    print(url);

    // Prepare the body as form data if JSON is not expected
    final body = {
      'itemid': itemid,
    };

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: body,
      );
      print(response);
      print(response.statusCode);

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to place order');
      }
    } catch (e) {
      throw Exception('Error placing order: $e');
    }
  }

  Future<Map<String, dynamic>> fetchOrder(int userId) async {
    final response = await http.get(Uri.parse('$baseurl/vieworder/$userId'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load order');
    }
  }
}
