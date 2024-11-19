import 'package:flutter/material.dart';
import 'package:foodies/services/order_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlaceOrderViewModel extends ChangeNotifier {
  bool isLoading = false;
  String? errorMessage;
  String? successMessage;
  Map<String, dynamic>? orderData; // Stores the order data

  final OrderService _apiService = OrderService();

  // Method to place an order
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

      // Call the API to place the order
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

  // Method to view a specific order
  Future<void> viewOrder(int userId) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      // Fetch the order data
      final response = await _apiService.fetchOrder(userId);
      print('Order response: $response'); // Debug: check response structure
      
      if (response != null && response.containsKey('data')) {
        orderData = response;
        errorMessage = null;
      } else {
        errorMessage = 'No order data available.';
        orderData = null;
      }
    } catch (e) {
      errorMessage = 'Failed to load order: ${e.toString()}';
      orderData = null;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}