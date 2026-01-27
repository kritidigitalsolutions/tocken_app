class OnBoardingResModel {
  final bool? success;
  final List<Wallpapers>? wall;

  OnBoardingResModel({required this.success, required this.wall});

  factory OnBoardingResModel.fromJson(Map<String, dynamic> j) {
    return OnBoardingResModel(
      success: j["success"],
      wall: j['wallpapers'] == null
          ? []
          : (j["wallpapers"] as List)
                .map((json) => Wallpapers.fromJson(json))
                .toList(),
    );
  }
}

class Wallpapers {
  final String? title;
  final String? des;
  final String? image;

  Wallpapers({required this.des, required this.image, required this.title});

  factory Wallpapers.fromJson(Map<String, dynamic> j) {
    return Wallpapers(
      des: j["description"],
      image: j["image"],
      title: j["title"],
    );
  }
}

// Register page

class UserResModel {
  UserResModel({
    required this.success,
    required this.isNewUser,
    required this.message,
    required this.token,
    required this.user,
  });

  final bool? success;
  final bool? isNewUser;
  final String? message;
  final String? token;
  final User? user;

  factory UserResModel.fromJson(Map<String, dynamic> json) {
    return UserResModel(
      success: json["success"],
      isNewUser: json["isNewUser"],
      message: json["message"],
      token: json["token"],
      user: json["user"] == null ? null : User.fromJson(json["user"]),
    );
  }
}

class User {
  User({
    required this.id,
    required this.name,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.userType,
    required this.email,
    required this.phone,
    required this.profileImage,
    required this.gstNumber,
  });

  final String? id;
  final String? name;
  final String? username;
  final String? userType;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phone;
  final String? profileImage;
  final String? gstNumber;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["_id"],
      name: json["name"],
      username: json["username"],
      firstName: json["firstName"],
      lastName: json["lastName"],
      email: json["email"],
      phone: json["phone"],
      profileImage: json["profileImage"],
      userType: json["userType"],
      gstNumber: json["gstNumber"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "name": name,
      "firstName": firstName,
      "username": username,
      "lastName": lastName,
      "email": email,
      "phone": phone,
      "profileImage": profileImage,
      "userType": userType,
      "gstNumber": gstNumber,
    };
  }
}
