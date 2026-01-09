import 'package:flutter/material.dart';

class FilterProvider extends ChangeNotifier {
  List<String> propertyType = [
    "Apartment",
    "Builder Floor",
    "Independent House",
    "Villa",
    "1RK/Studio House",
  ];

  List<String> commercialPropertyType = [
    "Ready to use Office Space",
    "Retail Shaop",
    "Bareshell Office Space",
    "Showroom",
    "Warehouese",
  ];

  List<String> prefeTenant = ["Family", "Male", "Female", "Others"];
  List<String> bhkType = ["1BHK", "2BHK", "3BHK", "4BHK", "5BHK", "5+BHK"];

  List<String> furnishType = [
    "Fully Furnished",
    " Semi Furnished",
    "Unfurnished",
  ];

  // ------------------ rent button ------------

  String _rentType = "Residential";

  String get rentType => _rentType;

  void toggleRent(String type) {
    _rentType = type;
    notifyListeners();
  }

  final Set<String> selectedPropertyType = {};
  final Set<String> selectedCommPropertyType = {};
  final Set<String> selectedTenant = {};
  final Set<String> selectedBhk = {};
  final Set<String> selectedFurnish = {};
  void toggleSelection(Set<String> list, String value) {
    if (list.contains(value)) {
      list.remove(value);
    } else {
      list.add(value);
    }
    notifyListeners();
  }

  // ---------------- Budget ----------------
  final List<String> budgetList = [
    "1K",
    "5K",
    "10K",
    "20K",
    "30K",
    "40K",
    "50+K",
  ];

  String selectedMinBudget = "1K";
  String selectedMaxBudget = "50+K";

  void setMinBudget(String value) {
    selectedMinBudget = value;
    notifyListeners();
  }

  void setMaxBudget(String value) {
    selectedMaxBudget = value;
    notifyListeners();
  }

  // ---------------- Built-up Area ----------------
  final List<String> areaList = [
    "100 sq ft",
    "300 sq ft",
    "500 sq ft",
    "1000 sq ft",
    "2000 sq ft",
    "4000+ sq ft",
  ];

  String selectedMinArea = "100 sq ft";
  String selectedMaxArea = "4000+ sq ft";

  void setMinArea(String value) {
    selectedMinArea = value;
    notifyListeners();
  }

  void setMaxArea(String value) {
    selectedMaxArea = value;
    notifyListeners();
  }

  // ------------------- co living filter page -------------

  List<String> preGender = ["Male", "Female", "All"];

  List<String> roomFor = ["Student", " Working Professional", "Other"];

  String _lookFor = "Room/Flat";

  String get lookFor => _lookFor;

  void toggleLookFor(String type) {
    _lookFor = type;
    notifyListeners();
  }

  String gender = 'Male';

  void toggleGender(String gender) {
    this.gender = gender;
    notifyListeners();
  }

  final Set<String> selectedRoomFor = {};
  void toggleRoomFor(String value) {
    if (selectedRoomFor.contains(value)) {
      selectedRoomFor.remove(value);
    } else {
      selectedRoomFor.add(value);
    }
    notifyListeners();
  }

  //  String selectedCoLivingMinArea = "100 sq ft";
  // String selectedMaxArea = "4000+ sq ft";

  // void setMinArea(String value) {
  //   selectedMinArea = value;
  //   notifyListeners();
  // }

  // void setMaxArea(String value) {
  //   selectedMaxArea = value;
  //   notifyListeners();
  // }
}
