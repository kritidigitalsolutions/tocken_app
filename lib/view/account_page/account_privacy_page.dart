import 'package:flutter/material.dart';
import 'package:token_app/resources/app_colors.dart';
import 'package:token_app/utils/buttons.dart';
import 'package:token_app/utils/text_style.dart';
import 'package:token_app/view/account_page/delete_account_page.dart';

class AccountPrivacyPage extends StatelessWidget {
  const AccountPrivacyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Account Privacy", style: textStyle17(FontWeight.w700)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.grey.shade300),
              ),
              child: ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => DeleteAccountPage()),
                  );
                },
                leading: CircleAvatar(
                  backgroundColor: AppColors.red.shade100,
                  child: Icon(
                    Icons.delete_outline,
                    color: AppColors.mainColors,
                  ),
                ),
                title: Text(
                  "Delete your account",
                  style: textStyle15(FontWeight.w600),
                ),
                subtitle: Text(
                  "Request for Permanent Account Deletion",
                  style: textStyle13(FontWeight.w500, color: AppColors.grey),
                ),
                trailing: iconButton(
                  onTap: () {},
                  icons: Icons.arrow_forward_ios,
                ),
              ),
            ),

            const SizedBox(height: 12),

            /// Info text
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.info_outline, size: 18, color: AppColors.grey),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      "Deleting your account will permanently erase all your data."
                      "This action cannot be undone",
                      style: textStyle13(
                        FontWeight.w500,
                        color: AppColors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SmallSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const SmallSwitch({super.key, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 0.8, // 🔽 Reduce size
      child: Switch(
        value: value,
        onChanged: onChanged,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        activeThumbColor: Colors.white,
        activeTrackColor: AppColors.green,
        inactiveThumbColor: Colors.white,
        inactiveTrackColor: AppColors.grey.shade400,
      ),
    );
  }
}
