import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:token_app/resources/app_colors.dart';
import 'package:token_app/utils/text_style.dart';
import 'package:token_app/viewModel/afterLogin/account_pages_provider/account_pages_provider.dart';

class OfflineNotification extends StatelessWidget {
  const OfflineNotification({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Offline Notification",
          style: textStyle17(FontWeight.w900),
        ),
      ),
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                border: Border.all(width: 1, color: AppColors.grey.shade300),
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                leading: Icon(
                  Icons.notifications_active_outlined,
                  color: AppColors.mainColors,
                ),
                title: Text(
                  "Push Notification",
                  style: textStyle15(FontWeight.w600),
                ),
                subtitle: Text(
                  "Enable the Push Notification",
                  style: textStyle13(FontWeight.w500, color: AppColors.grey),
                ),
                trailing: Selector<NotificationProvider, bool>(
                  selector: (_, p) => p.isEnable,
                  builder: (context, value, child) {
                    return Switch(
                      value: value,
                      onChanged: (v) {
                        context.read<NotificationProvider>().toggle(v);
                      },
                      activeThumbColor: AppColors.white,
                      activeTrackColor: AppColors.green,
                      inactiveThumbColor: AppColors.white,
                      inactiveTrackColor: AppColors.grey.shade400,
                    );
                  },
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.error_outline, color: AppColors.grey),
                  SizedBox(width: 5),
                  Expanded(
                    child: Text(
                      'Enable push notifications to stay updated with important alerts and updates.',
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
