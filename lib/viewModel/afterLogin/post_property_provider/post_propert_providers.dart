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

class AddressDetailsProvider extends ChangeNotifier {}
