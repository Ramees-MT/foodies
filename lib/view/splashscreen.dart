import 'package:flutter/material.dart';
import 'package:foodies/utils/constants.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:foodies/view/onboarding.dart';
import 'package:foodies/view/welcomescreen.dart'; // Import SpinKit

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    // Delay for 4 seconds before navigating to the welcome screen
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) =>  WelcomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbackgroundcolor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(), // Empty space at the top
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Image.asset(
                  'assets/images/Group 2.png',
                  width: 120,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Image.asset(
                'assets/images/Foodies.png',
                width: 120,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 30.0), // Add padding to bottom
            child: SpinKitCircle(
              color: ktextcolor,
              size: 50.0, // Adjust the size of the circular indicator
            ),
          ),
        ],
      ),
    );
  }
}


