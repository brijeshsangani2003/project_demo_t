import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:project_demo_t/common_widget/common_button.dart';
import 'package:project_demo_t/core/constants/app_string.dart';
import 'package:project_demo_t/core/constants/app_toast.dart';
import 'package:project_demo_t/core/constants/size.dart';
import 'package:project_demo_t/core/routes/routes.dart';
import 'package:project_demo_t/core/utils/common_validator.dart';
import 'package:project_demo_t/services/services_1.dart';
import '../common_widget/common_textForm_field.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({
    super.key,
    required this.email,
  });
  final String email;

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  TextEditingController passController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();

  Map<String, dynamic>? body;

  late String newPassword;

  bool passwordVisible = false;
  bool _passwordVisible = false;

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.s18),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: Sizes.s20),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Align(
                      alignment: Alignment.topLeft,
                      child: Icon(Icons.arrow_back_ios),
                    ),
                  ),
                  const SizedBox(height: Sizes.s50),
                  const Align(
                    alignment: Alignment.center,
                    child: Text(
                      AppString.enterNewPassword,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: Sizes.s25),
                    ),
                  ),
                  const SizedBox(height: Sizes.s70),
                  const Text(
                    AppString.createPassword,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: Sizes.s15,
                    ),
                  ),
                  CommonTextFormField(
                    validator: Validator.passValidator,
                    onChanged: (value) {
                      newPassword = value;
                    },
                    onSaved: (value) {
                      value = newPassword;
                    },
                    hintText: AppString.newPassword,
                    controller: passController,
                    obscureText: !passwordVisible,
                    suffixIcon: IconButton(
                      icon: Icon(
                        passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      color: Colors.grey,
                      onPressed: () {
                        setState(() {
                          passwordVisible = !passwordVisible;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: Sizes.s20),
                  const Text(
                    AppString.confirmPassword,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: Sizes.s15,
                    ),
                  ),
                  CommonTextFormField(
                    validator: Validator.confirmPassValidator,
                    // onChanged: (value) {
                    //   confirmPassword = value;
                    // },
                    hintText: AppString.confirmPassword,
                    controller: confirmPassController,
                    obscureText: !_passwordVisible,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      color: Colors.grey,
                      onPressed: () {
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: Sizes.s20),
                  Align(
                    alignment: Alignment.center,
                    child: InkWell(
                        onTap: () {
                          log('====> email : ${widget.email} ');
                          continueTap(widget.email);
                        },
                        child: const CommonButton(
                          labelText: AppString.Continue,
                        )),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> continueTap(String email) async {
    if (formKey.currentState!.validate()) {
      if (passController.text == confirmPassController.text) {
        final result = await ApiServices().resetPassword(
          params: {
            'email': email,
            'new_password': newPassword.toString(),
          },
        );
        result.fold(
          (failure) {
            AppToast.showToast();
          },
          (success) {
            showDialog(
              context: context,
              builder: (context) => Dialog(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: Sizes.s40),
                    const Text(
                      'Password SuccessFully Changed',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: Sizes.s15,
                      ),
                    ),
                    const SizedBox(height: Sizes.s30),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, Routes.signUpScreen);
                      },
                      child: Container(
                        height: Sizes.s50,
                        alignment: Alignment.center,
                        width: Sizes.s130,
                        decoration: const BoxDecoration(
                            color: Colors.blue,
                            borderRadius:
                                BorderRadius.all(Radius.circular(Sizes.s20))),
                        child: const Text(
                          'Back to Login',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(height: Sizes.s40),
                  ],
                ),
              ),
            );
          },
        );
      } else {
        AppToast.showToast();
      }
    }
  }
}
