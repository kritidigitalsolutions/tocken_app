import 'package:flutter/material.dart';

class LeadsScreenController extends ChangeNotifier {
  final List<Map<String, dynamic>> leadsList = [
    {
      "name": "Priya Patel",
      "status": "New",
      "title": "2 BHK Modern Flat",
      "subtitle": "2 BHK Apartment",
      "location": "Hinjewadi, Pune",
      "price": "₹75.50L",
      "phone": "+91 97XXX XXX23",
      "source": "WhatsApp",
      "id": "LD12346",
      "imageUrl":
          "https://images.unsplash.com/photo-1568605114967-8130f3a36994",
    },
    {
      "name": "Rahul Verma",
      "status": "Contacted",
      "title": "4 BHK Luxury Villa",
      "subtitle": "4 BHK Apartment",
      "location": "Baner, Pune",
      "price": "₹1.2Cr",
      "phone": "+91 99XXX XXX67",
      "source": "Call",
      "id": "LD12347",
      "imageUrl":
          "https://images.unsplash.com/photo-1600585154340-be6161a56a0c",
    },
    {
      "name": "Rahul Verma",
      "status": "Contacted",
      "title": "4 BHK Luxury Villa",
      "subtitle": "4 BHK Apartment",
      "location": "Baner, Pune",
      "price": "₹1.2Cr",
      "phone": "+91 99XXX XXX67",
      "source": "Call",
      "id": "LD12348",
      "imageUrl":
          "https://images.unsplash.com/photo-1600585154340-be6161a56a0c",
    },
    {
      "name": "Amit Verma",
      "status": "Closed",
      "title": "4 BHK Luxury Villa",
      "subtitle": "4 BHK Apartment",
      "location": "Baner, Pune",
      "price": "₹1.2Cr",
      "phone": "+91 99XXX XXX67",
      "source": "Call",
      "id": "LD12349",
      "imageUrl":
          "https://images.unsplash.com/photo-1600585154340-be6161a56a0c",
    },
  ];

  final List<String> statusList = ["All Leads", "New", "Contacted", "Closed"];

  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  void onStatusSelected(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  List<Map<String, dynamic>> get filteredLeads {
    if (_selectedIndex == 0) return leadsList;
    return leadsList
        .where((e) => e["status"] == statusList[_selectedIndex])
        .toList();
  }

  /// ✅ COUNT PER STATUS
  int getStatusCount(String status) {
    if (status == "All Leads") return leadsList.length;
    return leadsList.where((e) => e["status"] == status).length;
  }
}
