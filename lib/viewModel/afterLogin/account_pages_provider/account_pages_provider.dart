import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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

  String selectedType = "Report a problem";
  final TextEditingController feedbackController = TextEditingController();
  final TextEditingController nameController = TextEditingController(
    text: "Amit Kumar",
  );
  final TextEditingController emailController = TextEditingController();

  final List<String> feedbackTypes = [
    "Report a problem",
    "Raise a question",
    "Suggestion/Improvement",
    "Compliment Hexdome",
    "Others",
  ];

  void toggle(String type) {
    selectedType = type;
    notifyListeners();
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
