import 'package:flutter/material.dart';
import 'package:foodies/utils/constants.dart';

class Buttonwidget extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;

  const Buttonwidget({
    super.key,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: SizedBox(
        width: double.infinity, // Set button to take full width of its parent
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            backgroundColor: kbuttoncolor, // Set button background color
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30), // Rounded corners
            ),
          ),
          child: Text(
            buttonText,
            style: const TextStyle(
              color: Colors.white, // Set text color
              fontSize: 16, // Set text size
            ),
          ),
        ),
      ),
    );
  }
}
