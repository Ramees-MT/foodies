import 'package:flutter/material.dart';
import 'package:foodies/model/cart_model.dart';
import 'package:foodies/services/api_cart_services.dart';

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

  Future<void> fetchCartItems() async {
    _isLoading = true;
    notifyListeners();

    try {
      _cartItems = await _cartService.fetchCartItems();
    } catch (error) {
      print("Error fetching cart items: $error");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> incrementItemQuantity(String itemId,String userId) async {
    _isLoading = true;
    notifyListeners();

    try {
      if (await _cartService.incrementItemQuantity(itemId,  userId)) {
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

  Future<void> decrementItemQuantity(String itemId,String userId) async {
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

  void _updateItemQuantity(String itemId, int change) {
    for (var item in _cartItems) {
      if (item.itemid == itemId) {
        item.quantity = (item.quantity ?? 0) + change;
        notifyListeners();
        break;
      }
    }
  }
}
