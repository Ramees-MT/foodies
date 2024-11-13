import 'package:flutter/material.dart';
import 'package:foodies/model/cart_model.dart';
import 'package:foodies/services/api_cart_services.dart';
import 'package:http/http.dart'
    as http; // Import the http package for API requests
import 'dart:convert'; // Import to parse the JSON response

class CartViewModel extends ChangeNotifier {
  final CartService _cartService = CartService();

  bool _isLoading = false;
  String _message = '';
  bool _success = false;

  bool get isLoading => _isLoading;
  String get message => _message;
  bool get success => _success;

  List<Cart> _cartItems = [];

  List<Cart> get cartItems => _cartItems;

  // Method to add item to the cart
  Future<void> addToCart(
      {required String itemId, required String userId}) async {
    _isLoading = true;
    _message = '';
    notifyListeners();

    try {
      // Call the API function to add item to the cart
      final result =
          await _cartService.addToCart(itemId: itemId, userId: userId);

      if (result['success']) {
        _success = true;
        _message = "Item added to cart successfully!";
      } else {
        _success = false;
        _message = "Failed to add item to cart: ${result['error']}";
      }
    } catch (e) {
      _success = false;
      _message = "An error occurred: $e";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Method to fetch cart items from the API
  Future<void> fetchCartItems(int userId) async {
    _isLoading = true;
    notifyListeners();

    try {
      _cartItems = await _cartService.fetchCartItems(userId);
    } catch (error) {
      _cartItems = [];
      notifyListeners();

      print("Error fetching cart items: $error");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Method to increment item quantity in the cart
  Future<void> incrementItemQuantity(String itemId, String userId) async {
    _isLoading = true;
    notifyListeners();

    try {
      if (await _cartService.incrementItemQuantity(itemId, userId)) {
        _updateItemQuantity(itemId, 1);
      } else {
        throw Exception("Failed to increment item");
      }
    } catch (e) {
      print(e); // Log the error
    }

    _isLoading = false;
    notifyListeners();
  }

  // Method to decrement item quantity in the cart
  Future<void> decrementItemQuantity(String itemId, String userId) async {
    _isLoading = true;
    notifyListeners();

    try {
      if (await _cartService.decrementItemQuantity(itemId, userId)) {
        _updateItemQuantity(itemId, -1);
      } else {
        throw Exception("Failed to decrement item");
      }
    } catch (e) {
      print(e); // Log the error
    }

    _isLoading = false;
    notifyListeners();
  }

  // Helper method to update the quantity of an item in the cart
  void _updateItemQuantity(String itemId, int change) {
    for (var item in _cartItems) {
      if (item.itemid == itemId) {
        item.quantity = (item.quantity ?? 0) + change;
        notifyListeners();
        break;
      }
    }
  }

  // Method to remove item from the cart using an API call
  Future<void> removeItemFromCart(int id) async {
    try {
      _isLoading = true;
      notifyListeners();

      final String apiUrl =
          "https://fooddelivery-e7mz.onrender.com/deletecart/$id";
      final response = await http.delete(Uri.parse(apiUrl));
      print(response.statusCode);
      if (response.statusCode == 200) {
        // If the item is successfully deleted, remove it from the list
        _cartItems.removeWhere((item) => item.id == id);
        print(_cartItems);
        print('hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh');
        _message = "Item removed from cart successfully!";
      } else {
        _message = 'Failed to delete item: ${response.statusCode}';
      }
    } catch (e) {
      _message = 'Error: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
