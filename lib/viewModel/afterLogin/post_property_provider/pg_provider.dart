import 'package:flutter/material.dart';

enum SecurityDepositType { fixed, multiple, none }

class PgDetailsProvider extends ChangeNotifier {
  // ---------------- CONTROLLERS ----------------
  final pgNameController = TextEditingController();
  final floorsController = TextEditingController();
  final dataCtr = TextEditingController();

  // ---------------- STATIC LISTS ----------------
  final List<String> pgForList = ["Male", "Female", "All"];
  final List<String> bestSuitedList = [
    "Working",
    "Student",
    "Business",
    "Other",
  ];
  final List<String> furnishTypeList = [
    "Fully Furnished",
    "Semi Furnished",
    "Unfurnished",
  ];
  final List<String> propertyManagedByList = ["Owner", "Agent", "Company"];
  final List<String> yesNoList = ["Yes", "No"];

  final List<String> securityDeposit = ["Fixed", "Multiple of Rent", "None"];

  // ---------------- SELECTIONS ----------------
  String? pgFor;
  String? managerStay;

  String? propertyManagedBy;

  String? securityDep;

  int coveredParking = 0;
  int openParking = 0;

  // ---------------- MULTI SELECT ----------------
  final Set<String> _bestSuitedFor = {};

  Set<String> get bestSuitedFor => _bestSuitedFor;

  void toggleBestSuited(String value) {
    _bestSuitedFor.contains(value)
        ? _bestSuitedFor.remove(value)
        : _bestSuitedFor.add(value);
    notifyListeners();
  }

  bool isSelected(String value) => _bestSuitedFor.contains(value);

  final List<String> roomSharingList = ["Private", "Twin", "Triple", "Quad"];

  final Set<String> _roomSharing = {};
  Set<String> get roomSharing => _roomSharing;

  final Map<String, TextEditingController> roomAmountCtr = {};

  void toggleRoomSharing(String value) {
    if (_roomSharing.contains(value)) {
      _roomSharing.remove(value);
      roomCountCtr[value]?.clear();
      roomAmountCtr.remove(value);
      attachedBathroom.remove(value);
      attachedBalcony.remove(value);
    } else {
      _roomSharing.add(value);
      roomAmountCtr[value] = TextEditingController();
    }
    notifyListeners();
  }

  bool isRoomSharingSelected(String value) => _roomSharing.contains(value);

  // ---------------- ROOM DATA PER TYPE ----------------
  final Map<String, TextEditingController> roomCountCtr = {};
  final Map<String, bool> attachedBathroom = {};
  final Map<String, bool> attachedBalcony = {};

  TextEditingController getRoomController(String type) {
    return roomCountCtr.putIfAbsent(type, () => TextEditingController());
  }

  bool getBathroom(String type) => attachedBathroom[type] ?? false;
  bool getBalcony(String type) => attachedBalcony[type] ?? false;

  void toggleBathroom(String type) {
    attachedBathroom[type] = !(attachedBathroom[type] ?? false);
    notifyListeners();
  }

  void toggleBalcony(String type) {
    attachedBalcony[type] = !(attachedBalcony[type] ?? false);
    notifyListeners();
  }

  // ---------------- SINGLE SELECT ----------------
  void selectPgFor(String value) {
    pgFor = value;
    notifyListeners();
  }

  void selectManagerStay(String value) {
    managerStay = value;
    notifyListeners();
  }

  void setPropertyManager(String value) {
    propertyManagedBy = value;
    notifyListeners();
  }

  void incCovered() {
    coveredParking++;
    notifyListeners();
  }

  void decCovered() {
    if (coveredParking > 0) coveredParking--;
    notifyListeners();
  }

  void incOpen() {
    openParking++;
    notifyListeners();
  }

  void decOpen() {
    if (openParking > 0) openParking--;
    notifyListeners();
  }

  void selectSecurityDepo(String value) {
    securityDep = value;
    notifyListeners();
  }

  @override
  void dispose() {
    pgNameController.dispose();
    floorsController.dispose();
    dataCtr.dispose();

    for (final controller in roomCountCtr.values) {
      controller.dispose();
    }

    super.dispose();
  }

  String? furnishType;

  final Map<String, SecurityDepositType> roomSecurityType = {};
  final Map<String, TextEditingController> fixedDepositCtr = {};
  final Map<String, int> multipleOfRent = {};

