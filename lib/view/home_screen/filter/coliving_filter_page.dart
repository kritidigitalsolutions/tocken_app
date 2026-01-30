import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:token_app/resources/app_colors.dart';
import 'package:token_app/utils/buttons.dart';
import 'package:token_app/utils/text_style.dart';
import 'package:token_app/view/home_screen/filter/rent_fliter_page.dart';
import 'package:token_app/view/home_screen/location_screen.dart';
import 'package:token_app/viewModel/afterLogin/filter_pages_provider/filter_provider.dart';

class ColivingFilterPage extends StatelessWidget {
  final String? city;
  const ColivingFilterPage({super.key, this.city});

  @override
  Widget build(BuildContext context) {
    return Consumer<FilterProvider>(
      builder: (context, provider, child) {
        return Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SingleChildScrollView(
                    padding: EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Search By City, Locality *",
                          style: textStyle15(FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => LocationScreen(),
                              ),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 10,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: AppColors.grey.shade300,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.search, color: AppColors.grey),
                                      SizedBox(width: 5),
                                      Text(
                                        provider.city.isEmpty
                                            ? 'Search city/Locality/Landmarks...'
                                            : provider.city,
                                      ),
                                    ],
                                  ),
                                  Icon(Icons.location_on_outlined),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
                        Text(
                          "Looking for",
                          style: textStyle15(FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            _selectButton(
                              "Room/Flat",
                              () => provider.toggleLookFor("Room/Flat"),
                              provider.lookFor,
                            ),
                            SizedBox(width: 10),
                            _selectButton(
                              "Roommate",
                              () => provider.toggleLookFor("Roommate"),
                              provider.lookFor,
                            ),
                          ],
                        ),
                        SizedBox(height: 15),

                        // Gender
                        Text(
                          "Preferred Gender",
                          style: textStyle15(FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: provider.preGender.map((e) {
                            return _chipWrap(e, provider);
                          }).toList(),
                        ),

                        // Room for
                        SizedBox(height: 15),
                        Text(
                          "Preferring Rooms for",
                          style: textStyle15(FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: provider.roomFor.map((e) {
                            return filterChip(
                              text: e,
                              isSelected: provider.selectedRoomFor.contains(e),
                              onTap: () {
                                provider.toggleRoomFor(e);
                              },
                            );
                          }).toList(),
                        ),

                        SizedBox(height: 15),
                        Text("Budget", style: textStyle15(FontWeight.bold)),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(child: budgetBox("1K", () {})),
                            SizedBox(width: 10),
                            Expanded(child: budgetBox("1K", () {})),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(color: AppColors.white),
                child: Row(
                  children: [
                    Expanded(
                      child: AppButton(
                        text: "Clear All",
                        onTap: () {},
                        backgroundColor: AppColors.mainColors.withAlpha(20),

                        textColor: AppColors.black,
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: AppButton(text: "Submit", onTap: () {}),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _selectButton(String text, VoidCallback onTap, String type) {
    final isSelected = text == type;
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: isSelected ? AppColors.mainColors : Colors.grey.shade300,
            ),
            color: Colors.transparent,
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: isSelected ? AppColors.mainColors : Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _chipWrap(String type, FilterProvider provider) {
    final isSelector = type == provider.gender;
    return GestureDetector(
      onTap: () {
        provider.toggleGender(type);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: isSelector ? AppColors.mainColors : Colors.grey.shade300,
          ),
          color: AppColors.white,
        ),
        child: Text(
          type,
          style: TextStyle(
            color: isSelector ? AppColors.mainColors : Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
