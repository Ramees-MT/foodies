import 'package:flutter/material.dart';

class IconContainerWidget extends StatelessWidget {
  const IconContainerWidget({super.key, required this.imagePath});

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100, // Adjusted width for rectangular shape
      height: 70, // Adjusted height for rectangular shape
      decoration: BoxDecoration(
        color: Color(0xff01040F), // Background color
        borderRadius: BorderRadius.circular(8), // Rounded corners
        // Border color
      ),
      child: ClipRRect(
        borderRadius:
            BorderRadius.circular(8), // Apply rounded corners to image
        child: Image.asset(
          imagePath,
          width: 40,
        ),
      ),
    );
  }
}
