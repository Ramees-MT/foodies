import 'package:flutter/material.dart';
import 'package:foodies/model/address_model.dart';
import 'package:foodies/services/api_adress_services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddressViewModel extends ChangeNotifier {
  final AddressApiService _apiService = AddressApiService();
  bool _isLoading = false;
  String? _errorMessage;
  List<Address> _addresses = [];

  Address? selectedaddress;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<Address> get addresses => _addresses;

  // Function to add a new address
  Future<void> addAddress(Address address, BuildContext context) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      bool success = await _apiService.addAddress(address);
      if (success) {
        _showSnackBar(context, 'Address added successfully');
        fetchAddresses(address.userid!); // Fetch updated list after adding
      }
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Function to fetch addresses
  Future<void> fetchAddresses(int userId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final url = Uri.parse(
        'https://fooddelivery-e7mz.onrender.com/viewaddress/$userId/');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['data'];
        _addresses =
            data.map((addressData) => Address.fromJson(addressData)).toList();
      } else {
        _errorMessage = 'Failed to load addresses';
      }
    } catch (error) {
      _errorMessage = 'An error occurred: $error';
    }

    _isLoading = false;
    notifyListeners();
  }

  // Function to update an address
  Future<void> updateAddress(
      int userId, Address address, BuildContext context) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final url = Uri.parse(
        'https://fooddelivery-e7mz.onrender.com/updateaddress/${address.id}/'); // Make sure this endpoint exists
    try {
      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'name': address.name,
          'street': address.street,
          'city': address.city,
          'state': address.state,
          'country': address.country,
          'postal_code': address.postalCode,
        }),
      );

      if (response.statusCode == 200) {
        await fetchAddresses(userId);
        _errorMessage = null;
        notifyListeners();
      } else {
        _errorMessage = 'Failed to update address';
        notifyListeners();
      }
    } catch (error) {
      _errorMessage = 'An error occurred: $error';
      notifyListeners();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Function to delete an address
  Future<void> deleteAddress(int addressId, BuildContext context) async {
    final url =
        'https://fooddelivery-e7mz.onrender.com/deleteaddress/$addressId/';

    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      final response = await http.delete(Uri.parse(url));

      // Log the response status and body for debugging
      print('Delete Response Status: ${response.statusCode}');
      print('Delete Response Body: ${response.body}');

      if (response.statusCode == 200) {
        // Remove the address from the list if deletion is successful
        _addresses.removeWhere((address) => address.id == addressId);

        // Check if the widget is still mounted before showing a SnackBar
        if (context.mounted) {
          _showSnackBar(context, 'Address deleted successfully');
        }
      } else {
        _errorMessage = 'Failed to delete address: ${response.reasonPhrase}';
        print("Delete Error: $_errorMessage");
      }
    } catch (e) {
      _errorMessage = 'An error occurred: $e';
      print("Exception during deleteAddress: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Function to show snack bar messages
  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  void setAddress({required Address address}) {
    selectedaddress = address;
    notifyListeners();
  }
}
