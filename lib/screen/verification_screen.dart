import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:project_demo_t/common_widget/common_button.dart';
import 'package:project_demo_t/core/constants/app_string.dart';
import 'package:project_demo_t/core/constants/app_toast.dart';
import 'package:project_demo_t/core/constants/size.dart';
import '../core/routes/routes.dart';
import '../services/services_1.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key, required this.email});

  final String email;

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  Map<String, dynamic>? body;

  TextEditingController otpController = TextEditingController();

  int _remainingTime = 60;

  @override
  void initState() {
    ///multiple arguments code:
    // final args =
    //     ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    // final email = args['email'];
    // print("email ==> ${email}");
    startTimer();
    super.initState();
  }

  void startTimer() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingTime < 1) {
          timer.cancel();
        } else {
          _remainingTime--;
        }
      });
    });
  }

  void _resetTimer() {
    setState(() {
      _remainingTime = 60;
    });
    startTimer();
  }

  @override
  void dispose() {
    super.dispose();
    otpController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.s12),
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
                  child: Icon(
                    Icons.arrow_back_ios,
                  ),
                ),
              ),
              const SizedBox(height: Sizes.s50),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppString.enterVerificationCode,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: Sizes.s20),
                  )
                ],
              ),
              const SizedBox(height: Sizes.s30),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Pinput(
                  length: 6,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  controller: otpController,
                  defaultPinTheme: PinTheme(
                    height: Sizes.s50,
                    width: Sizes.s50,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(Sizes.s10),
                      border: Border.all(color: Colors.black12),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: Sizes.s30,
              ),
              _remainingTime == 0
                  ? InkWell(
                      onTap: () => resendOtp(widget.email),
                      child: Container(
                        height: Sizes.s40,
                        width: Sizes.s100,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(Sizes.s10)),
                        child: const Center(
                          child: Text(
                            'Resend Otp',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    )
                  : Text(
                      'Time remaining: $_remainingTime seconds',
                      style: const TextStyle(fontSize: Sizes.s16),
                    ),
              const SizedBox(height: Sizes.s50),
              InkWell(
                onTap: () {
                  log('====> email : ${widget.email} ');
                  continueTap(widget.email);
                },
                child: const CommonButton(
                  labelText: AppString.Continue,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> resendOtp(String email) async {
    _resetTimer();

    otpController.clear();

    await ApiServices().otpSent(
      params: {'email': email},
    );
    // print("=================================${email}");

    final result = await ApiServices().verifyOtp(
      params: {
        'email': email,
        'otp': otpController.text,
      },
    );
    result.fold(
      (failure) {
        AppToast.showToast();
      },
      (success) {
        Navigator.pushNamed(context, Routes.newPasswordScreen,
            arguments: email);
      },
    );
  }

  Future<void> continueTap(String email) async {
    //  print("Email;=========================${email}");
    final result = await ApiServices().verifyOtp(
      params: {
        'email': email,
        'otp': otpController.text,
      },
    );
    result.fold(
      (failure) {
        AppToast.showToast();
      },
      (success) {
        Navigator.pushNamed(context, Routes.newPasswordScreen,
            arguments: email);
      },
    );
  }
}
