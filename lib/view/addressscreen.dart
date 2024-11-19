import 'package:flutter/material.dart';
import 'package:foodies/model/address_model.dart';
import 'package:foodies/view-model/address_view_model.dart';
import 'package:foodies/view/addressdetailsscreen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Addressscreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController streetController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController postalCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final addressViewModel = Provider.of<AddressViewModel>(context);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Add address',
          style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildTextField('Name', nameController),
              buildTextField('Street', streetController),
              buildTextField('City', cityController),
              buildTextField('State', stateController),
              buildTextField('Country', countryController),
              buildTextField('Postal Code', postalCodeController),
              SizedBox(height: 20),
              addressViewModel.isLoading
                  ? CircularProgressIndicator(
                      backgroundColor: Colors.green,
                    )
                  : SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                        ),
                        onPressed: () async {
                          // Fetch the userId from SharedPreferences
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          String? logId = prefs.getString('isLoggedIn');

                          // Check if userId is available
                          if (logId != null) {
                            final newAddress = Address(
                              name: nameController.text,
                              street: streetController.text,
                              city: cityController.text,
                              state: stateController.text,
                              country: countryController.text,
                              postalCode: postalCodeController.text,
                              userid: int.tryParse(
                                  logId), // Convert logId to integer
                            );

                            addressViewModel.addAddress(newAddress, context);
                          } else {
                            // Show an error message if logId is not found
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('User ID not found')),
                            );
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      Addressdetails(userId: int.tryParse(logId!)!,),
                                ));
                          }
                        },
                        child: Text(
                          'Add Address',
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                      ),
                    ),
              if (addressViewModel.errorMessage != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    addressViewModel.errorMessage!,
                    style: TextStyle(color: Colors.red, fontSize: 14),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to build styled text fields
  Widget buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: TextField(
        controller: controller,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.green),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.green),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.green, width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
