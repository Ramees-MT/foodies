import 'package:flutter/material.dart';
import 'package:foodies/view-model/addcart_view_model.dart';

import 'package:provider/provider.dart';
import 'package:foodies/model/cart_model.dart'; // Ensure this path is correct

class MyCartScreen extends StatefulWidget {
  @override
  _MyCartScreenState createState() => _MyCartScreenState();
}

class _MyCartScreenState extends State<MyCartScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<CartViewModel>(context, listen: false).fetchCartItems();
    });
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Cart",
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
      body: cartProvider.isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartProvider.cartItems.length,
                    itemBuilder: (context, index) {
                      final Cart item = cartProvider.cartItems[index];
                      int quantity = item.quantity ?? 0;

                      return _buildCartContainer(
                        item.itemname!,
                        "\$${item.itemprice}",
                        quantity,
                        item.itemimage!,
                        () async {
                          if (quantity > 1) {
                            await cartProvider.decrementItemQuantity(item.itemid!,item.userid!);
                          } else {
                            // Optionally, show a dialog to confirm removal if quantity is 1
                          }
                        },
                        () async {
                          await cartProvider.incrementItemQuantity(item.itemid!,item.userid!);
                        },
                      );
                    },
                  ),
                ),
                _buildSummarySection(cartProvider.cartItems),
              ],
            ),
    );
  }

  Widget _buildCartContainer(String title, String price, int quantity,
      String imagePath, VoidCallback onDecrement, VoidCallback onIncrement) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4,
            spreadRadius: 1,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Image.network(
            imagePath,
            width: 100,
            height: 100,
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  price,
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ],
            ),
          ),
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.remove_circle_outline, color: Colors.white),
                onPressed: onDecrement,
              ),
              Text(
                "$quantity",
                style: TextStyle(color: Colors.white),
              ),
              IconButton(
                icon: Icon(Icons.add_circle_outline, color: Colors.white),
                onPressed: onIncrement,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummarySection(List<Cart> cartItems) {
    final double totalPrice = cartItems.fold(
      0.0,
      (sum, item) {
        double price = double.tryParse(item.itemprice ?? '0') ?? 0.0;
        int quantity = item.quantity ?? 0;
        return sum + (price * quantity);
      },
    );

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Divider(color: Colors.grey),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              Text(
                "\$${totalPrice.toStringAsFixed(2)}",
                style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              padding: EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {
              // Handle checkout action
            },
            child: Text(
              "Checkout",
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
