class LocationModel {
  LocationModel({
    required this.success,
    required this.count,
    required this.data,
  });

  final bool? success;
  final int? count;
  final List<LocationItem> data;

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      success: json["success"],
      count: json["count"],
      data: json["data"] == null
          ? []
          : List<LocationItem>.from(
              json["data"]!.map((x) => LocationItem.fromJson(x)),
            ),
    );
  }
}

class LocationItem {
  LocationItem({
    required this.displayName,
    required this.city,
    required this.locality,
    required this.state,
    required this.country,
    required this.pincode,
  });

  final String? displayName;
  final String? city;
  final String? locality;
  final String? state;
  final String? country;
  final String? pincode;

  factory LocationItem.fromJson(Map<String, dynamic> json) {
    return LocationItem(
      displayName: json["displayName"],
      city: json["city"],
      locality: json["locality"],
      state: json["state"],
      country: json["country"],
      pincode: json["pincode"],
    );
  }
}
