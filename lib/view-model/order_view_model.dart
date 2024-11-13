import 'package:flutter/material.dart';
import 'package:foodies/services/order_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlaceOrderViewModel extends ChangeNotifier {
  bool isLoading = false;
  String? errorMessage;
  String? successMessage;
  Map<String, dynamic>? orderdata; // Define 'orderdata' here

  final OrderService _apiService = OrderService();

  Future<void> placeOrder(String itemId) async {
    isLoading = true;
    errorMessage = null;
    successMessage = null;
    notifyListeners();

    try {
      // Retrieve logged-in user ID from SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? logId = prefs.getString('isLoggedIn');

      if (logId == null) {
        throw Exception("User not logged in");
      }

      // Call the API
      final response = await _apiService.placeOrder(logId, itemId);
      print(response);

      // Check if the order was successful
      if (response['success'] == true) {
        successMessage = 'Order placed successfully!';
      } else {
        errorMessage = 'Failed to place order. Please try again.';
      }
    } catch (e) {
      errorMessage = 'Error placing order: $e';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadOrder(int orderId) async {
    isLoading = true;
    notifyListeners();

    try {
      orderdata = await _apiService.fetchOrder(orderId);
      errorMessage = null;
    } catch (e) {
      errorMessage = 'Failed to load order: ${e.toString()}';
    }

    isLoading = false;
    notifyListeners();
  }

  void clearMessages() {
    errorMessage = null;
    successMessage = null;
    notifyListeners();
  }
}
