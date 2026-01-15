import 'package:flutter/material.dart';

/// PROPERTY STATUS FILTER
enum ListingStatus { active, pending, expired, deleted, rejected, inactive }

/// SORT OPTIONS
enum SortType { newest, active, oldest, expired }

class MyListingProvider extends ChangeNotifier {
  /// MAIN CATEGORY TAB
  int mainTabIndex = 0;

  /// SUB CATEGORY (All / Rent / Lease / Sell)
  int subTabIndex = 0;

  /// FILTER STATUS
  final Set<ListingStatus> selectedStatus = {
    ListingStatus.active,
    ListingStatus.pending,
    ListingStatus.expired,
    ListingStatus.deleted,
    ListingStatus.rejected,
    ListingStatus.inactive,
  };

  /// SORT TYPE
  SortType sortType = SortType.newest;

  /// CHANGE MAIN TAB
  void changeMainTab(int index) {
    mainTabIndex = index;
    notifyListeners();
  }

  /// CHANGE SUB TAB
  void changeSubTab(int index) {
    subTabIndex = index;
    notifyListeners();
  }

  /// TOGGLE FILTER STATUS
  void toggleStatus(ListingStatus status) {
    if (selectedStatus.contains(status)) {
      selectedStatus.remove(status);
    } else {
      selectedStatus.add(status);
    }
    notifyListeners();
  }

  /// CHANGE SORT
  void changeSort(SortType type) {
    sortType = type;
    notifyListeners();
  }

  /// MOCK EMPTY STATE (replace with API response check)
  bool get isEmpty => true;
}
