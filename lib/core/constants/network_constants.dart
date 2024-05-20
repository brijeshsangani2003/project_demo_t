class NetworkConst {
  NetworkConst._();

  /// === base url === ///

  static const String baseUrl = 'http://13.48.215.45:5001/api/';

  /// === end point === ///

  static const String user = 'user/';
  static const String signIn = '$baseUrl${user}sign-in';
  static const String forgotPassword = '$baseUrl${user}forgot-password';
  static const String verifyOtp = '$baseUrl${user}verify-otp';
  static const String resetPassword = '$baseUrl${user}reset-password';

  static const String anime = 'https://api.jikan.moe/v4/anime';
}
