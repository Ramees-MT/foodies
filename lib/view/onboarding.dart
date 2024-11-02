// onboarding_screen.dart
import 'package:flutter/material.dart';
import 'package:foodies/view/easypaymentscreen.dart';
import 'package:foodies/view/fastdeliveryscreen.dart';
import 'package:foodies/view/orderscreen.dart';
import 'package:foodies/widgets/buttonwidget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
// Import WelcomeScreen

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            children: [
              Orderscreen(),
              Easypaymentscreen(),
              Fastdeliveryscreen(), // Add delivery screen here
            ],
          ),
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Column(
              children: [
                SmoothPageIndicator(
                  controller: _pageController,
                  count: 3, // Reduced to 3 screens
                  effect: ExpandingDotsEffect(
                    dotHeight: 10,
                    dotWidth: 10,
                    activeDotColor: Colors.white,
                    dotColor: Colors.grey,
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Second page
  
  }

