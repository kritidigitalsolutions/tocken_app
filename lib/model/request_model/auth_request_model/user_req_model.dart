class UserReqModel {
  UserReqModel({
    required this.userType,
    required this.firstName,
    required this.lastName,
    this.email,
    required this.phone,
    required this.profileImage,
  });
  final String userType;
  final String firstName;
  final String lastName;
  final String? email;
  final String? phone;
  final String? profileImage;

  Map<String, dynamic> toJson() {
    return {
      "userType": userType,
      "firstName": firstName,
      "lastName": lastName,
      if (email != null && email!.isNotEmpty) "email": email,
      "phone": phone,
      "profileImage": profileImage,
    };
  }
}
