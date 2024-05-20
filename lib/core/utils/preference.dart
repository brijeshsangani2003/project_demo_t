import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  Preferences._();
  static final Preferences _instance = Preferences._();
  static SharedPreferences? _shared;

  final String _email = 'email';
  final String _token = 'token';

  static Future<void> init() async {
    _shared = await SharedPreferences.getInstance();
  }

  ///set email
  set email(String? value) {
    if (value == null) return;
    _shared?.setString(_email, value);
  }

  ///get email
  String? get email => _shared?.getString(_email);
  //aa ekj var instance karvanu etle aa badha ma chalse.niche ni line.
  static Preferences get instance => _instance;

  ///remove email
  String remove(String key) => _email;

  set token(String? value) {
    if (value == null) return;
    _shared?.setString(_token, value);
  }

  String? get token => _shared?.getString(_token);
}

Preferences preferences = Preferences.instance;
