import 'package:flutter/material.dart';

class Customcntnrwidget extends StatelessWidget {
  const Customcntnrwidget({super.key, this.imagepath, required this.text, this.ontap});
  final String? imagepath;
  final String text;
  final VoidCallback? ontap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey),
          color: Color(0xff01040F)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imagepath!,
            height: 24,
            width: 24,
          ),
          const SizedBox(width: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              text,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
