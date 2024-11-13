// food_view_model.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:foodies/model/products_model.dart';

import 'package:http/http.dart' as http;

class FoodViewModel extends ChangeNotifier {
  List<Product> _foods = [];
  bool _isLoading = false;
  String _errorMessage = '';

  List<Product> get foods => _foods;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  Future<void> fetchFoods(String query) async {
    if (query.isEmpty) {
      _foods = [];
      notifyListeners();
      return;
    }

    final String url =
        'https://fooddelivery-e7mz.onrender.com/search/?search_query=$query';

    try {
      _isLoading = true;
      _errorMessage = ''; // Clear any previous error messages
      notifyListeners();

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        if (data['success']) {
          final List<dynamic> suggestions = data['suggestion'];
          _foods = suggestions.map((item) => Product.fromJson(item)).toList();
          print(_foods);
        } else {
          _errorMessage = data['message'] ?? 'Failed to fetch foods';
        }
      } else {
        _errorMessage = 'Failed to load search results';
      }
    } catch (e) {
      _errorMessage = 'Error fetching foods: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
