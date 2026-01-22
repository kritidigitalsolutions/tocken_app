class ProfileDetailsModel {
  final String firstName;
  final String lastName;
  final String? email;
  final String? gstNumber;

  ProfileDetailsModel({
    required this.firstName,
    required this.lastName,
    this.email,
    this.gstNumber,
  });

  Map<String, dynamic> toJson() {
    final data = {"firstName": firstName, "lastName": lastName};

    if (email?.isNotEmpty == true) {
      data["email"] = email ?? '';
    }

    if (gstNumber?.isNotEmpty == true) {
      data["gstNumber"] = gstNumber ?? '';
    }

    return data;
  }
}
