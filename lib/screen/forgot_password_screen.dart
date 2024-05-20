import 'package:flutter/material.dart';
import 'package:project_demo_t/common_widget/common_button.dart';
import 'package:project_demo_t/core/constants/app_string.dart';
import 'package:project_demo_t/core/utils/common_validator.dart';
import '../common_widget/common_textForm_field.dart';
import '../core/constants/app_toast.dart';
import '../core/constants/size.dart';
import '../core/routes/routes.dart';
import '../services/services_1.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({
    super.key,
  });

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController emailController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.s12),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
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
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppString.forgotPassword,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: Sizes.s20),
                    )
                  ],
                ),
                const SizedBox(height: Sizes.s30),
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    AppString.email,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: Sizes.s15,
                    ),
                  ),
                ),
                CommonTextFormField(
                  validator: Validator.emailValidator,
                  keyboardType: TextInputType.emailAddress,
                  hintText: AppString.enterEmail,
                  controller: emailController,
                ),
                const SizedBox(height: Sizes.s50),
                InkWell(
                  onTap: continueTap,
                  child: const CommonButton(
                    labelText: AppString.Continue,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> continueTap() async {
    if (formKey.currentState!.validate()) {
      final result = await ApiServices().otpSent(
        params: {'email': emailController.text},
      );
      result.fold(
        (failure) {
          AppToast.showToast();
        },
        (success) {
          Navigator.pushNamed(context, Routes.verificationScreen,
              arguments: emailController.text);
          print('eml===========${emailController.text}');
        },
      );
    }
  }
}
