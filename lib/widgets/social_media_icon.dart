import 'package:flutter/material.dart';

class SocialMediaIcons extends StatelessWidget {
  const SocialMediaIcons({
    Key? key,
    required this.imagePath, // Change the type to String
  }) : super(key: key);

  final String imagePath; // Change the type to String

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Image.asset(
        imagePath, // Use the imagePath instead of Image object
        height: 40.0,
        width: 40.0,
        fit: BoxFit.cover,
      ),
    );
  }
}
