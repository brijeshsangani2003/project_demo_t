// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:project_demo_t/core/utils/preference.dart';
//
// class ApiService {
//   static Future<Map<String, dynamic>> signUpUser(
//       {String? email, String? password}) async {
//     http.Response response = await http.post(
//       Uri.parse('http://13.48.215.45:5001/api/user/sign-in'),
//       body: {
//         'username': email,
//         'password': password,
//       },
//     );
//
//     if (response.statusCode == 200) {
//       var result = jsonDecode(response.body);
//
//       print("token111111111111========${preferences.token}"); //null
//       preferences.token = result['data']['token'].toString();
//       print("token id========${preferences.token}");
//       //pela aa ritna data cheack karavi levana token id print thai che ne
//       //print("token id:=========${result['data']['token']}");
//
//       print('Response Of Api =======> ${result}');
//       return result;
//     } else {
//       print('Login failed. Status code: ${response.statusCode}');
//       return {};
//     }
//   }
//
//   ///send otp code
//   static Future<Map<String, dynamic>> otpSent({String? email}) async {
//     http.Response response = await http.post(
//         Uri.parse('http://13.48.215.45:5001/api/user/forgot-password'),
//         body: {
//           'email': email,
//         });
//     print('otpsentresponse=============> ${response.statusCode}');
//
//     if (response.statusCode == 200) {
//       Map<String, dynamic> result = jsonDecode(response.body);
//       print('OTP code sent successfully');
//       return result;
//     } else {
//       print('Failed to send OTP code: ${response.body}');
//       return {};
//     }
//   }
//
//   /// /verify otp code
//   static Future<Map<String, dynamic>> verifyOtp({
//     String? email,
//     String? otp,
//   }) async {
//     print('1111111111111111111111111111111111111111111111111111');
//     http.Response response = await http.post(
//       Uri.parse('http://13.48.215.45:5001/api/user/verify-otp'),
//       body: {'email': email, 'otp': otp},
//     );
//
//     print('object=============> ${response.statusCode}');
//     if (response.statusCode == 200) {
//       Map<String, dynamic> result = jsonDecode(response.body);
//       print('result ================> ${result}');
//       return result;
//     } else {
//       print('Error verifying OTP. Status code: ${response.statusCode}');
//       return {};
//     }
//   }
//
//   static Future<Map<String, dynamic>?> resetPassword(
//       {String? email, String? new_password}) async {
//     print('22222222222222222222222222222222222222222222222');
//     http.Response response = await http.post(
//       Uri.parse('http://13.48.215.45:5001/api/user/reset-password'),
//       body: {
//         'email': email,
//         'new_password': new_password,
//       },
//       headers: {
//         "Content-Type": "application/x-www-form-urlencoded",
//       },
//       encoding: Encoding.getByName("utf-8"),
//     );
//     print('RESPONSE===========================> ${response.statusCode}');
//     if (response.statusCode == 200) {
//       Map<String, dynamic> result = jsonDecode(response.body);
//       print('result ================> ${result}');
//       return result;
//     } else {
//       print('Error Status code: ${response.statusCode}');
//       return {};
//     }
//   }
// }
