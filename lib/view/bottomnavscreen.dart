import 'package:flutter/material.dart';
import 'package:foodies/utils/constants.dart';
import 'package:foodies/view-model/user_view_model.dart';
import 'package:foodies/view/cartscreen.dart';
import 'package:foodies/view/homescreen.dart';
import 'package:foodies/view/profilescreen.dart';
import 'package:foodies/view/searcscreen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  int? logId;

  @override
  void initState() {
    super.initState();
    context.read<Userviewmodel>().loadLogId();
    _loadLogId();
  }

  // Function to load the logId from SharedPreferences
  Future<void> _loadLogId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? logIdString = prefs.getString('isLoggedIn');
    setState(() {
      logId = logIdString != null ? int.tryParse(logIdString) : 0;
      print('pppppppppppppppppppppppppppppppppppppppp');
      print(logId); // Default to 0 if null
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Wait until logId is loaded before building the UI
    if (logId == null) {
      return Center(
          child: CircularProgressIndicator()); // Show a loading indicator
    }

    final List<Widget> _pages = [
      Homescreen(),
      MyCartScreen(),
      FoodSearchPage(),
      ProfileScreen(userId: logId ?? 0), // Default to 0 if logId is null
    ];

    return Scaffold(
      backgroundColor: kbackgroundcolor,
      body: _pages[_currentIndex], // Display the current page
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        child: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          backgroundColor: Colors.black,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home, size: 35),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag_outlined, size: 35),
              label: 'Cart',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search, size: 35),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person, size: 35),
              label: 'Profile',
            ),
          ],
          currentIndex: _currentIndex,
          selectedItemColor: Colors.green,
          unselectedItemColor: Colors.white,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }
}
