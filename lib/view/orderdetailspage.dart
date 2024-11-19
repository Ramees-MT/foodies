import 'package:flutter/material.dart';
import 'package:foodies/view-model/order_view_model.dart';
import 'package:provider/provider.dart';

class OrderDetailsPage extends StatefulWidget {
  final int userId;

  OrderDetailsPage({required this.userId});

  @override
  State<OrderDetailsPage> createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PlaceOrderViewModel>(context, listen: false)
          .viewOrder(widget.userId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          'Order Details',
          style: TextStyle(color: Colors.greenAccent),
        ),
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.greenAccent),
        elevation: 0,
      ),
      body: Consumer<PlaceOrderViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return Center(
                child: CircularProgressIndicator(color: Colors.greenAccent));
          }

          if (viewModel.errorMessage != null) {
            return Center(
              child: Text(
                viewModel.errorMessage!,
                style: TextStyle(color: Colors.greenAccent, fontSize: 18),
              ),
            );
          }

          final orderData = viewModel.orderData;

          if (orderData == null || orderData['data'] == null) {
            return Center(
              child: Text(
                'No order data available',
                style: TextStyle(color: Colors.greenAccent, fontSize: 18),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: orderData['data'].length,
            itemBuilder: (context, index) {
              final item = orderData['data'][index];

              return Card(
                color: Colors.grey[900],
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['itemname'] ?? 'Unknown Item',
                        style: TextStyle(
                          color: Colors.greenAccent,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Divider(color: Colors.greenAccent.withOpacity(0.5)),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.shopping_cart, color: Colors.greenAccent),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Item ID: ${item['itemid'] ?? 'N/A'}',
                              style: TextStyle(color: Colors.white70),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.person, color: Colors.greenAccent),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'User ID: ${item['userid'] ?? 'N/A'}',
                              style: TextStyle(color: Colors.white70),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.format_list_numbered,
                              color: Colors.greenAccent),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Quantity: ${item['quantity'] ?? 'N/A'}',
                              style: TextStyle(color: Colors.white70),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.attach_money, color: Colors.greenAccent),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Price: \$${item['itemprice'] ?? 'N/A'}',
                              style: TextStyle(color: Colors.white70),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Date: ${item['date'] ?? 'N/A'}',
                        style: TextStyle(color: Colors.white54),
                      ),
                      SizedBox(height: 12),
                      item['itemimage'] != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                item['itemimage'],
                                height: 100,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            )
                          : SizedBox.shrink(),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
