import 'package:flutter/material.dart';
import 'package:foodies/utils/constants.dart';
import 'package:foodies/view/fastdeliveryscreen.dart';
import 'package:foodies/view/signupscreen.dart';
import 'package:foodies/widgets/buttonwidget.dart';

class Easypaymentscreen extends StatefulWidget {
  const Easypaymentscreen({super.key});

  @override
  State<Easypaymentscreen> createState() => _OrderscreenState();
}

class _OrderscreenState extends State<Easypaymentscreen> {
  int _currentIndex = 0;

  // Simulate changing the page
  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbackgroundcolor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/Group 4.png'),
          const SizedBox(height: 20),
          Text(
            'Easy payment',
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

          const SizedBox(height: 30),
          // Custom button widget at the bottom
        ],
      ),
    );
  }
}
