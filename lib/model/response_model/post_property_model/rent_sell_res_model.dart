class RentSellResModel {
  RentSellResModel({
    required this.listingType,
    required this.propertyType,
    required this.propertyCategory,
    required this.residentialDetails,
    required this.pricing,
    required this.location,
    required this.contact,
    required this.amenities,
    required this.preferences,
    required this.images,
    required this.description,
  });

  final String? listingType;
  final String? propertyType;
  final String? propertyCategory;
  final ResidentialDetails? residentialDetails;
  final Pricing? pricing;
  final Location? location;
  final Contact? contact;
  final List<String> amenities;
  final List<String> preferences;
  final List<String> images;
  final String? description;

  Map<String, dynamic> toJson() => {
    "listingType": listingType,
    "propertyType": propertyType,
    "propertyCategory": propertyCategory,
    "residentialDetails": residentialDetails?.toJson(),
    "pricing": pricing?.toJson(),
    "location": location?.toJson(),
    "contact": contact?.toJson(),
    "amenities": amenities.map((x) => x).toList(),
    "preferences": preferences.map((x) => x).toList(),
    "images": images.map((x) => x).toList(),
    "description": description,
  };
}

class Contact {
  Contact({required this.phone, required this.phonePrivate});

  final String? phone;
  final bool? phonePrivate;

  Map<String, dynamic> toJson() => {
    "phone": phone,
    "phonePrivate": phonePrivate,
  };
}

class Location {
  Location({required this.city, required this.locality, required this.society});

  final String? city;
  final String? locality;
  final String? society;

  Map<String, dynamic> toJson() => {
    "city": city,
    "locality": locality,
    "society": society,
  };
}

class Pricing {
  Pricing({
    required this.rent,
    required this.amenities,
    required this.securityDeposit,
    required this.noticePeriod,
    required this.lockInPeriod,
  });

  final Rent? rent;
  final List<SecurityDeposit> amenities;
  final SecurityDeposit? securityDeposit;
  final int? noticePeriod;
  final LockInPeriod? lockInPeriod;

  Map<String, dynamic> toJson() => {
    "rent": rent?.toJson(),
    "amenities": amenities.map((x) => x.toJson()).toList(),
    "securityDeposit": securityDeposit?.toJson(),
    "noticePeriod": noticePeriod,
    "lockInPeriod": lockInPeriod?.toJson(),
  };
}

class SecurityDeposit {
  SecurityDeposit({required this.label, required this.amount});

  final String? label;
  final int? amount;

  Map<String, dynamic> toJson() => {"label": label, "amount": amount};
}

class LockInPeriod {
  LockInPeriod({required this.label, required this.month});

  final String? label;
  final int? month;
  Map<String, dynamic> toJson() => {"label": label, "month": month};
}

class Rent {
  Rent({
    required this.label,
    required this.rantAmount,
    required this.isElectricity,
    required this.isNegotiable,
  });

  final String? label;
  final int? rantAmount;
  final bool? isElectricity;
  final bool? isNegotiable;

  Map<String, dynamic> toJson() => {
    "label": label,
    "rantAmount": rantAmount,
    "isElectricity": isElectricity,
    "isNegotiable": isNegotiable,
  };
}

class ResidentialDetails {
  ResidentialDetails({
    required this.ageOfProperty,
    required this.bhkType,
    required this.bathrooms,
    required this.balconies,
    required this.additionalRooms,
    required this.furnishing,
    required this.facing,
    required this.flooring,
    required this.area,
    required this.parking,
    required this.totalFloors,
    required this.yourFloor,
    required this.preferredTenants,
    required this.availableFrom,
    required this.isBroker,
  });

  final String? ageOfProperty;
  final String? bhkType;
  final String? bathrooms;
  final String? balconies;
  final List<String> additionalRooms;
  final Furnishing? furnishing;
  final String? facing;
  final String? flooring;
  final Area? area;
  final Parking? parking;
  final int? totalFloors;
  final int? yourFloor;
  final List<String> preferredTenants;
  final DateTime? availableFrom;
  final bool? isBroker;

  Map<String, dynamic> toJson() => {
    "ageOfProperty": ageOfProperty,
    "bhkType": bhkType,
    "bathrooms": bathrooms,
    "balconies": balconies,
    "additionalRooms": additionalRooms.map((x) => x).toList(),
    "furnishing": furnishing?.toJson(),
    "facing": facing,
    "flooring": flooring,
    "area": area?.toJson(),
    "parking": parking?.toJson(),
    "totalFloors": totalFloors,
    "yourFloor": yourFloor,
    "preferredTenants": preferredTenants.map((x) => x).toList(),
    "availableFrom": availableFrom?.toIso8601String(),
    "isBroker": isBroker,
  };
}

class Area {
  Area({required this.builtUp, required this.carpet});

  final BuiltUp? builtUp;
  final BuiltUp? carpet;

  Map<String, dynamic> toJson() => {
    "builtUp": builtUp?.toJson(),
    "carpet": carpet?.toJson(),
  };
}

class BuiltUp {
  BuiltUp({required this.value, required this.unit});

  final int? value;
  final String? unit;

  Map<String, dynamic> toJson() => {"value": value, "unit": unit};
}

class Furnishing {
  Furnishing({required this.type, required this.amenities});

  final String? type;
  final List<Amenity> amenities;

  Map<String, dynamic> toJson() => {
    "type": type,
    "amenities": amenities.map((x) => x.toJson()).toList(),
  };
}

class Amenity {
  Amenity({required this.name, required this.quantity});

  final String? name;
  final int? quantity;

  Map<String, dynamic> toJson() => {"name": name, "quantity": quantity};
}

class Parking {
  Parking({required this.parkingDetails});

  final List<ParkingDetail> parkingDetails;

  Map<String, dynamic> toJson() => {
    "parkingDetails": parkingDetails.map((x) => x.toJson()).toList(),
  };
}

class ParkingDetail {
  ParkingDetail({required this.label, required this.value});

  final String? label;
  final int? value;

  Map<String, dynamic> toJson() => {"label": label, "value": value};
}
