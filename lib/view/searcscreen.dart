import 'package:flutter/material.dart';
import 'package:foodies/utils/constants.dart';

class FoodSearchPage extends StatefulWidget {
  @override
  _FoodSearchPageState createState() => _FoodSearchPageState();
}

class _FoodSearchPageState extends State<FoodSearchPage> {
  final TextEditingController _searchController = TextEditingController();

  // Sample list of food items
  final List<String> _allFoods = [
    'Pizza',
    'Burger',
    'Pasta',
    'Sushi',
    'Salad',
    'Ice Cream',
    'Tacos',
    'Steak',
    'Vegetable Stir Fry',
    'Dumplings',
  ];

  List<String> _filteredFoods = [];

  void _filterFoodItems(String query) {
    if (query.isNotEmpty) {
      setState(() {
        _filteredFoods = _allFoods
            .where((food) => food.toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    } else {
      setState(() {
        _filteredFoods
            .clear(); // Clear the filtered list if the search query is empty
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _filteredFoods = _allFoods; // Initially show all food items
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbackgroundcolor, // Set the background color
      appBar: AppBar(
        title: Text(
          'Food Search',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              onChanged: _filterFoodItems,
              decoration: InputDecoration(
                labelText: 'Search Food',
                hintText: 'Enter food name...',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _filteredFoods.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      _filteredFoods[index],
                      style: TextStyle(
                          color: Colors.white), // Set text color to green
                    ),
                    onTap: () {
                      // Add your logic for food item selection if needed
                      print('${_filteredFoods[index]} selected');
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
