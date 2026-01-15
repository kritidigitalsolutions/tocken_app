import 'package:flutter/material.dart';

// Type Property provider

class TypePropertyProvider extends ChangeNotifier {
  String? _selectedType;

  String? get selectedType => _selectedType;

  void selectType(String type) {
    _selectedType = type;
    notifyListeners();
  }

  void clearAll() {
    _selectedType = null;
  }
}

// Property details page

class PropertyDetailsProvider extends ChangeNotifier {
  // ----------------- Controllers -----------------
  final TextEditingController propertyTitle = TextEditingController();
  final TextEditingController amountCtr = TextEditingController();
  final TextEditingController areaCtr = TextEditingController();
  final TextEditingController floorNumberCtr = TextEditingController();
  final TextEditingController totalFloorCtr = TextEditingController();

  // ----------------- Constructor -----------------
  PropertyDetailsProvider() {
    // Listen to controller changes to update UI reactively
    propertyTitle.addListener(_onTextChanged);
    amountCtr.addListener(_onTextChanged);
    areaCtr.addListener(_onTextChanged);
    floorNumberCtr.addListener(_onTextChanged);
    totalFloorCtr.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    notifyListeners();
  }

  // --------------- property status accordingly change title -----

  String? sellOrRent;

  String price = "Price";
  String priceHint = "Enter price";

  void togglePrice(String p, String pHint, String sellOrRent) {
    price = p;
    priceHint = pHint;
    this.sellOrRent = sellOrRent;

    notifyListeners();
  }

  // ----------------- BHK Type -----------------
  List<String> bhkTypeList = ['1 BHK', "2 BHK", '3 BHK', "4 BHK", "5 +BHK"];
  String? _bhkType;
  String? get bhkType => _bhkType;

  void toggleType(String type) {
    _bhkType = type;
    notifyListeners();
  }

  // ----------------- Property Status -----------------
  String? _propertyStatus;
  String? get propertyStatus => _propertyStatus;

  void toggleStatus(String status) {
    _propertyStatus = status;
    notifyListeners();
  }

  // ----------------- Furnishing Status -----------------
  List<String> furTypeList = ["Furnished", "Semi-Furnished", "Unfurnished"];
  String? _furType;
  String? get furType => _furType;

  void toggleFurni(String type) {
    _furType = type;
    notifyListeners();
  }

  // ----------------- Validation -----------------
  bool isValid() {
    return propertyTitle.text.trim().isNotEmpty &&
        amountCtr.text.trim().isNotEmpty &&
        areaCtr.text.trim().isNotEmpty &&
        _bhkType != null &&
        _propertyStatus != null &&
        _furType != null &&
        floorNumberCtr.text.trim().isNotEmpty &&
        totalFloorCtr.text.trim().isNotEmpty;
  }

  void clearData() {
    // Clear text fields
    propertyTitle.clear();
    amountCtr.clear();
    areaCtr.clear();
    floorNumberCtr.clear();
    totalFloorCtr.clear();

    // Reset selections
    _bhkType = null;
    _propertyStatus = null;
    _furType = null;

    // Notify UI
    notifyListeners();
  }

  // ----------------- Dispose -----------------
  @override
  void dispose() {
    propertyTitle.dispose();
    amountCtr.dispose();
    areaCtr.dispose();
    floorNumberCtr.dispose();
    totalFloorCtr.dispose();
    super.dispose();
  }
}

// Address details

class AddressDetailsProvider extends ChangeNotifier {
  String? city;

  final localityCtr = TextEditingController();
  final addressCtr = TextEditingController();
  final cityCtr = TextEditingController();

  /// city selected or not
  bool get isCitySelected => cityCtr.text.trim().isNotEmpty;

  /// full form validation
  bool get isFormValid =>
      isCitySelected &&
      localityCtr.text.isNotEmpty &&
      addressCtr.text.isNotEmpty;

  void setCity(String value) {
    city = value;
    notifyListeners();
  }

  @override
  void dispose() {
    localityCtr.dispose();
    addressCtr.dispose();
    super.dispose();
  }
}

class RoomDetailsProvider extends ChangeNotifier {
  DateTime? availableFrom;
  String? bhk;
  String? furnishType;
  Set<String> roomDetails = {};
  final totalFloorsCtrl = TextEditingController();
  final yourFloorCtrl = TextEditingController();

  final furnishTypes = ["Fully Furnished", "Semi Furnished", "Unfurnished"];

  final bhkOptions = ["1RK", "1BHK", "2BHK", "3BHK", "4BHK", "5BHK"];

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
}
