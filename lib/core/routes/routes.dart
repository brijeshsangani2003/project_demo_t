import 'package:flutter/material.dart';
import 'package:project_demo_t/screen/forgot_password_screen.dart';
import 'package:project_demo_t/screen/new_password_screen.dart';
import 'package:project_demo_t/screen/sign_up_screen.dart';
import 'package:project_demo_t/screen/splash_screen.dart';
import 'package:project_demo_t/screen/verification_screen.dart';
import '../../screen/home_screen.dart';

class Routes {
  Routes._();

  static const String splashScreen = '/splashScreen';
  static const String homeScreen = '/homeScreen';
  static const String signUpScreen = '/signUpScreen';
  static const String forgotPasswordScreen = '/forgotPasswordScreen';
  static const String verificationScreen = '/verificationScreen';
  static const String newPasswordScreen = '/newPasswordScreen';
}

class RouteGenerator {
  RouteGenerator._();

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    var arguments = settings.arguments;

    switch (settings.name) {
      case Routes.splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case Routes.homeScreen:
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      case Routes.signUpScreen:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());

      case Routes.forgotPasswordScreen:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());

      case Routes.verificationScreen:
        return MaterialPageRoute(
            builder: (_) => VerificationScreen(email: arguments as String));

      case Routes.newPasswordScreen:
        return MaterialPageRoute(
            builder: (_) => NewPasswordScreen(email: arguments as String));

      default:
        return null;
    }
  }
}
