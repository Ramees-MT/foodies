import 'package:flutter/material.dart';
import 'package:foodies/view/addressscreen.dart';
import 'package:foodies/view/editaddressscreen.dart';
import 'package:provider/provider.dart';
import 'package:foodies/view-model/address_view_model.dart';
import 'package:foodies/model/address_model.dart';

class ProfileScreen extends StatefulWidget {
  final int userId;

  ProfileScreen({required this.userId});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<AddressViewModel>(context, listen: false)
          .fetchAddresses(widget.userId);
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Your Addresses',
          style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
        ),
      ),
      body: Consumer<AddressViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.green,
              ),
            );
          }

          if (viewModel.errorMessage != null) {
            return Center(
              child: Text(
                viewModel.errorMessage!,
                style: TextStyle(color: Colors.red, fontSize: 16),
              ),
            );
          }

          if (viewModel.addresses.isEmpty) {
            return Center(
              child: Text(
                'No addresses found',
                style: TextStyle(color: Colors.green, fontSize: 16),
              ),
            );
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: viewModel.addresses.length,
                  itemBuilder: (context, index) {
                    Address address = viewModel.addresses[index];
                    bool isSelected = viewModel.selectedaddress == address;

                    return GestureDetector(
                      onTap: () {
                        context.read<AddressViewModel>().setAddress(address: address);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: Card(
                          color: isSelected ? Colors.green : Colors.grey[900],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: BorderSide(color: Colors.green),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      address.name ?? 'No Name',
                                      style: TextStyle(
                                          color: Colors.green,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    if (isSelected)
                                      Icon(
                                        Icons.check_circle,
                                        color: Colors.white,
                                      ),
                                  ],
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Street: ${address.street ?? ''}',
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text(
                                  'City: ${address.city ?? ''}',
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text(
                                  'State: ${address.state ?? ''}',
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text(
                                  'Country: ${address.country ?? ''}',
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text(
                                  'Postal Code: ${address.postalCode ?? ''}',
                                  style: TextStyle(color: Colors.white),
                                ),
                                SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.edit, color: Colors.blue),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => EditAddressScreen(
                                              address: address,
                                              userId: widget.userId,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.delete, color: Colors.red),
                                      onPressed: () {
                                        Provider.of<AddressViewModel>(context,
                                                listen: false)
                                            .deleteAddress(address.id!, context);
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () async {
                    // Navigate to AddressScreen to add a new address
                    final Address? newAddress = await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Addressscreen()),
                    );

                    // Optionally, you can do something with the new address here
                  },
                  child: Text("Add Address"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
