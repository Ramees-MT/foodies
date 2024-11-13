import 'package:flutter/material.dart';
import 'package:foodies/model/products_model.dart';
import 'package:foodies/view-model/search_view_model.dart';
import 'package:foodies/view/product_detailspage.dart';
import 'package:provider/provider.dart';

class FoodSearchPage extends StatefulWidget {
  @override
  _FoodSearchPageState createState() => _FoodSearchPageState();
}

class _FoodSearchPageState extends State<FoodSearchPage> {
  final TextEditingController _searchController = TextEditingController();
  Product? product;

  @override
  void initState() {
    super.initState();
  }

  void _search() {
    final viewModel = Provider.of<FoodViewModel>(context, listen: false);
    viewModel.fetchFoods(_searchController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Foods', style: TextStyle(color: Colors.green)),
        backgroundColor: Colors.black,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              style: TextStyle(color: Colors.green),
              onSubmitted: (_) => _search(),
              decoration: InputDecoration(
                hintText: 'Enter food name',
                hintStyle: TextStyle(color: Colors.grey),
                filled: true,
                fillColor: Colors.grey[800],
                suffixIcon: IconButton(
                  icon: Icon(Icons.search, color: Colors.green),
                  onPressed: _search,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ),
      ),
      backgroundColor: Colors.black,
      body: Consumer<FoodViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return Center(
              child: CircularProgressIndicator(color: Colors.green),
            );
          } else if (viewModel.errorMessage.isNotEmpty) {
            return Center(
              child: Text(
                viewModel.errorMessage,
                style: TextStyle(color: Colors.green),
              ),
            );
          } else if (viewModel.foods.isEmpty) {
            return Center(
              child: Text(
                'No results found',
                style: TextStyle(color: Colors.green),
              ),
            );
          } else {
            return ListView.builder(
              itemCount: viewModel.foods.length,
              itemBuilder: (context, index) {
                final product = viewModel.foods[index];
                return Card(
                  color: Colors.grey[900],
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(8.0),
                    leading: product.itemimage != null &&
                            product.itemimage!.isNotEmpty
                        ? Image.network(
                            product.itemimage!,
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          )
                        : Icon(Icons.fastfood, size: 60, color: Colors.green),
                    title: Text(
                      product.itemname ?? 'Unknown',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (product.itemId != null)
                          Text(
                            'ID: ${product.itemId}',
                            style: TextStyle(color: Colors.grey[500]),
                          ),
                        SizedBox(height: 4),
                        Text(
                          'Price: ${product.itemprice ?? 'N/A'}',
                          style: TextStyle(color: Colors.grey[500]),
                        ),
                        SizedBox(height: 4),
                        Text(
                          product.itemdescription ??
                              'No description available',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.grey[400]),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ProductDetailsPage(product: product),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
