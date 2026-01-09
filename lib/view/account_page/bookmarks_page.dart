import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:token_app/resources/app_colors.dart';
import 'package:token_app/utils/text_style.dart';
import 'package:token_app/viewModel/afterLogin/account_pages_provider/account_pages_provider.dart';

class BookmarksPage extends StatelessWidget {
  const BookmarksPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<BookmarkProvider>();
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: Text("Bookmarks", style: textStyle17(FontWeight.w900)),
        centerTitle: true,
      ),
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.only(left: 12.0, top: 12),
              child: Row(
                children: provider.propertyType.map((type) {
                  return Selector<BookmarkProvider, String>(
                    selector: (_, p) => p.isSelected,
                    builder: (context, value, child) {
                      final isSelected = value == type;
                      return GestureDetector(
                        onTap: () {
                          provider.toggle(type);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 5,
                          ),
                          margin: EdgeInsets.only(right: 15),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.mainColors
                                : AppColors.white,
                            border: Border.all(
                              width: 1,
                              color: isSelected
                                  ? AppColors.mainColors
                                  : AppColors.grey.shade300,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text(
                              type,
                              style: textStyle14(
                                FontWeight.w500,
                                color: isSelected
                                    ? AppColors.white
                                    : AppColors.black,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Center(child: Image.asset("assets/bookmark.png"))],
            ),
          ),
        ],
      ),
    );
  }
}
