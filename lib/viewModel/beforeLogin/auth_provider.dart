import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:token_app/data/api_response.dart';
import 'package:token_app/data/status.dart';
import 'package:token_app/main.dart';
import 'package:token_app/model/request_model/auth_request_model/user_req_model.dart';
import 'package:token_app/model/response_model/auth/auth_response_model.dart';
import 'package:token_app/repository/auth_repository.dart';
import 'package:token_app/utils/app_snackbar.dart';
import 'package:token_app/utils/local_storage.dart';
import 'package:token_app/view/beforeLogin/otp_verification_page.dart';
import 'package:token_app/view/beforeLogin/user_details.dart';

class OnboardingItem {
  final String image;
  final String title;
  final String subtitle;

  OnboardingItem({
    required this.image,
    required this.title,
    required this.subtitle,
  });
}

class OnboardingProvider extends ChangeNotifier {
  final AuthRepository authRepo = AuthRepository();

  bool isLoading = false;
  String? errorMessage;
  int currentIndex = 0;

  /// 🔹 FINAL LIST USED BY UI
  List<OnboardingItem> onboardingItems = [];

  void updateIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }

  Future<void> getOnBoarding() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final OnBoardingResModel res = await authRepo.onBoarding();

      onboardingItems = (res.wall ?? []).map((e) {
        return OnboardingItem(
          image: e.image ?? '',
          title: e.title ?? '',
          subtitle: e.des ?? '',
        );
      }).toList();

      currentIndex = 0;
    } catch (e) {
      errorMessage = e.toString();
      print('ofdfsfd=--d-sf-dsf- ${e.toString()}');
    }

    isLoading = false;
    notifyListeners();
  }
}

// Phonenumber page

class PhoneNumberProvider extends ChangeNotifier {
  final authRepo = AuthRepository();
  final TextEditingController phoneController = TextEditingController();

  PhoneNumberProvider() {
    phoneController.addListener(_textFieldListener);
  }

  void _textFieldListener() {
    notifyListeners();
  }

  bool get isValid => phoneController.text.length == 10;

  ApiResponse<dynamic> auth = ApiResponse.completed(null);

  bool get isLoading => auth.status == Status.loading;

  Future<void> login(BuildContext context) async {
    if (!isValid || isLoading) return;

    auth = ApiResponse.loading();
    notifyListeners();

    try {
      final response = await authRepo.loginWithPhone(
        phoneController.text.trim(),
      );
      auth = ApiResponse.completed(response);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) =>
              OtpVerificationScreen(phone: phoneController.text.trim()),
        ),
      );
    } catch (e) {
      auth = ApiResponse.error(e.toString());
      AppSnackBar.error(
        context,
        "Something went wrong. Please try again later.",
      );
    } finally {
      notifyListeners();
    }
  }

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }
}

// Otp verification screen

class OtpVerificationProvider extends ChangeNotifier {
  final authRepo = AuthRepository();

  final pref = SharedPreferences.getInstance();

  ApiResponse<UserResModel> verifiedData = ApiResponse.completed(null);

  int seconds = 39;
  Timer? _timer;

  bool get isLoading => verifiedData.status == Status.loading;

  bool get canResend => seconds == 0;

  void startTimer() {
    seconds = 39;
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (seconds == 0) {
        timer.cancel();
      } else {
        seconds--;
        notifyListeners();
      }
    });
  }

  void disposeTimer() {
    _timer?.cancel();
  }

  Future<void> resendOtp(BuildContext context, String phone) async {
    startTimer();

    try {
      await authRepo.loginWithPhone(phone);
      AppSnackBar.success(context, "OTP resent successfully");
    } catch (e) {
      AppSnackBar.error(context, "Failed to resend OTP");
    }
  }

  Future<void> verifyOtp(BuildContext context, String phone, String otp) async {
    verifiedData = ApiResponse.loading();
    notifyListeners();

    print("$phone $otp");

    try {
      final response = await authRepo.verifyOtp(phone, otp);
      verifiedData = ApiResponse.completed(response);
      print(response);
      if (verifiedData.data?.isNewUser ?? false) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => UserDetails(phone: phone)),
        );
      } else {
        await LocalStorageService.saveUserData(response);
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => MyHomePage()),
          (route) => route.isFirst,
        );
      }
    } catch (e) {
      verifiedData = ApiResponse.error(e.toString());
      AppSnackBar.error(context, "Invalid OTP. Please try again.");
    }

    notifyListeners();
  }

  @override
  void dispose() {
    disposeTimer();
    super.dispose();
  }
}

// User details

class UserDetailsProvider extends ChangeNotifier {
  File? profileImage;
  String? selectedRole;

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();

  final _auth = AuthRepository();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  UserDetailsProvider() {
    firstNameController.addListener(_onFieldChanged);
    lastNameController.addListener(_onFieldChanged);
    emailController.addListener(_onFieldChanged);
  }

  void _onFieldChanged() {
    notifyListeners();
  }

  void selectRole(String role) {
    selectedRole = role;
    notifyListeners();
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      profileImage = File(image.path);
      notifyListeners();
    }
  }

  bool get isValid {
    return selectedRole != null &&
        firstNameController.text.trim().isNotEmpty &&
        lastNameController.text.trim().isNotEmpty;
  }

  Future<void> registerUser(BuildContext context, String phone) async {
    if (!isValid || isLoading) return;

    _isLoading = true;
    notifyListeners();

    try {
      final model = UserReqModel(
        userType: selectedRole!.toUpperCase(),
        firstName: firstNameController.text.trim(),
        lastName: lastNameController.text.trim(),
        email: emailController.text.trim(),
        phone: phone,
        profileImage: profileImage?.path ?? "",
      );

      print(model.toJson());

      final res = await _auth.registerUser(model);

      print(res);

      await LocalStorageService.saveUserData(res);

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => MyHomePage()),
        (route) => false,
      );
    } catch (e) {
      AppSnackBar.error(context, "Invalid value, please try again later");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    super.dispose();
  }
}
