class AppUrl {
  static const String baseUrl = 'http://192.168.29.185:5000/api';

  // static const String baseUrl =
  //    "https://backend-tocken-admin-panel.vercel.app/api";

  // Login

  static const String onBoarding = "$baseUrl/wallpapers";

  static const String sendOtp = "$baseUrl/auth/send-otp";
  static const String verifyOtp = "$baseUrl/auth/verify-otp";
  static const String registerUser = "$baseUrl/user/profile-info";

  // Policy

  static const String policy = "$baseUrl/legal";

  // Feedback

  static const String feedback = "$baseUrl/feedback";

  // about -us

  static const String aboutUs = "$baseUrl/aboutus";

  //plan

  static const String plans = "$baseUrl/plans?userType=";
  static const String faq = "$baseUrl/faqs";

  // acount page

  static const String personalDetails = "$baseUrl/wallpapers";

  // phone number privacy

  static const String phonePrivacy = "$baseUrl/user/phone-privacy";

  // profile update

  static const String profileEdit = "$baseUrl/user/profile-update";

  // city search

  static const String city = "$baseUrl/location/search";

  // post properties

  static const String postProperty = "$baseUrl/properties";
}
