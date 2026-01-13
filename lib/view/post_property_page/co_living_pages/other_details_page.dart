import 'package:flutter/material.dart';
import 'package:token_app/resources/app_colors.dart';
import 'package:token_app/utils/buttons.dart';
import 'package:token_app/utils/text_style.dart';
import 'package:token_app/utils/textfield.dart';

class OtherDetailsPage extends StatelessWidget {
  OtherDetailsPage({super.key});

  TextEditingController ctr = TextEditingController();

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
              "About yourself",
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Add About Yourself", style: textStyle15(FontWeight.bold)),
              SizedBox(height: 10),
              AppTextField(
                maxLines: 3,
                controller: ctr,
                hintText: "Add about yourself",
              ),

              SizedBox(height: 20),

              Text(
                "Here are some useful things to inclde in About yourself",
                style: textStyle15(FontWeight.bold),
              ),
              SizedBox(height: 10),

              Text(
                "- Share a bit about your hoppies, social activities, and professional interests",
                style: textStyle14(FontWeight.w500, color: AppColors.grey),
              ),
              SizedBox(height: 20),

              Text("Insta Handle", style: textStyle15(FontWeight.bold)),
              SizedBox(height: 10),
              AppTextField(controller: ctr, hintText: "Instagram link"),

              SizedBox(height: 20),

              Text("FB Link", style: textStyle15(FontWeight.bold)),
              SizedBox(height: 10),
              AppTextField(controller: ctr, hintText: "Facebook Link"),

              SizedBox(height: 20),

              Text("Linkedin", style: textStyle15(FontWeight.bold)),
              SizedBox(height: 10),
              AppTextField(controller: ctr, hintText: "Likedin Link"),

              SizedBox(height: 20),
              AppButton(
                text: "Complete & Posting",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => OtherDetailsPage()),
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
      ),
    );
  }
}
