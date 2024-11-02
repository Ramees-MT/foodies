import 'dart:convert';
import 'package:foodies/model/category_model.dart';
import 'package:foodies/model/offers_model.dart';
import 'package:foodies/model/products_model.dart';
import 'package:foodies/utils/apiconst.dart';
import 'package:http/http.dart' as http;

class ApihomeService {
  // Replace with your actual API base URL
  Future<List<Category>> fetchCategories() async {
    final String url = '$baseurl/view_item_category/';
    print("Fetching categories from: $url");

    try {
      // Make the HTTP GET request
      final response = await http.get(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);

        if (data['success'] == true) {
          final List<dynamic> categoriesJson = data['data'];

          // Map each JSON object to a Category object
          return categoriesJson.map((json) => Category.fromJson(json)).toList();
        } else {
          throw Exception('Failed to fetch categories: ${data['message']}');
        }
      } else {
        throw Exception(
            'Failed to fetch categories, Status code: ${response.statusCode}');
      }
    } catch (e) {
      print("Error fetching categories: $e");
      rethrow;
    }
  }

  Future<List<Offers>> fetchOffers() async {
    final String url =
        '$baseurl/view_offers_items/'; // Replace with your actual endpoint
    print("Fetching offers from: $url");

    try {
      // Make the HTTP GET request
      final response = await http.get(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);

        // Check if the response indicates success
        if (data['success'] == true) {
          final List<dynamic> offersJson = data['data'];

          // Map each JSON object to an Offers object
          return offersJson.map((json) => Offers.fromJson(json)).toList();
        } else {
          throw Exception('Failed to fetch offers: ${data['message']}');
        }
      } else {
        throw Exception(
            'Failed to fetch offers, Status code: ${response.statusCode}');
      }
    } catch (e) {
      print("Error fetching offers: $e");
      rethrow;
    }
  }

  Future<List<Product>> fetchProductsByCategoryId(String categoryId) async {
    final response =
        await http.get(Uri.parse('$baseurl/items/category/$categoryId/'));
    print('fffffffffffffffffffffffffff');
    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['data'];
      print('object');
      final CategoryList =
          data.map<Product>((json) => Product.fromJson(json)).toList();
      print('gggggggggggggggggggggggggggggggggggggggggggggggggg');

      return CategoryList;
    } else {
      throw Exception('Failed to load products');
    }
  }
}
