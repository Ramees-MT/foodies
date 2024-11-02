// welcome_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodies/routes/route_names.dart';
import 'package:foodies/view/onboarding.dart';
import 'package:slider_button/slider_button.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/pizza-2589569 1.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          // Welcome Text
          Positioned(
            bottom: 150,
            left: 0,
            right: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Welcome to ',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'foodies!',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  'Discover delicious meals, snacks, and beverages curated just for you.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          // Slider Button positioned towards the right end
          Positioned(
            bottom: 30,
            right: -36, // Adjust to align the slider button to the right
            child: SliderButton(
              buttonSize: 50,
              action: () {
                // Navigation to home screen after sliding
              return   Navigator.push(context, MaterialPageRoute(builder: (context) => OnboardingScreen(),));
              },
              label: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: const Text(
                  'Get Started...!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 17),
                ),
              ),
              icon: const Icon(
                Icons.arrow_forward_ios_outlined,
                color: Colors.white,
              ),
              width: MediaQuery.of(context).size.width * 0.8,
              buttonColor: const Color.fromARGB(255, 32, 236, 39),
              backgroundColor: Color(0xff2B964F),
              baseColor: Colors.white,
              highlightedColor: Colors.greenAccent,
              shimmer: true, // Adds a subtle shimmer effect
              // Allows for dismiss functionality
            ),
          ),
        ],
      ),
    );
  }
}
