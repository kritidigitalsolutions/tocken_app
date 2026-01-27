import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:token_app/model/request_model/account/feedback_req_model.dart';
import 'package:token_app/model/response_model/auth/auth_response_model.dart';
import 'package:token_app/repository/account_repo.dart';
import 'package:token_app/resources/app_url.dart';
import 'package:token_app/utils/app_snackbar.dart';
import 'package:token_app/utils/local_storage.dart';

class ProfilePagesProvider extends ChangeNotifier {
  final ImagePicker _picker = ImagePicker();

  File? _profileImage;

  /// Getter
  File? get profileImage => _profileImage;

  /// Pick image from camera or gallery
  Future<void> pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        imageQuality: 70, // reduce size
      );

      if (pickedFile != null) {
        _profileImage = File(pickedFile.path);
        notifyListeners();
      }
    } catch (e) {
      debugPrint("Image pick error: $e");
    }
  }

  /// Optional: remove image
  void removeImage() {
    _profileImage = null;
    notifyListeners();
  }
}

class ProfileEditProvider extends ChangeNotifier {
  final _repo = AccountRepo();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final gstCtr = TextEditingController();
  String name = '';
  String userName = '';
  String phone = '';
  String profileImage = "";
  String role = '';

  Future<void> getUserData() async {
    final User? userData = await LocalStorageService.getUser();

    firstNameController.text = userData?.firstName ?? '';
    lastNameController.text = userData?.lastName ?? '';
    emailController.text = userData?.email ?? '';

    name = userData?.name ?? '';
    userName = userData?.username ?? '';
    role = userData?.userType ?? '';

    String phone = userData?.phone ?? '';

    if (phone.startsWith('+91')) {
      phone = phone.substring(3); // remove +91
    }

    this.phone = phone;

    profileImage = "${AppUrl.baseUrl}${userData?.profileImage ?? ''}";
    print(profileImage);
    notifyListeners();
  }

  bool isLoading = false;
  Future<void> editProfile(BuildContext context) async {
    isLoading = true;
    notifyListeners();
    try {
      await _repo.editProfile(
        firstNameController.text.trim(),
        lastNameController.text.trim(),
        gstCtr.text.trim(),
      );

      await LocalStorageService.updateUserData(
        firstName: firstNameController.text.trim(),
        lastName: lastNameController.text.trim(),
        gstNumber: gstCtr.text.trim(),
      );

      await getUserData(); // refresh provider data

      AppSnackBar.success(context, "Profile updated successfully");
      Navigator.pop(context);
    } catch (e) {
      AppSnackBar.error(context, "Failed to update profile");
    } finally {
      isLoading = false;
    }
    notifyListeners();
  }
}

// Direct leads

class DirectLeadsProvider extends ChangeNotifier {
  String? leadType;
  List<String> cities = [];
  List<String> propertyTypes = [];

  void selectLeadType(String type) {
    leadType = type;
    notifyListeners();
  }

  void addCity(String city) {
    if (!cities.contains(city)) {
      cities.add(city);
      notifyListeners();
    }
  }

  void removeCity(String city) {
    cities.remove(city);
    notifyListeners();
  }

  void toggleProperty(String type) {
    if (propertyTypes.contains(type)) {
      propertyTypes.remove(type);
    } else {
      propertyTypes.add(type);
    }
    notifyListeners();
  }

  bool get isValid =>
      leadType != null && cities.isNotEmpty && propertyTypes.isNotEmpty;
}

// offline notification

class NotificationProvider extends ChangeNotifier {
  bool _isEnable = true;

  bool get isEnable => _isEnable;

  void toggle(bool value) {
    _isEnable = value;
    notifyListeners();
  }
}

// Feedback pages

class FeedbackProvider extends ChangeNotifier {
  FeedbackProvider() {
    feedbackController.addListener(_textListener);
  }

  void _textListener() {
    notifyListeners();
  }

  String selectedType = "";
  final TextEditingController feedbackController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  final List<String> feedbackTypes = [
    "Report a problem",
    "Raise a question",
    "Suggestion/Improvement",
    "Compliment Tocken",
    "Others",
  ];

  void toggle(String type) {
    selectedType = type;
    notifyListeners();
  }

  // post Feedback

  final AccountRepo _repo = AccountRepo();

  bool isLoading = false;

  Future<void> postFeedback(
    BuildContext context,
    String name,
    String phone,
  ) async {
    isLoading = true;
    notifyListeners();
    try {
      final model = FeedbackReqModel(
        type: selectedType,
        description: feedbackController.text.trim(),
        name: name,
        phone: phone,
      );
      print(model.toJson());
      await _repo.postFeedback(model);
      AppSnackBar.success(
        context,
        "Thank you! Your feedback has been submitted.",
      );
      cleanAll();
      Navigator.pop(context);
    } catch (e) {
      AppSnackBar.error(
        context,
        "Failed to submit feedback. Please try again.",
      );
      isLoading = false;
    } finally {
      isLoading = false;
    }
    notifyListeners();
  }

  void cleanAll() {
    selectedType = '';
    feedbackController.clear();
  }
}

// Bookmarks page

class BookmarkProvider extends ChangeNotifier {
  final List<String> propertyType = [
    "All",
    "Rent",
    "Buy",
    "PG",
    "Plot",
    "Commercial",
    "Projects",
  ];

  String _isSelected = "All";

  String get isSelected => _isSelected;

  void toggle(String type) {
    _isSelected = type;
    notifyListeners();
  }
}

class PhonePrivacyProvider extends ChangeNotifier {
  bool _isEnable = false;
  bool _isLoading = false;

  final _phonePrivacy = AccountRepo();

  bool get isEnable => _isEnable;
  bool get isLoading => _isLoading;

  Future<void> toggle(BuildContext context, bool value) async {
    if (_isLoading) return;

    _isLoading = true;
    notifyListeners();

    try {
      await _phonePrivacy.phonePrivacy(value);

      _isEnable = value;

      AppSnackBar.success(
        context,
        value
            ? "Your phone number has been hidden successfully."
            : "Your phone number is now visible.",
      );
    } catch (e) {
      AppSnackBar.error(
        context,
        "Unable to update phone privacy. Please try again later.",
      );
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

class DeleteAccountProvider extends ChangeNotifier {
  String? selectedReason;
  final TextEditingController feedbackController = TextEditingController();

  void selectReason(String value) {
    selectedReason = value;
    notifyListeners();
  }

  bool get isValid =>
      selectedReason != null && feedbackController.text.trim().isNotEmpty;

  @override
  void dispose() {
    feedbackController.dispose();
    super.dispose();
  }
}
