import 'package:flutter/material.dart';
import 'package:foodies/utils/constants.dart';
import 'package:foodies/view/easypaymentscreen.dart';
import 'package:foodies/widgets/buttonwidget.dart';

class Orderscreen extends StatefulWidget {
  const Orderscreen({super.key});

  @override
  State<Orderscreen> createState() => _OrderscreenState();
}

class _OrderscreenState extends State<Orderscreen> {
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbackgroundcolor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/Group 3.png'),
          const SizedBox(height: 20),
          Text(
            'Order for food',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: ktextcolor, // Text color
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          const Text(
            'Discover delicious meals, snacks, and beverages curated just for you.',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white, // Intro text color
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
          // 3-dot slider (Page indicator)
          
          // Custom button widget at the bottom
         
        ],
      ),
    );
  }

  // Method to build dot indicator
  Widget buildDot(int index, int currentIndex) {
    return Container(
      height: 10,
      width: 10,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: currentIndex == index ? Colors.white : Colors.grey,
      ),
    );
  }
}
