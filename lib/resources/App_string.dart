class AppString {
  static const List<String> bhkList = ["1BHK", "2BHK", "3BHK", "4BHK", "5BHK"];
  static const List<String> pgForList = ["Male", "Female", "All"];
  static const List<String> bestSuitedList = [
    "Working",
    "Student",
    "Business",
    "Other",
  ];
  static const List<String> furnishTypeList = [
    "Fully Furnished",
    "Semi Furnished",
    "Unfurnished",
  ];
  static const List<String> propertyManagedByList = [
    "Owner",
    "Agent",
    "Company",
  ];
  static const List<String> yesNoList = ["Yes", "No"];
  static const List<String> securityDeposit = [
    "Fixed",
    "Multiple of Rent",
    "None",
  ];
  static const List<String> roomSharingList = [
    "Private",
    "Twin",
    "Triple",
    "Quad",
  ];
  static const List<String> serviceList = [
    "Water Charges",
    "Laundry",
    "Wifi",
    "House Keeping",
    "Maintenance",
    "Cooking Gas",
    "Trash Removal",
    "DTH",
  ];
  static const List<String> mealTimeList = ["Breakfast", "Lunch", "Dinner"];
  static const List<String> entryTimeList = [
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
  static const List<String> commonAreaList = [
    "Living Room",
    "Kitchen",
    "Dining Hall",
    "Pooja Room",
    "Study Room",
  ];
  static const List<String> prefeTenant = [
    "Family",
    "Male",
    "Female",
    "Others",
  ];
  static const List<String> facingList = [
    "East",
    "West",
    "North",
    "South",
    "North-East",
    "North-West",
    "South-East",
    "South-West",
  ];
  static const List<String> flooringTypeList = [
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
  static const List<String> ageOfProperty = [
    "0-1 years",
    "1-5 years",
    "5-10 years",
    "10+ years",
  ];
  static const List<String> noOfBathroom = ["1", "2", "3", "3+"];
  static const List<String> noOfBalcony = ["0", "1", "2", "3+"];
  static const List<String> roomList = [
    "Pooja Room",
    "Home Gym",
    "Study Room",
    "Servant Room",
    "Game Room",
    "Others",
  ];
  static const List<String> measurmentList = [
    "Sq ft",
    "Sq m",
    "Sq yd",
    "Sq guz",
  ];
  static const List<String> expectedTimeList = [
    "Within 15 days",
    "Within 1 month",
    "Within 2 month",
    "Within 3 month",
    "Within 6 month",
    "By 2025",
    "By 2026",
    "By 2027",
    "By 2027",
    "By 2029",
    "By 2030",
  ];
  static const List<String> locationHubList = [
    "Shopping Malls",
    "Commercial Project",
    "Market/High Street",
    "Retail Complex/Building",
    "Industrail Areas",
    "Healthcare Center",
    "Commercial Streets",
    "Downtown or City Center",
    "Tourist Areas",
    "Transport Hubs",
    "Business Districts",
    "Entertainment Complexes",
    "Other",
  ];
  static const List<String> zoneList = [
    "Industrail Complex",
    "Commercial Complex",
    "Residential Complex",
    "Agriculture Zone",
    "Special Economic Zone",
    "Natural Conservation Zone",
    "Transport and Communication",
    "Public Utilities",
    "Public and Semi Public use",
    "Open Space",
    "IT Park",
    "Business Park",
    "Corporate Campus",
    "Government Use"
        "Other",
  ];
  static const List<String> ownerTypeList = [
    "Freehold",
    "Power of attorney",
    "Lease Holder",
    "Cooperative Society",
  ];
  static const List<String> fire = [
    "Fire Extinguisher",
    "Fire Sensors",
    "Sprinkles",
    "Firehose",
  ];
  static const List<String> wallStatusList = [
    "No Walls",
    "Brick Walls",
    "Cemented Walls",
    "Plastered Walls",
    "Other",
  ];
  static const List<String> washroomList = [
    "Shared",
    "1 Washroom",
    "2 Washroom",
    "3 Washroom",
    "4 Washroom",
    "4+ Washroom",
  ];
  static const List<String> retailSuitableForList = [
    "Jewellery",
    "Gym",
    "Medical/Clinic",
    "Footwear Shop",
    "Clothing Store",
    "Supermarket/Grocery Store",
    "Electronic Store",
    "Home Furnishings Store",
    "Beauty & Cosmetics Store",
    "Toy Store",
    "Book Store",
    "Stationary Store",
    "Pet Store",
    "General Store",
    "Other",
  ];
  static const List<String> parkingTypeList = [
    "Private parking in basement",
    "Private parking outside",
    "Public Parking",
  ];
  static const List<String> plotLandConstructionList = [
    "Shed",
    "Room",
    "Washroom",
    "Other",
  ];
  static Map<String, int> amenities = {
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

  static final amenityList = [
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
}
