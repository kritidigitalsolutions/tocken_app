import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:token_app/resources/app_colors.dart';
import 'package:token_app/utils/text_style.dart';
import 'package:token_app/viewModel/afterLogin/home_screen_provider.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final ctr = Provider.of<HomeScreenProvicer>(context);

    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      color: AppColors.white,
      notchMargin: 6,
      shadowColor: AppColors.black,
      height: 64,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildTabIcon(
              context,
              icon: Icons.home,
              index: 0,
              isSelected: ctr.pageIndex == 0,
              title: "Home",
            ),
            _buildTabIcon(
              context,
              icon: Icons.chat_bubble_outline,
              index: 1,
              isSelected: ctr.pageIndex == 1,
              title: "Leads",
            ),
            SizedBox(width: 40),

            // Right buttons
            _buildTabIcon(
              context,
              icon: Icons.description,
              index: 2,
              isSelected: ctr.pageIndex == 2,
              title: "Plans",
            ),
            _buildTabIcon(
              context,
              icon: Icons.person,
              index: 3,
              isSelected: ctr.pageIndex == 3,
              title: "Account",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabIcon(
    BuildContext context, {
    required IconData icon,
    required int index,
    required bool isSelected,
    required String title,
  }) {
    final ctr = Provider.of<HomeScreenProvicer>(context, listen: false);

    return SizedBox(
      child: GestureDetector(
        onTap: () => ctr.toggelPage(index),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 18,
              color: isSelected ? AppColors.mainColors : Colors.grey,
            ),

            Text(
              title,
              style: textStyle12(
                FontWeight.w600,
                color: isSelected ? AppColors.mainColors : Colors.grey,
              ).copyWith(height: 1.0),
            ),
          ],
        ),
      ),
    );
  }
}
