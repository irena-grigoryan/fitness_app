class ValidationService {
  static bool isUsernameValid(String text) {
    return text.length > 1;
  }

  static bool isEmailValid(String text) {
    bool emailValid = text.trim().length >= 4 && text.contains('@');
    return emailValid;
  }

  static bool isPasswordValid(String text) {
    return text.length >= 8;
  }

  static bool isConfirmPasswordValid(String password, String confirmPassword) {
    return password == confirmPassword;
  }
}
