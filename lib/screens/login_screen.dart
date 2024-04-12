import 'package:color_extractor/screens/home_screen.dart';
import 'package:color_extractor/screens/signup_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/auth/auth_button.dart';
import '../widgets/auth/divider_widget.dart';
import '../widgets/auth/forgot_password.dart';
import '../widgets/auth/social_media_icon.dart';
import '../widgets/auth/text_fields.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 100,
        leading: const BackButton(),
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Image.asset(
            'assets/images/bg1.png',
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          SafeArea(
            child: Column(
              children: [
                const Expanded(
                  flex: 2,
                  child: Gap(20.0),
                ),
                Expanded(
                  flex: 8,
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40.0),
                        topRight: Radius.circular(40.0),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
                            children: [
                              const Gap(20),
                              Text(
                                'Welcome Back!',
                                style: TextStyle(
                                  fontSize: 35.0,
                                  fontFamily: GoogleFonts.poppins().fontFamily,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black.withOpacity(0.8),
                                ),
                              ),
                              const Gap(30.0),
                              const TextFormFieldWidget(
                                hintText: 'Email',
                                prefixIcon: Icons.email,
                              ),
                              const Gap(20),
                              const TextFormFieldWidget(
                                hintText: 'Password',
                                prefixIcon: Icons.password,
                                suffixIcon: Icons.visibility,
                              ),
                              const Gap(3),
                              const ForgotPassword(),
                              const Gap(20),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const HomeScreen(),
                                    ),
                                  );
                                },
                                child: const AuthButton(
                                  text: 'Sign In',
                                ),
                              ),
                              const Gap(20),
                              const DividerWidget(),
                              const Gap(20),
                              const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SocialMediaIcons(
                                    imagePath: 'assets/images/google.png',
                                  ),
                                  SocialMediaIcons(
                                    imagePath: 'assets/images/facebook.jpeg',
                                  ),
                                  SocialMediaIcons(
                                    imagePath: 'assets/images/twitter.png',
                                  ),
                                ],
                              ),
                              const Gap(30),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Don\'t have an account?',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontFamily:
                                          GoogleFonts.poppins().fontFamily,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const SignUpScreen(),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      ' Sign Up',
                                      style: TextStyle(
                                        color: const Color.fromARGB(
                                            255, 90, 90, 90),
                                        fontFamily:
                                            GoogleFonts.poppins().fontFamily,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 19.0,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
