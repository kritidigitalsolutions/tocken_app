import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
  final TextEditingController phoneController = TextEditingController();

  PhoneNumberProvider() {
    phoneController.addListener(_textFieldListener);
  }

  void _textFieldListener() {
    notifyListeners();
  }

  bool get isValid => phoneController.text.length == 10;
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
