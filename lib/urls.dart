class Urls {
  static const String _baseUrl = 'http://10.10.10.16:5006/api/v1';
  static const String socketUrl = 'http://172.252.13.74:4010/';
  // static const String socketUrl = 'http://192.168.10.144:4001/';
  static const String signUpUrl = '$_baseUrl/profiles/register';
  static const String otpVerifyUrl = '$_baseUrl/otp/verify-otp';
  static const String loginUrl = '$_baseUrl/auth/login';
  static const String forgotPasswordUrl = '$_baseUrl/auth/forget-password';
  static const String profileUrl = '$_baseUrl/profiles/my-profile';
  static const String editProfileUrl = '$_baseUrl/profiles/update-my-profile';
  static const String allfeedUrl = '$_baseUrl/feeds';

  static String updateUserByUrl(
    String id,
  ) {
    return '$_baseUrl/users/update/$id';
  }
}
