import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodies/utils/constants.dart';
import 'package:foodies/view-model/home_view_model.dart';
import 'package:foodies/view/detailspage.dart';
import 'package:provider/provider.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  final List<String> weeklySpecialList = [
    'assets/images/sreeyuktha.png',
    'assets/images/salad.png',
    'assets/images/salad.png',
    'assets/images/sreeyuktha.png',
  ];

  bool _showAllSpecials = false;

  
  final List<String> itemNames = [
    'Salad',
    'Fresh Salad',
    'Classic Salad',
    'Chicken',
  ];
  

  bool _showAllImages = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<HomeviewModel>(context, listen: false).fetchCategories();
      
      Provider.of<HomeviewModel>(context, listen: false).fetchOffers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbackgroundcolor,
      appBar: AppBar(
        backgroundColor: kbackgroundcolor,
        toolbarHeight: 80,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage('assets/images/image 8.png'),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                'John Doe',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.search, color: Colors.white),
              onPressed: () {
                // Trigger search functionality here
              },
            ),
            IconButton(
              icon: Icon(Icons.notifications, color: Colors.white),
              onPressed: () {
                // Trigger notification functionality here
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search TextField
              TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.white.withOpacity(0.5),
                  ),
                  hintText: 'Search your interesting foods...',
                  hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Color(0xff0E162C),
                ),
                onSubmitted: (value) {
                  print("Search for: $value");
                },
              ),
              const SizedBox(height: 20),

              // Special Offers Section with See More Button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Special Offers',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (!_showAllImages)
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _showAllImages = true;
                        });
                      },
                      child: Text(
                        'See More',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 10),

              // New Container with Offer Text and Image
              Consumer<HomeviewModel>(builder: (context, value, child) {
                if (value.isLoading) {
                  return Center(child: CircularProgressIndicator());
                }

                return Container(
                  height: 150, // Set a fixed height for the ListView
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: value.offersList.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        child: Container(
                          margin: const EdgeInsets.only(
                              right: 16), // Add space between items
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.greenAccent,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    value.offersList[index].offerdetails!,
                                    style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    value.offersList[index].itemname!,
                                    style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 8),
                              Image.network(
                                value.offersList[index].itemimage!,
                                // Use Image.network for API image
                                fit: BoxFit.cover,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              }),

              // Image Display Section (Horizontal Scroll)

              const SizedBox(height: 20),

              // Category Icons

              Consumer<HomeviewModel>(
                builder: (context, value, child) {
                  return value.isLoading
                      ? CircularProgressIndicator(
                          color: Colors.green,
                        )
                      : Container(
                          height: 200,
                          child: GridView(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4, // Number of columns
                              crossAxisSpacing: 10, // Spacing between columns
                              mainAxisSpacing: 10, // Spacing between rows
                              childAspectRatio:
                                  1, // Aspect ratio for each grid item
                            ),
                            children: value.categories
                                .map(
                                  (e) => _buildCategoryIcon(
                                      e.categoryname!, e.categoryimage!,e.id.toString(),e.categoryname!),
                                )
                                .toList(),
                          ),
                        );
                },
              ),

              // Weekly Special Section with See All Button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Weekly Special',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _showAllSpecials = !_showAllSpecials;
                      });
                    },
                    child: Text(
                      _showAllSpecials ? 'Show Less' : 'See All',
                      style: TextStyle(color: Colors.greenAccent),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50),

              // Weekly Special Items in GridView.builder
              GridView.builder(
                physics:
                    NeverScrollableScrollPhysics(), // Prevent scroll inside grid
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 40,
                  childAspectRatio: 1.1,
                ),
                itemCount: _showAllSpecials
                    ? weeklySpecialList.length
                    : 2, // Show only 2 items initially
                itemBuilder: (context, index) {
                  return _buildWeeklySpecialItem(
                      weeklySpecialList[index], itemNames[index]);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryIcon(String label, String iconPath,String categoryid,String categoryname) {
    return GestureDetector(
      onTap: () {
        // Navigate to DetailsPage
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                DetailsPage(categoryid:categoryid ,categoryName:categoryname ,), // Adjust if you want to pass parameters
          ),
        );
      },
      child: Column(
        children: [
          Image.network(
            iconPath,
            height: 40,
            width: 40,
          ),
          const SizedBox(height: 5),
          Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeeklySpecialItem(String imagePath, String itemName) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            width: 140,
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  itemName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: -40,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              imagePath,
              width: 140,
              height: 140,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
}
