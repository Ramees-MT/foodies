import 'package:flutter/material.dart';
import 'package:foodies/model/products_model.dart';
import 'package:foodies/view-model/details_view_model.dart';
import 'package:foodies/view/product_detailspage.dart';
import 'package:provider/provider.dart';

class DetailsPage extends StatefulWidget {
  final String categoryid;
  final String categoryName;

  const DetailsPage(
      {super.key, required this.categoryid, required this.categoryName});
  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  void initState() {
    super.initState();
    // Fetch products when the page is initialized
    Future.microtask(() {
      //context.read<Detailsviewmodel>().fetchProducts();
      context
          .read<Detailsviewmodel>()
          .fetchProductsByCategoryId(widget.categoryid);
    });
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<Detailsviewmodel>(context);
    print(productProvider.categoryproducts.length);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryName),
        backgroundColor: Colors.green,
      ),
      body: productProvider.isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.75,
                ),
                itemCount: productProvider.categoryproducts.length,
                itemBuilder: (context, index) {
                  return _buildProductCard(
                      productProvider.categoryproducts[index]);
                },
              ),
            ),
    );
  }

  Widget _buildProductCard(Product product) {
    return GestureDetector(
      onTap: () {
        // Navigate to the ProductDetailsPage when the card is tapped
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailsPage(product: product),
          ),
        );
      },
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                child: Image.network(
                  product.itemimage!,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      Icon(Icons.error),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.itemname!,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '\$${product.itemprice}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
