import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:token_app/resources/app_colors.dart';
import 'package:token_app/utils/buttons.dart';
import 'package:token_app/utils/text_style.dart';
import 'package:token_app/view/post_property_page/co_living_pages/other_details_page.dart';
import 'package:token_app/view/post_property_page/summary_page.dart';
import 'package:token_app/viewModel/afterLogin/post_property_provider/pg_provider.dart';

class PhotosPage extends StatefulWidget {
  final bool? isSharing;
  final String? propertyType;
  final String? type;
  final String? proClasses;
  const PhotosPage({
    super.key,
    this.isSharing = false,
    this.proClasses,
    this.propertyType,
    this.type,
  });

  @override
  State<PhotosPage> createState() => _PhotosPageState();
}

class _PhotosPageState extends State<PhotosPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        leading: const BackButton(),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Photo Upload", style: textStyle17(FontWeight.bold)),
            Text(
              " >  > ",
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
      body: Consumer<PgDetailsProvider>(
        builder: (context, p, child) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Add Images",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                const Text(
                  "Add images, should be less than 2 MB",
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 16),

                /// Upload box
                GestureDetector(
                  onTap: () => p.pickImages(context),
                  child: Container(
                    height: 140,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade400),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.image_outlined, size: 40),
                        SizedBox(height: 8),
                        Text(
                          "Upload your images here",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "Supports JPG, JPEG & PNG",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                /// Selected Images Grid
                if (p.images.isNotEmpty)
                  GridView.builder(
                    shrinkWrap: true,
                    itemCount: p.images.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                        ),
                    itemBuilder: (context, index) {
                      return Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.file(
                              File(p.images[index]),
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                            ),
                          ),

                          /// Remove button
                          Positioned(
                            top: 4,
                            right: 4,
                            child: GestureDetector(
                              onTap: () => p.removeImage(index),
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Colors.black54,
                                  shape: BoxShape.circle,
                                ),
                                padding: const EdgeInsets.all(4),
                                child: const Icon(
                                  Icons.close,
                                  size: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),

                const Spacer(),

                /// Save Button
                AppButton(
                  text: "Save & Next",
                  onTap: () {
                    // if (_images.isEmpty) {
                    //   ScaffoldMessenger.of(context).showSnackBar(
                    //     const SnackBar(
                    //       content: Text("Please add at least one image"),
                    //     ),
                    //   );
                    //   return;
                    // }

                    if (widget.isSharing ?? true) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => OtherDetailsPage()),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => SummaryPage(
                            propertyType: widget.propertyType,
                            type: widget.type,
                            proClasses: widget.proClasses,
                          ),
                        ),
                      );
                    }
                  },
                ),

                const SizedBox(height: 15),

                AppButton(
                  text: "Cancel",
                  onTap: () => Navigator.pop(context),
                  textColor: AppColors.black,
                  backgroundColor: AppColors.red.shade100,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
