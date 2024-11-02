import 'package:flutter/material.dart';
import 'package:foodies/model/products_model.dart';
import 'package:foodies/services/api_home_services.dart';
import 'package:foodies/services/apiservices.dart';
import 'package:foodies/services/models/api_details_services.dart';

class Detailsviewmodel extends ChangeNotifier {
  final DetailsApiService _apiService = DetailsApiService();
  final ApihomeService _homeservice = ApihomeService();
  List<Product> _products = [];
  List<Product> categoryproducts = [];
  bool _isLoading = false;

  List<Product> get products => _products;
  bool get isLoading => _isLoading;

  Future<void> fetchProducts() async {
    _isLoading = true;
    notifyListeners();

    try {
      _products = await _apiService.fetchProducts();
      print(_products);
    } catch (e) {
      print("Error fetching products: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchProductsByCategoryId(String categoryId) async {
    _isLoading = true;
    notifyListeners();

    try {
      categoryproducts =
          await _homeservice.fetchProductsByCategoryId(categoryId);
      print('------------------------------------------------------');
      print(categoryproducts);
    } catch (error) {
      print("Error fetching products: $error");
      // Handle errors as needed
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
