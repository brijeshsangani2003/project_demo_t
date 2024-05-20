import 'package:flutter/material.dart';
import 'package:project_demo_t/common_widget/common_button.dart';
import 'package:project_demo_t/common_widget/common_textForm_field.dart';
import 'package:project_demo_t/core/constants/app_string.dart';
import 'package:project_demo_t/core/constants/app_toast.dart';
import 'package:project_demo_t/core/constants/size.dart';
import 'package:project_demo_t/core/utils/common_validator.dart';
import 'package:project_demo_t/core/utils/preference.dart';
import 'package:project_demo_t/services/services_1.dart';
import '../core/routes/routes.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.s18),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    AppString.signUp,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: Sizes.s25),
                  ),
                ),
                const SizedBox(height: Sizes.s70),
                const Text(
                  AppString.email,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: Sizes.s15,
                  ),
                ),
                CommonTextFormField(
                  validator: Validator.emailValidator,
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  hintText: AppString.email,
                ),
                const SizedBox(height: Sizes.s20),
                const Text(
                  AppString.password,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: Sizes.s15,
                  ),
                ),
                CommonTextFormField(
                  validator: Validator.passValidator,
                  controller: passController,
                  hintText: AppString.password,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.forgotPasswordScreen);
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        AppString.forgotPassword,
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: Sizes.s20),
                Align(
                  alignment: Alignment.center,
                  child: InkWell(
                      onTap: signTap,
                      child: const CommonButton(
                        labelText: AppString.signUp,
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> signTap() async {
    if (formKey.currentState!.validate()) {
      final result = await ApiServices().signIn(
        params: {
          'username': emailController.text,
          'password': passController.text,
        },
      );
      result.fold(
        (failure) {
          // Handle the failure case
          AppToast.showToast();
        },
        (success) {
          // Handle the success case
          preferences.email = emailController.text.toString();
          Navigator.pushNamed(context, Routes.homeScreen);
        },
      );

      // print(preferences.email);
      // preferences.email = emailController.text.toString();
      // print('111111111111111111111');
      // print(preferences.email);

      //print('object123========${'email'}');
      //if (body?['success'] == true) {
      // if (['success'] == true) {
      //   //SharedPreferences pref = await SharedPreferences.getInstance();
      //   // pref.setString('email', emailController.text);
      //   ///aa print null avu joi aa.
      //   // Navigator.pushNamed(context, Routes.forgotPasswordScreen);
      // } else {
      //   // ScaffoldMessenger.of(context).showSnackBar(
      //   //   const SnackBar(
      //   //     padding: EdgeInsets.all(Sizes.s15),
      //   //     content: Text(
      //   //       //    body!['message'].toString(),
      //   //       'Something went wrong',
      //   //     ),
      //   //   ),
      //   // );
      //   //AppToast.showToast();
      // }
    }
  }
}
