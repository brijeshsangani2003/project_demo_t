import 'dart:async';
import 'package:flutter/material.dart';
import 'package:project_demo_t/core/constants/app_string.dart';
import 'package:project_demo_t/core/constants/size.dart';
import 'package:project_demo_t/core/utils/preference.dart';
import '../core/routes/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? userEmail;

  Future getUserEmail() async {
    // SharedPreferences preferences = await SharedPreferences.getInstance();
    // var email = preferences.getString('email');
    var email = preferences.email;
    userEmail = email;
    setState(() {});
  }

  @override
  void initState() {
    getUserEmail().whenComplete(() => Timer(const Duration(seconds: 3), () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) =>
          //         userEmail == null ? const SignUpScreen() : const HomeScreen(),
          //   ),
          // );
          Navigator.pushNamed(context,
              userEmail == null ? Routes.signUpScreen : Routes.homeScreen);
        }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          AppString.splashScreen,
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: Sizes.s20),
        ),
      ),
    );
  }
}
