import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:token_app/resources/app_colors.dart';
import 'package:token_app/utils/text_style.dart';
import 'package:token_app/viewModel/afterLogin/account_pages_provider/account_pages_provider.dart';

class PhonePrivacy extends StatelessWidget {
  const PhonePrivacy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Phone Number Privacy",
          style: textStyle17(FontWeight.w700),
        ),
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
                leading: CircleAvatar(
                  backgroundColor: AppColors.red.shade100,
                  child: Icon(Icons.call, color: AppColors.mainColors),
                ),
                title: Text(
                  "Keep my phone number private",
                  style: textStyle15(FontWeight.w600),
                ),
                subtitle: Text(
                  "Hide phone number from users",
                  style: textStyle13(FontWeight.w500, color: AppColors.grey),
                ),
                trailing: Selector<NotificationProvider, bool>(
                  selector: (_, p) => p.isEnable,
                  builder: (_, value, __) {
                    return SmallSwitch(
                      value: value,
                      onChanged: (v) {
                        context.read<NotificationProvider>().toggle(v);
                      },
                    );
                  },
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
                      "Turning on the switch keeps your number private, "
                      "though leads can reach you through Request Callback option.",
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
