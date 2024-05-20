import 'package:flutter/material.dart';
import 'package:project_demo_t/common_widget/common_button.dart';
import 'package:project_demo_t/core/constants/app_string.dart';
import 'package:project_demo_t/core/routes/routes.dart';
import 'package:project_demo_t/core/utils/preference.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: InkWell(
                onTap: () async {
                  preferences.remove('email');
                  Navigator.pushNamed(context, Routes.signUpScreen);
                },
                child: const CommonButton(
                  labelText: AppString.logOut,
                )),
          ),
        ],
      ),
    );
  }
}
