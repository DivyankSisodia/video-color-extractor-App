import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/button_widget.dart';
import '../widgets/custom_widget.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      child: Column(
        children: [
          Flexible(
            flex: 8,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Welcome Back!\n',
                        style: TextStyle(
                          fontSize: 42.0,
                          fontFamily: GoogleFonts.poppins().fontFamily,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      TextSpan(
                        text: '\nEnter your personal details to continue\n',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: GoogleFonts.poppins().fontFamily,
                          fontWeight: FontWeight.w300,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const Flexible(
            flex: 1,
            child: Align(
              alignment: Alignment.bottomRight,
              child: Row(
                children: [
                  Expanded(child: ButtonWidget()),
                  Expanded(child: ButtonWidget()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
