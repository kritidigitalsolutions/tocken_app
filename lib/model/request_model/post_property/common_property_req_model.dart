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

class LockInPeriod {
  LockInPeriod({required this.lable, required this.month});

  final String? lable;
  final int? month;

  Map<String, dynamic> toJson() => {"lable": lable, "month": month};
}

class Contact {
  Contact({
    required this.phone,
    required this.phonePrivate,
    required this.amenities,
    required this.preferences,
  });

  final String? phone;
  final bool? phonePrivate;
  final List<String> amenities;
  final List<String> preferences;

  Map<String, dynamic> toJson() => {
    "phone": phone,
    "phonePrivate": phonePrivate,
    "amenities": amenities.map((x) => x).toList(),
    "preferences": preferences.map((x) => x).toList(),
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
