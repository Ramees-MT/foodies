import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:foodies/view-model/address_view_model.dart';
import 'package:foodies/model/address_model.dart';

class EditAddressScreen extends StatefulWidget {
  final int userId; // User ID parameter
  final Address address;

  EditAddressScreen({required this.userId, required this.address});

  @override
  _EditAddressScreenState createState() => _EditAddressScreenState();
}

class _EditAddressScreenState extends State<EditAddressScreen> {
  late TextEditingController nameController;
  late TextEditingController streetController;
  late TextEditingController cityController;
  late TextEditingController stateController;
  late TextEditingController countryController;
  late TextEditingController postalCodeController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.address.name);
    streetController = TextEditingController(text: widget.address.street);
    cityController = TextEditingController(text: widget.address.city);
    stateController = TextEditingController(text: widget.address.state);
    countryController = TextEditingController(text: widget.address.country);
    postalCodeController = TextEditingController(text: widget.address.postalCode);
  }

  @override
  void dispose() {
    nameController.dispose();
    streetController.dispose();
    cityController.dispose();
    stateController.dispose();
    countryController.dispose();
    postalCodeController.dispose();
    super.dispose();
  }

  void _saveAddress() async {
    final updatedAddress = Address(
      id: widget.address.id,
      name: nameController.text,
      street: streetController.text,
      city: cityController.text,
      state: stateController.text,
      country: countryController.text,
      postalCode: postalCodeController.text,
    );

    final addressViewModel = Provider.of<AddressViewModel>(context, listen: false);

    await addressViewModel.updateAddress(widget.userId, updatedAddress,context);

    if (addressViewModel.errorMessage == null) {
      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Address updated successfully')),
      );
      Navigator.pop(context); // Go back after successful update
    } else {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(addressViewModel.errorMessage ?? 'Failed to update address')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final addressViewModel = Provider.of<AddressViewModel>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Address'),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: addressViewModel.isLoading
          ? Center(child: CircularProgressIndicator(color: Colors.green))
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      labelStyle: TextStyle(color: Colors.green),
                    ),
                    style: TextStyle(color: Colors.white),
                  ),
                  TextField(
                    controller: streetController,
                    decoration: InputDecoration(
                      labelText: 'Street',
                      labelStyle: TextStyle(color: Colors.green),
                    ),
                    style: TextStyle(color: Colors.white),
                  ),
                  TextField(
                    controller: cityController,
                    decoration: InputDecoration(
                      labelText: 'City',
                      labelStyle: TextStyle(color: Colors.green),
                    ),
                    style: TextStyle(color: Colors.white),
                  ),
                  TextField(
                    controller: stateController,
                    decoration: InputDecoration(
                      labelText: 'State',
                      labelStyle: TextStyle(color: Colors.green),
                    ),
                    style: TextStyle(color: Colors.white),
                  ),
                  TextField(
                    controller: countryController,
                    decoration: InputDecoration(
                      labelText: 'Country',
                      labelStyle: TextStyle(color: Colors.green),
                    ),
                    style: TextStyle(color: Colors.white),
                  ),
                  TextField(
                    controller: postalCodeController,
                    decoration: InputDecoration(
                      labelText: 'Postal Code',
                      labelStyle: TextStyle(color: Colors.green),
                    ),
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _saveAddress,
                    child: Text('Save'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}