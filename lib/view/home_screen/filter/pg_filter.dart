import 'package:flutter/material.dart';
import 'package:token_app/resources/app_colors.dart';
import 'package:token_app/utils/buttons.dart';
import 'package:token_app/utils/text_style.dart';
import 'package:token_app/view/home_screen/filter/rent_fliter_page.dart';
import 'package:token_app/view/home_screen/location_screen.dart';

class PgFilter extends StatelessWidget {
  PgFilter({super.key});

  List<String> preGender = ["Male", "Female", "All"];

  List<String> roomFor = ["Private", "Twin", "Triple", "Quard"];

  @override
  Widget build(BuildContext context) {
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
                          MaterialPageRoute(builder: (_) => LocationScreen()),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.search, color: AppColors.grey),
                                  SizedBox(width: 5),
                                  Text('Search city/Locality/Landmarks...'),
                                ],
                              ),
                              Icon(Icons.location_on_outlined),
                            ],
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 15),

                    // Gender
                    Text("PG'S For", style: textStyle15(FontWeight.bold)),
                    SizedBox(height: 10),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: preGender.map((e) {
                        return _chipWrap(e);
                      }).toList(),
                    ),

                    // Room for
                    SizedBox(height: 15),
                    Text(
                      "Rooms Sharing Type",
                      style: textStyle15(FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: roomFor.map((e) {
                        return _chipWrap(e);
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

                    SizedBox(height: 15),
                    Text(
                      "Rooms Sharing Type",
                      style: textStyle15(FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        _chipWrap("Immediatrly"),
                        _chipWrap("Within 15 days"),
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
  }

  Widget _chipWrap(String type) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.grey.shade300),
          color: AppColors.white,
        ),
        child: Text(
          type,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
