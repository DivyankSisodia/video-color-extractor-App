import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BackButton extends StatelessWidget {
  const BackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            size: 20,
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        Text(
          'Back',
          style: TextStyle(
            color: Colors.white,
            fontFamily: GoogleFonts.poppins().fontFamily,
            fontWeight: FontWeight.w600,
            fontSize: 14.0,
          ),
        )
      ],
    );
  }
}
