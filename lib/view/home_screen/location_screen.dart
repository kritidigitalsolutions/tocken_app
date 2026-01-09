import 'package:flutter/material.dart';
import 'package:token_app/resources/app_colors.dart';
import 'package:token_app/utils/helper/helper_method.dart';
import 'package:token_app/utils/text_style.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.close,
            fontWeight: FontWeight.w900,

            size: 20,
            color: AppColors.black,
          ),
        ),
        title: Text(
          "Enter your city, area or locality address",
          style: textStyle15(FontWeight.w900),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 12),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: "Search by city, locality, area...",
                hintStyle: textStyle14(FontWeight.w500, color: AppColors.grey),
                prefixIcon: Icon(Icons.search),
                border: _inputDecoration(),
                focusedBorder: _inputDecoration(),
                enabledBorder: _inputDecoration(),
              ),
            ),
            SizedBox(height: 15),
            GestureDetector(
              onTap: () async {
                try {
                  final locationData = await getCurrentLocationAndAddress(
                    context,
                  );
                  print(locationData['address']);
                  print(locationData['city']);
                } catch (e) {
                  print(e);
                }
              },
              child: Row(
                children: [
                  Icon(Icons.location_on_outlined, color: AppColors.mainColors),
                  SizedBox(width: 8),
                  Text(
                    'Use my current location',
                    style: textStyle15(
                      FontWeight.bold,
                      color: AppColors.mainColors,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 5),
            Divider(color: AppColors.grey.shade300),
          ],
        ),
      ),
    );
  }

  OutlineInputBorder _inputDecoration() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide(width: 1, color: AppColors.grey.shade300),
    );
  }
}
