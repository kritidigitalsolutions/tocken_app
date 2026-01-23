import 'package:flutter/material.dart';
import 'package:token_app/viewModel/afterLogin/post_property_provider/pg_provider.dart';

class CoLivingProvider extends ChangeNotifier {
  final TextEditingController nameCtr = TextEditingController(
    text: "Amit Kumar",
  );
  final TextEditingController mobileCtr = TextEditingController(
    text: "6397892585",
  );
  final TextEditingController dobCtr = TextEditingController(
    text: "12/01/2010",
  );

  final TextEditingController lanCtr = TextEditingController();
  final TextEditingController hobbCtr = TextEditingController();
  final TextEditingController shiftDate = TextEditingController();

  final List<String> genderList = ["Male", "Female", "Other"];

  // for number hide

  bool hideNumber = false;

  void toggleHideNumber(bool value) {
    hideNumber = value;
    notifyListeners();
  }

  // Gender

  String gender = '';

  void selectGender(String value) {
    gender = value;
    notifyListeners();
  }

  // Occupation

  String? occupation;

  bool get isEmpty => occupation != null && occupation!.isNotEmpty;

  void selectOccupation(String value) {
    occupation = value;
    notifyListeners();
  }

  // Room Details

  DateTime? availableFrom;
  String? bhk;
  Set<String> roomDetails = {};
  final totalFloorsCtrl = TextEditingController();
  final yourFloorCtrl = TextEditingController();

  final furnishTypes = ["Fully Furnished", "Semi Furnished", "Unfurnished"];

  // ================= furniture type =======================

  String? furnishType;
  final bhkOptions = ["1RK", "1BHK", "2BHK", "3BHK", "4BHK", "5BHK"];

  void setFurnishType(String value) {
    furnishType = value;
    notifyListeners();
  }

  bool get canOpenFurnishing =>
      furnishType == "Fully Furnished" || furnishType == "Semi Furnished";

  //===========================///// ====================

  final roomDetailOptions = [
    "Attached Bathroom",
    "Attached Balcony",
    "AC Room",
  ];

  void setDate(DateTime date) {
    availableFrom = date;
    notifyListeners();
  }

  void setBhk(String value) {
    bhk = value;
    notifyListeners();
  }

  void setFurnish(String value) {
    furnishType = value;
    notifyListeners();
  }

  void toggleRoomDetail(String value) {
    if (roomDetails.contains(value)) {
      roomDetails.remove(value);
    } else {
      roomDetails.add(value);
    }
    notifyListeners();
  }

  bool get isValid =>
      availableFrom != null &&
      bhk != null &&
      furnishType != null &&
      totalFloorsCtrl.text.isNotEmpty &&
      yourFloorCtrl.text.isNotEmpty;

  //  amenities ===================

  void toggleItem(List<AmenityModel> list, int index) {
    list[index].isSelected = !list[index].isSelected;
    notifyListeners();
  }

  List<AmenityModel> selectedAmenityModel(List<AmenityModel> list) {
    final selected = list.where((e) => e.isSelected).toList();

    return selected;
  }

  /// ==================
  ///

  //============== Pricing pages ===================

  final rentCtrl = TextEditingController();
  final maintenanceCtrl = TextEditingController();
  final bookingCtrl = TextEditingController();
  final otherCtrl = TextEditingController();

  bool negotiable = false;
  bool utilitiesIncluded = false;

  void toggleNegotiable(bool value) {
    negotiable = value;
    notifyListeners();
  }

  void toggleutilitiesIncludede(bool value) {
    utilitiesIncluded = value;
    notifyListeners();
  }

  // =========================================

  // =============== Sharing preference ================

  final List<String> partnerGenderList = ["Male", "Female", "Any"];

  final List<String> partnerOccList = [
    "Student",
    "Working Professional",
    "Other",
  ];

  String pGender = '';

  Set<String> selectedPOcc = {};

  bool isSelectedPOcc(value) => selectedPOcc.contains(value);

  void setPGender(String value) {
    pGender = value;
    notifyListeners();
  }

  void setPOcc(String value) {
    if (selectedPOcc.contains(value)) {
      selectedPOcc.remove(value);
    } else {
      selectedPOcc.add(value);
    }

    notifyListeners();
  }

  String minAge = "18 years";
  String maxAge = "60 years";

  void setMinAge(String value) {
    minAge = value;
    notifyListeners();
  }

  void setMaxAge(String value) {
    maxAge = value;
    notifyListeners();
  }
}