  void setSecurityType(String room, SecurityDepositType type) {
    roomSecurityType[room] = type;

    if (type == SecurityDepositType.fixed) {
      fixedDepositCtr.putIfAbsent(room, () => TextEditingController());
    } else {
      fixedDepositCtr[room]?.clear();
    }

    if (type == SecurityDepositType.multiple) {
      multipleOfRent[room] = multipleOfRent[room] ?? 1;
    }

    notifyListeners();
  }

  SecurityDepositType getSecurityType(String room) {
    return roomSecurityType[room] ?? SecurityDepositType.none;
  }

  // ----- SET FURNISH TYPE -----
  void setFurnishType(String value) {
    furnishType = value;
    notifyListeners();
  }

  // ----- TOTAL SELECTED AMENITIES -----
  int totalAmenities() {
    return amenities.values.fold(0, (sum, val) => sum + val);
  }

  int getAmenityCount(String key) {
    return amenities[key] ?? 0;
  }

  // ----- MIN REQUIRED BASED ON TYPE -----
  int get minRequiredAmenities {
    if (furnishType == "Fully Furnished") return 6;
    if (furnishType == "Semi Furnished") return 3;
    return 0;
  }

  bool get canOpenFurnishing =>
      furnishType == "Fully Furnished" || furnishType == "Semi Furnished";

  bool get isAmenitiesValid => totalAmenities() >= minRequiredAmenities;

  // ----- COUNTER HANDLERS -----
  void inc(String key) {
    updateAmenity(key, 1);
  }

  void dec(String key) {
    updateAmenity(key, -1);
  }

  void updateAmenity(String key, int delta) {
    if (amenities.containsKey(key)) {
      amenities[key] = (amenities[key]! + delta).clamp(0, 99);
      notifyListeners();
    }
  }

  Map<String, int> amenities = {
    "fan": 0,
    "ac": 0,
    "tv": 0,
    "bed": 0,
    "wardrobe": 0,
    "geyser": 0,
    "sofa": 0,
    "washingMachine": 0,
    "stove": 0,
    "fridge": 0,
    "waterPurifier": 0,
    "microwave": 0,
    "modularKitchen": 0,
    "chimney": 0,
    "diningTable": 0,
    "curtains": 0,
    "exhaustFan": 0,
    "lights": 0,
  };

  final amenityList = [
    {"name": "Fans", "key": "fan"},
    {"name": "AC", "key": "ac"},
    {"name": "TV", "key": "tv"},
    {"name": "Beds", "key": "bed"},
    {"name": "Wardrobe", "key": "wardrobe"},
    {"name": "Geysers", "key": "geyser"},
    {"name": "Sofa", "key": "sofa"},
    {"name": "Washing Machine", "key": "washingMachine"},
    {"name": "Stove", "key": "stove"},
    {"name": "Fridge", "key": "fridge"},
    {"name": "Water Purifier", "key": "waterPurifier"},
    {"name": "Microwave", "key": "microwave"},
    {"name": "Modular Kitchen", "key": "modularKitchen"},
    {"name": "Chimney", "key": "chimney"},
    {"name": "Dining Table", "key": "diningTable"},
    {"name": "Curtains", "key": "curtains"},
    {"name": "Exhaust Fan", "key": "exhaustFan"},
    {"name": "Lights", "key": "lights"},
  ];

  // pricing

  final List<String> serviceList = [
    "Water Charges",
    "Laundry",
    "Wifi",
    "House Keeping",
    "Maintenance",
    "Cooking Gas",
    "Trash Removal",
    "DTH",
  ];

  final Set<String> _selectedService = {};

  bool isSelectedService(String value) => _selectedService.contains(value);

  void toggleService(String service) {
    if (_selectedService.contains(service)) {
      _selectedService.remove(service);
    } else {
      _selectedService.add(service);
    }
    notifyListeners();
  }

  String mealsAvailable = ""; // Yes / No / Extra fees apply
  String mealType = ""; // Only Veg / Veg & Non Veg

  Set<String> mealTime = {};

  List<String> mealTimeList = ["Breakfast", "Lunch", "Dinner"];

  bool isSelectedMealTime(value) => mealTime.contains(value);

  final TextEditingController mealAmountCtr = TextEditingController();

  /// ---------------- SETTERS ----------------
  void setMealsAvailable(String value) {
    mealsAvailable = value;

    // Reset dependent fields if "No"
    if (value == "No") {
      mealType = "";
      mealTime.clear();
      mealAmountCtr.clear();
    }

    notifyListeners();
  }

  void setMealType(String value) {
    mealType = value;
    notifyListeners();
  }

  void setMealTime(String value) {
    if (mealTime.contains(value)) {
      mealTime.remove(value);
    } else {
      mealTime.add(value);
    }
    notifyListeners();
  }

