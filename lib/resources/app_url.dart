class AppUrl {
  static const String baseUrl = 'https://q769bgq4-5000.inc1.devtunnels.ms/api';

  // Login

  static const String sendOtp = "$baseUrl/auth/send-otp";
  static const String verifyOtp = "$baseUrl/auth/verify-otp";

  // Policy

  static const String policy = "$baseUrl/legal";

  // about -us

  static const String aboutUs = "$baseUrl/aboutus";

  //plan

  static const String plans = "$baseUrl/plans?userType=";
  static const String faq = "$baseUrl/faqs";
}
