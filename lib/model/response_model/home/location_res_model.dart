class LocationModel {
  final String name;
  final String city;
  final String country;

  LocationModel({
    required this.name,
    required this.city,
    required this.country,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      name: json['properties']['formatted'] ?? '',
      city: json['properties']['city'] ?? '',
      country: json['properties']['country'] ?? '',
    );
  }
}
