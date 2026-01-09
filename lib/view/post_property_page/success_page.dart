import 'package:flutter/material.dart';
import 'package:token_app/main.dart';
import 'package:token_app/resources/app_colors.dart';
import 'package:token_app/utils/buttons.dart';
import 'package:token_app/utils/text_style.dart';

class SuccessPage extends StatelessWidget {
  const SuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Success", style: textStyle17(FontWeight.bold)),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        decoration: BoxDecoration(color: AppColors.background),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.check_circle_outline,
                color: AppColors.green,
                size: 35,
              ),
              SizedBox(height: 16),
              Text(
                "Property Posted Successfully!",
                style: textStyle18(FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                "Your property has been posted successfully and is now live on TOCKEN",
                textAlign: TextAlign.center,
                style: textStyle15(FontWeight.bold, color: AppColors.grey),
              ),
              SizedBox(height: 16),
              AppButton(
                text: 'View Lead',
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (_) => MyHomePage(screenIndex: 1),
                    ),
                    (route) => route.isFirst,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
