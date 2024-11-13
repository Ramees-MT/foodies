import 'package:flutter/material.dart';
import 'package:foodies/view-model/order_view_model.dart';
import 'package:provider/provider.dart';


class OrderDetailsPage extends StatelessWidget {
  final int orderId;

  OrderDetailsPage({required this.orderId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PlaceOrderViewModel()..loadOrder(orderId),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Order Details'),
        ),
        body: Consumer<PlaceOrderViewModel>(
          builder: (context, viewModel, child) {
            if (viewModel.isLoading) {
              return Center(child: CircularProgressIndicator());
            }

            if (viewModel.errorMessage != null) {
              return Center(child: Text(viewModel.errorMessage!));
            }

            final order = viewModel.orderdata;

            if (order == null) {
              // Check if order data is null and display a message if it is
              return Center(child: Text('Order data not available'));
            }

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Order ID: ${order['id']}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text('Customer: ${order['customerName']}'),
                  SizedBox(height: 8),
                  Text('Total Price: \$${order['totalPrice']}'),
                  SizedBox(height: 8),
                  Text('Items:'),
                  SizedBox(height: 8),
                  // Safely access order['items'] and check if it’s a list before iterating
                  ...(order['items'] as List?)?.map((item) {
                    return ListTile(
                      title: Text(item['name']),
                      subtitle: Text('Quantity: ${item['quantity']}'),
                      trailing: Text('\$${item['price']}'),
                    );
                  }).toList() ?? [Text('No items available')],
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
