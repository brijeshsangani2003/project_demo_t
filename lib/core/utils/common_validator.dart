class Validator {
  static String? emailValidator(String? email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (email!.isEmpty) {
      return 'email can not be empty';
    } else if (!emailRegex.hasMatch(email)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  static String? passValidator(String? value) {
    final passregx =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    if (value!.isEmpty) {
      return 'Password can not be empty';
    } else if (value.length < 8) {
      return 'password must be 8 digit';
    } else if (value.trim() != value) {
      return 'Password cannot contain leading or trailing spaces';
    } else if (!passregx.hasMatch(value)) {
      return 'Please enter a valid password';
    }
    // } else {
    //   return 'password is wrong';
    // }
    return null;
  }

  static String? confirmPassValidator(String? value) {
    if (value!.isEmpty) {
      return 'confirm password can not be empty';
    }
  }
}
