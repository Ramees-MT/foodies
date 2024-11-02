import 'package:flutter/material.dart';
import 'package:foodies/model/category_model.dart';
import 'package:foodies/model/offers_model.dart';
import 'package:foodies/model/products_model.dart';
import 'package:foodies/services/api_home_services.dart';

// Import ApiService

class HomeviewModel extends ChangeNotifier {
  final ApihomeService _apiService = ApihomeService();

  List<Category> _categories = [];
  List<Category> get categories => _categories;
  String? _errorMessage;
  String? get errorMessage => _errorMessage;
  List<Offers> _offersList = [];
  List<Offers> get offersList => _offersList;
  List<Product> _products = [];
  List<Product> get products => _products;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> fetchCategories() async {
    _isLoading = true;
    notifyListeners();
    try {
      // Use ApiService to fetch categories
      _categories = await _apiService.fetchCategories();

      print(_categories);
    } catch (error) {
      print("Error fetching categories: $error");
    } finally {
      _isLoading = false; // Set loading to false in finally block
      notifyListeners(); // Notify listeners about the change
    }
  }

  Future<void> fetchOffers() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _offersList = await _apiService.fetchOffers();
      print(offersList);
    } catch (error) {
      _errorMessage = "Error fetching offers: $error";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  
}

