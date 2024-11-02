import 'dart:convert';
import 'package:foodies/utils/apiconst.dart';
import 'package:http/http.dart' as http;

import 'package:foodies/model/products_model.dart';

class DetailsApiService {
  // Replace with your actual API base URL

  Future<List<Product>> fetchProducts() async {
    print('fffffffffffffffffffffffffffff');
    final response = await http.get(Uri.parse('$baseurl/view_food_items/'));
    print(response.statusCode);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['data'];
      print(data);
      return data.map<Product>((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load products");
    }
  }
}