  /// ---------------- HELPERS ----------------
  bool get showMealDetails =>
      mealsAvailable == "Yes" || mealsAvailable == "Extra fees apply";

  // noticed periods

  int? noticePeriod;

  void togglePeriod(int value) {
    noticePeriod = value;
    notifyListeners();
  }

  // Lock in Period

  String LockPerdiod = '';

  void toggleLockPeriod(String value) {
    LockPerdiod = value;
    notifyListeners();
  }

  // add More pricing Details

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

  // Contact & Amenties For Pg

  List<String> entryTimeList = [
    "7 PM",
    "7:30 PM",
    "8 PM",
    "8:30 PM",
    "9 PM",
    "9:30 PM",
    "10 PM",
    "10:30 PM",
    "11 PM",
    "11:30 PM",
    "12 PM",
  ];

  List<String> commonAreaList = [
    "Living Room",
    "Kitchen",
    "Dining Hall",
    "Pooja Room",
    "Study Room",
  ];

  Set<String> selectedArea = {};

  bool isSelectedArea(value) => selectedArea.contains(value);

  void toggelArea(String value) {
    if (selectedArea.contains(value)) {
      selectedArea.remove(value);
    } else {
      selectedArea.add(value);
    }
    notifyListeners();
  }

  bool hideNumber = false;

  void toggleHideNumber(bool value) {
    hideNumber = value;
    notifyListeners();
  }

  String? lastEntryTime;

  void toggleEntryTime(String value) {
    lastEntryTime = value;
    notifyListeners();
  }

  /// toggle selection
  void toggleItem(List<AmenityModel> list, int index) {
    list[index].isSelected = !list[index].isSelected;
    notifyListeners();
  }

  List<AmenityModel> selectedAmenityModel(List<AmenityModel> list) {
    final selected = list.where((e) => e.isSelected).toList();

    return selected;
  }

  /// Rent and sale page
  ///
  final TextEditingController dateCtr = TextEditingController();
  final TextEditingController propertyTypeCtr = TextEditingController();

  final Set<String> selectedTenant = {};

  bool isSelectedTenant(value) => selectedTenant.contains(value);

  void setTenant(String value) {
    if (selectedTenant.contains(value)) {
      selectedTenant.remove(value);
    } else {
      selectedTenant.add(value);
    }
    notifyListeners();
  }

  final prefeTenant = ["Family", "Male", "Female", "Others"];

  // === facing -======

  String? facing;

  final List<String> facingList = [
    "East",
    "West",
    "North",
    "South",
    "North-East",
    "North-West",
    "South-East",
    "South-West",
  ];

  void setFacing(String value) {
    facing = value;
    notifyListeners();
  }

  // Floaring type ''''''

  String? flooring;
  void setFlooring(String value) {
    flooring = value;
    notifyListeners();
  }

  final List<String> flooringTypeList = [
    "Vitrified Tiles",
    "Marble",
    "Granite",
    "Wooden",
    "Laminated",
    "Ceramic Tiles",
    "Mosaic",
    "Italian Marble",
    "Cement",
    "Stone",
    "Other",
  ];

  // age of property

  String? propertyAge;
  final List<String> ageOfProperty = [
    "0-1 years",
    "1-5 years",
    "5-10 years",
    "10+ years",
  ];

  void setAgeProperty(String value) {
    propertyAge = value;
    notifyListeners();
  }

  // BHK type

  final List<String> bhkList = ["1BHK", "2BHK", "3BHK", "4BHK", "5BHK"];

  String selectedBhk = "";
  void setBHKType(String value) {
    selectedBhk = value;
    notifyListeners();
  }

  // Bathrooms

  String? bathrooms;
  final List<String> noOfBathroom = ["1", "2", "3", "4+"];

  void setBathrooms(String value) {
    bathrooms = value;
    notifyListeners();
  }

  // Balconies

  String? balconies;
  final List<String> noOfBalcony = ["0", "1", "2", "3+"];

  void setBalcony(String value) {
    balconies = value;
    notifyListeners();
  }

  // Additional Room

  final List<String> roomList = [
    "Pooja Room",
    "Home Gym",
    "Study Room",
    "Servant Room",
  ];

  Set<String> selectedRoom = {};

  bool isSelectedRoom(value) => selectedRoom.contains(value);

  void setAdditionalRoom(String value) {
    if (selectedRoom.contains(value)) {
      selectedRoom.remove(value);
    } else {
      selectedRoom.add(value);
    }
    notifyListeners();
  }

  // Area detail

  final carpetAreaCtr = TextEditingController();
  final buildAreaCtr = TextEditingController();

