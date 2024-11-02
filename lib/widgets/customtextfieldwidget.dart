import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hinttext;
  final IconData icon;
  final Color textColor; // Add textColor parameter
  final double textOpacity;
  final TextEditingController controller; // Add textOpacity parameter

  const CustomTextField({
    Key? key,
    required this.hinttext,
    required this.icon,
    required this.textColor,
    required this.controller,
    // Add textColor to constructor
    this.textOpacity = 1.0,
    bool? obscureText, // Default opacity value
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: TextStyle(
          color: textColor.withOpacity(
              textOpacity)), // Set the text color with reduced opacity
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xff01040F),
        hintText: hinttext,
        hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
        prefixIcon: Icon(icon,
            color: textColor.withOpacity(textOpacity)), // Set icon color

        // Adding border radius while keeping the border invisible
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide.none, // This removes the border
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: Colors.green, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide.none, // No border when enabled
        ),
      ),
    );
  }
}
