import 'package:flutter/material.dart';
import 'package:token_app/resources/app_colors.dart';
import 'package:token_app/utils/buttons.dart';
import 'package:token_app/utils/text_style.dart';
import 'package:token_app/view/post_property_page/co_living_pages/sharing_pre_page.dart';

class PricingDetailsPage extends StatelessWidget {
  const PricingDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        leading: const BackButton(),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Pricing Details",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            Text(
              "Co-living > Need Room/Flat",
              style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: TextAppButton(text: "Help", onTap: () {}),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Budget", style: textStyle15(FontWeight.bold)),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(child: budgetBox("1K", () {})),
                SizedBox(width: 10),
                Expanded(child: budgetBox("50K+", () {})),
              ],
            ),
            Spacer(),
            SizedBox(height: 20),
            AppButton(
              text: "Save & Next",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => SharingPreferencePage()),
                );
              },
            ),
            SizedBox(height: 15),
            AppButton(
              text: "Cancel",
              onTap: () {},
              backgroundColor: AppColors.red.shade100,
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

Widget budgetBox(String value, VoidCallback onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: AppColors.grey.shade300),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Row(
          children: [
            Text(value),
            Spacer(),
            Icon(Icons.keyboard_arrow_down_outlined),
          ],
        ),
      ),
    ),
  );
}
