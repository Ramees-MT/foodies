import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foodies/model/address_model.dart';
import 'package:foodies/view-model/address_view_model.dart';
import 'package:foodies/view-model/checkout_view_model.dart';
import 'package:foodies/view-model/order_view_model.dart';
import 'package:foodies/view/addressdetailsscreen.dart';
import 'package:foodies/view/addressscreen.dart';
import 'package:foodies/view/bottomnavscreen.dart';
import 'package:foodies/view/homescreen.dart';
import 'package:foodies/view/profilescreen.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


class CheckoutScreen extends StatefulWidget {
  final double totalAmount;

  const CheckoutScreen({Key? key, required this.totalAmount}) : super(key: key);

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String _selectedPaymentMethod = 'Credit Card';
  Address? _selectedAddress;

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AddressViewModel>();
    final placeOrderViewModel =
        context.watch<PlaceOrderViewModel>(); // Watch the PlaceOrderViewModel

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Checkout",
          style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.grey[900],
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.grey),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.grey[900],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Order Summary",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Total:",
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                  Text(
                    "\$${widget.totalAmount.toStringAsFixed(2)}",
                    style: TextStyle(color: Colors.green, fontSize: 16),
                  ),
                ],
              ),
              Divider(color: Colors.grey),
              SizedBox(height: 20),
          
              // Address Section
              Text(
                "Delivery Address",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SizedBox(height: 10),
              _selectedAddress != null
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${_selectedAddress!.street}, ${_selectedAddress!.city}, ${_selectedAddress!.state}, ${_selectedAddress!.country}",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        SizedBox(height: 8), // Added space between details
                        Text(
                          "Postal Code: ${_selectedAddress!.postalCode}",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ],
                    )
                  : provider.selectedaddress == null
                      ? Text(
                          "No address selected",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'name:  ${provider.selectedaddress!.name}',
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(height: 8), // Added space between details
                            Text(
                              'street  ${provider.selectedaddress!.street}',
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(height: 8), // Added space between details
                            Text(
                              'city:  ${provider.selectedaddress!.city}',
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(height: 8), // Added space between details
                            Text(
                              'postalcode ${provider.selectedaddress!.postalCode}',
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(height: 8), // Added space between details
                            Text(
                              'state:  ${provider.selectedaddress!.state}',
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(height: 8), // Added space between details
                            Text(
                              'country:  ${provider.selectedaddress!.country}',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
              SizedBox(height: 10),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  String? log_id = await prefs.getString('isLoggedIn');
                  // Navigate to ProfileScreen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Addressdetails(
                              userId: int.tryParse(log_id!)!,
                            )),
                  );
                },
                child: Text("Select Address from Profile"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 20),
          
              // Payment Options
              Text(
                "Payment Method",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SizedBox(height: 10),
              _buildPaymentOption(
                title: "Credit Card",
                icon: Icons.credit_card,
                method: "Credit Card",
                
              ),
              _buildPaymentOption(
                title: "Wallet",
                icon: Icons.account_balance_wallet,
                method: "Wallet",
               
              ),
              _buildPaymentOption(
                title: "Gpay",
                image: 'assets/images/gpay.jpg',
                method: "UPI",
                
              ),
              _buildPaymentOption(
                title: "Phonepe",
                image: 'assets/images/phonepe.jpg',
                method: "UPI",
                
              ),
              _buildPaymentOption(
                title: "paytm",
                image: 'assets/images/paytm.png',
                method: "UPI",
                
              ),
          
              Spacer(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () async {
                  // Trigger the placeOrder method
                  await placeOrderViewModel.placeOrder('itemId');
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MainScreen(),
                      )); // Provide the actual itemId
          
                  if (placeOrderViewModel.successMessage != null) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Column(
                            children: [
                              // Add the Lottie animation
                              SizedBox(
                                height: 100, // Adjust size as needed
                                child: Lottie.asset(
                                    'assets/images/Animation - 1733379627016.json',
                                    
                                    repeat: false),
                              ),
                              Text("Order Confirmed"),
                            ],
                          ),
                          content: Text(placeOrderViewModel.successMessage!),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("OK"),
                            ),
                          ],
                        );
                      },
                    );
                  } else if (placeOrderViewModel.errorMessage != null) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Error"),
                          content: Text(placeOrderViewModel.errorMessage!),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("OK"),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                child: Text(
                  "Confirm Order",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentOption({
    required String title,
    IconData? icon,
    String? image,
    required String method,
   
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.green),
      title: Text(title, style: TextStyle(color: Colors.white)),
      trailing: Icon(
        _selectedPaymentMethod == method
            ? Icons.check_circle
            : Icons.check_circle_outline,
        color: _selectedPaymentMethod == method ? Colors.green : Colors.white,
      ),
      onTap: () {
       
      },
    );
  }
}