  final List<String> measurmentList = ["Sq ft", "Sq m", "Sq yd", "Sq guz"];

  String builtMeasuType = "Sq ft";
  String carpetMeasuType = "Sq ft";

  void setBuildArea(String value) {
    builtMeasuType = value;
    notifyListeners();
  }

  void setCarpetArea(String value) {
    carpetMeasuType = value;
    notifyListeners();
  }

  bool isBrokerAllow = false;

  void toggleBroker(bool value) {
    isBrokerAllow = value;
    notifyListeners();
  }
}

class AmenityModel {
  final String title;
  final String icon; // asset path
  bool isSelected;

  AmenityModel({
    required this.title,
    required this.icon,
    this.isSelected = false,
  });
}

List<AmenityModel> amenitiesList = [
  AmenityModel(title: "Lift", icon: "assets/icons/lift.png"),
  AmenityModel(title: "Power Backup", icon: "assets/icons/power.png"),
  AmenityModel(title: "Gym", icon: "assets/icons/gym.png"),
  AmenityModel(title: "Swimming Pool", icon: "assets/icons/pool.png"),
  AmenityModel(title: "CCTV Surveillance", icon: "assets/icons/cctv.png"),
  AmenityModel(title: "Gated Community", icon: "assets/icons/gated.png"),
  AmenityModel(title: "Water Supply", icon: "assets/icons/water.png"),
  AmenityModel(title: "Parking Lot", icon: "assets/icons/parking.png"),
  AmenityModel(title: "Kids Area", icon: "assets/icons/kids.png"),
  AmenityModel(title: "Playground", icon: "assets/icons/playground.png"),
  AmenityModel(title: "Community Garden", icon: "assets/icons/garden.png"),
  AmenityModel(title: "Free Wifi", icon: "assets/icons/wifi.png"),
  AmenityModel(title: "Club", icon: "assets/icons/club.png"),
  AmenityModel(title: "Gas", icon: "assets/icons/gas.png"),
  AmenityModel(title: "Sewage", icon: "assets/icons/sewage.png"),
];

List<AmenityModel> preferencesList = [
  AmenityModel(title: "Bachelor", icon: "assets/icons/lift.png"),
  AmenityModel(title: "Family", icon: "assets/icons/power.png"),
  AmenityModel(title: "Living Couple", icon: "assets/icons/gym.png"),
  AmenityModel(title: "Professional", icon: "assets/icons/pool.png"),
  AmenityModel(title: "No Pets", icon: "assets/icons/cctv.png"),
  AmenityModel(title: "No Smoking", icon: "assets/icons/gated.png"),
  AmenityModel(title: "Student", icon: "assets/icons/water.png"),
  AmenityModel(title: "Guests are allowed", icon: "assets/icons/parking.png"),
  AmenityModel(title: "Only Veg", icon: "assets/icons/gated.png"),
  AmenityModel(title: "Gender Restrictions", icon: "assets/icons/water.png"),
  AmenityModel(title: "No Alcohol", icon: "assets/icons/parking.png"),
];

Map<String, int> amenities = {
  "fan": 0,
  "ac": 0,
  "tv": 0,
  "bed": 0,
  "wardrobe": 0,
  "geyser": 0,
  "sofa": 0,
  "washingMachine": 0,
  "stove": 0,
  "fridge": 0,
  "waterPurifier": 0,
  "microwave": 0,
  "modularKitchen": 0,
  "chimney": 0,
  "diningTable": 0,
  "curtains": 0,
  "exhaustFan": 0,
  "lights": 0,
};

final amenityList = [
  {"name": "Fans", "key": "fan"},
  {"name": "AC", "key": "ac"},
  {"name": "TV", "key": "tv"},
  {"name": "Beds", "key": "bed"},
  {"name": "Wardrobe", "key": "wardrobe"},
  {"name": "Geysers", "key": "geyser"},
  {"name": "Sofa", "key": "sofa"},
  {"name": "Washing Machine", "key": "washingMachine"},
  {"name": "Stove", "key": "stove"},
  {"name": "Fridge", "key": "fridge"},
  {"name": "Water Purifier", "key": "waterPurifier"},
  {"name": "Microwave", "key": "microwave"},
  {"name": "Modular Kitchen", "key": "modularKitchen"},
  {"name": "Chimney", "key": "chimney"},
  {"name": "Dining Table", "key": "diningTable"},
  {"name": "Curtains", "key": "curtains"},
  {"name": "Exhaust Fan", "key": "exhaustFan"},
  {"name": "Lights", "key": "lights"},
];
