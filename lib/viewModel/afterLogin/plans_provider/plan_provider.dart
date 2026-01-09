import 'package:flutter/material.dart';

class PlanDetailsProvider extends ChangeNotifier {
  List<String> featureOption = [
    'Secure payment gateway',
    "Cancel anytime, no questions",
    "GST invoice available",
  ];

  final List<UserRole> roles = [
    UserRole(title: "Agent", icon: "assets/plan_icon/sale.svg"),
    UserRole(title: "Seller", icon: "assets/plan_icon/buyer.svg"),
    UserRole(title: "Landlord", icon: "assets/plan_icon/search.svg"),
    UserRole(title: "PG Owner", icon: "assets/plan_icon/buyer.svg"),
    UserRole(title: "Buyer", icon: "assets/plan_icon/sale.svg"),
    UserRole(title: "Tenant", icon: "assets/plan_icon/search.svg"),
    UserRole(title: "Co-living", icon: "assets/plan_icon/buyer.svg"),
    UserRole(title: "PG Seeker", icon: "assets/plan_icon/sale.svg"),
  ];

  String? selectedRole;

  void selectRole(String role) {
    selectedRole = role;
    notifyListeners();
  }

  bool get isSelected => selectedRole != null;
}

class UserRole {
  final String title;
  final String icon;

  UserRole({required this.title, required this.icon});
}
