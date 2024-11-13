import 'package:foodies/model/address_model.dart';
import 'package:foodies/utils/apiconst.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
 // Import the Address model

class AddressApiService {
  

  // Function to add a new address
  Future<bool> addAddress(Address address) async {
    final url = Uri.parse('$baseurl/addaddress/');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(address.toJson()), // Convert Address to JSON
    );

    if (response.statusCode == 201) {
      return true; // Address added successfully
    } else {
      // Handle error
      throw Exception('Failed to add address');
    }
  }

   // Function to fetch addresses
  Future<List<Address>> fetchAddresses(int userId) async {
    final response = await http.get(Uri.parse('$baseurl/viewalladdress/'));

    if (response.statusCode == 200) {
      // Parse the JSON response
      final Map<String, dynamic> data = json.decode(response.body); // Decode the response as a map

      // Access the "data" key from the map to get the list of addresses
      if (data.containsKey('data')) {
        List<dynamic> addressesList = data['data']; // The list of addresses is under the "data" key

        // Return the list of Address objects by mapping each address in the list
        return addressesList.map((item) => Address.fromJson(item)).toList();
      } else {
        throw Exception('Addresses key not found in the response');
      }
    } else {
      throw Exception('Failed to load addresses');
    }
  }
  
}
Future<String?> updateAddress({
    required int userId,
    required int id,
    required String name,
    required String street,
    required String city,
    required String state,
    required String country,
    required String postalCode,
    required int userid,
  }) async {
    final url = Uri.parse("$baseurl/updateaddress/$userId/");
    final response = await http.patch(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "id": id,
        "name": name,
        "street": street,
        "city": city,
        "state": state,
        "country": country,
        "postal_code": postalCode,
        "userid": userid,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data["message"];
    } else {
      return "Failed to update address: ${response.statusCode}";
    }
  }


