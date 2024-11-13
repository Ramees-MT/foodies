import 'package:flutter/material.dart';
import 'package:foodies/view-model/addcart_view_model.dart';
import 'package:foodies/view-model/signin_view_model.dart';
import 'package:provider/provider.dart';
import 'package:foodies/model/products_model.dart';
import 'package:foodies/model/cart_model.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Make sure to import your Cart model

class ProductDetailsPage extends StatelessWidget {
  final Product product;
  final String? productName;
  const ProductDetailsPage(
      {super.key, required this.product, this.productName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          product.itemname!,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.green,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product image
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 15,
                        spreadRadius: 5,
                        offset: Offset(0, 10),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network(
                      product.itemimage!,
                      height: 250,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: Colors.grey[300],
                        child: Icon(Icons.error, size: 100, color: Colors.red),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24),
              // Product name
              Text(
                product.itemname!,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 8),
              // Product price
              Text(
                '\$${product.itemprice}',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Colors.green[700],
                ),
              ),
              SizedBox(height: 16),
              Divider(thickness: 1.5),
              SizedBox(height: 16),
              // Description section
              Text(
                'Description',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 8),
              Text(
                product.itemdescription ?? 'No description available.',
                style: TextStyle(
                  fontSize: 16,
                  height: 1.5,
                  color: Colors.black54,
                ),
              ),
              SizedBox(height: 24),
              // 'Add to Cart' button
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    // Create a Cart object from the Product
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    String? log_id = await prefs.getString('isLoggedIn');
                    print(log_id);
                    // Access the CartProvider and add the product
                    Provider.of<CartViewModel>(context, listen: false)
                        .addToCart(
                            itemId: product.id.toString(), userId: log_id!);

                    // Show a snackbar message
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("${product.itemname} added to cart!"),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 8,
                    shadowColor: Colors.greenAccent,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.shopping_cart, color: Colors.white),
                      SizedBox(width: 8),
                      Text(
                        'Add to Cart',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16), // Space between the buttons
              // 'Order' button
            ],
          ),
        ),
      ),
    );
  }
}
