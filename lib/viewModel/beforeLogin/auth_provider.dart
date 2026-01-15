import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:token_app/data/api_response.dart';
import 'package:token_app/repository/auth_repository.dart';

class OnboardingProvider extends ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void updateIndex(int index) {
    _currentIndex = index;
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

  ApiResponse<dynamic> auth = ApiResponse.loading();

  Future<void> login() async {
    if (!isValid) return;

    auth = ApiResponse.loading();
    notifyListeners();

    try {
      final response = await authRepo.loginWithPhone(phoneController.text);

      auth = ApiResponse.completed(response);
    } catch (e) {
      auth = ApiResponse.error(e.toString());
    }

    notifyListeners();
  }

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }
}

// Otp verification screen

class OtpVerificationProvider extends ChangeNotifier {}

// User details

class UserDetailsProvider extends ChangeNotifier {
  File? profileImage;
  String? selectedRole;

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();

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

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    super.dispose();
  }
}
