import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DividerWidget extends StatelessWidget {
  const DividerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      // Divider widget not working :<
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 100,
          height: 2,
          color: Colors.black54,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            'Or Sign In with',
            style: TextStyle(
              color: Colors.grey,
              fontFamily: GoogleFonts.poppins().fontFamily,
              fontWeight: FontWeight.w600,
              fontSize: 16.0,
            ),
          ),
        ),
        Container(
          width: 100,
          height: 2,
          color: Colors.black54,
        ),
      ],
    );
  }
}
