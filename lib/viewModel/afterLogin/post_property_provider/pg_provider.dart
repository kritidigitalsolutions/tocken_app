import 'package:flutter/material.dart';

class PgDetailsProvider extends ChangeNotifier {
  // Controllers
  final pgNameController = TextEditingController();
  final floorsController = TextEditingController();
  final privateRoomsController = TextEditingController();
  final dataCtr = TextEditingController();

  // Selections
  String? pgFor;
  String? bestSuitedFor;
  String? managerStay;
  String roomSharing = "Private";

  bool attachedBathroom = false;
  bool attachedBalcony = false;

  String? furnishType;
  String? propertyManagedBy;

  int coveredParking = 0;
  int openParking = 0;

  // Select methods
  void selectPgFor(String value) {
    pgFor = value;
    notifyListeners();
  }

  void selectManagerStay(String value) {
    managerStay = value;
    notifyListeners();
  }

  void selectBestSuited(String value) {
    bestSuitedFor = value;
    notifyListeners();
  }

  void selectRoomSharing(String value) {
    roomSharing = value;
    notifyListeners();
  }

  void toggleBathroom() {
    attachedBathroom = !attachedBathroom;
    notifyListeners();
  }

  void toggleBalcony() {
    attachedBalcony = !attachedBalcony;
    notifyListeners();
  }

  void setFurnishType(String value) {
    furnishType = value;
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

  bool get isFormValid =>
      pgNameController.text.isNotEmpty &&
      pgFor != null &&
      bestSuitedFor != null &&
      floorsController.text.isNotEmpty &&
      furnishType != null;

  @override
  void dispose() {
    pgNameController.dispose();
    floorsController.dispose();
    privateRoomsController.dispose();
    super.dispose();
  }
}
