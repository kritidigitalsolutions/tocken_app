import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:token_app/resources/app_colors.dart';
import 'package:token_app/utils/buttons.dart';
import 'package:token_app/utils/text_style.dart';
import 'package:token_app/viewModel/afterLogin/account_pages_provider/account_pages_provider.dart';

class DeleteAccountPage extends StatelessWidget {
  const DeleteAccountPage({super.key});

  static const List<String> reasons = [
    "I don’t want to use Hexahome any more",
    "I’m using a different account",
    "I rented/sold my property",
    "I’m worried about my privacy",
    "This app is not working properly",
    "My reason is not listed above",
  ];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DeleteAccountProvider(),
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors.white,
          foregroundColor: AppColors.black,
          title: Text("Delete account", style: textStyle17(FontWeight.bold)),
        ),

        body: Consumer<DeleteAccountProvider>(
          builder: (context, provider, _) {
            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Delete my account",
                          style: textStyle16(FontWeight.w600),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Why would you like to delete your account?",
                          style: textStyle14(
                            FontWeight.w500,
                            color: AppColors.grey,
                          ),
                        ),

                        const SizedBox(height: 16),

                        /// REASONS
                        RadioGroup<String>(
                          groupValue: provider.selectedReason,
                          onChanged: (value) {
                            if (value != null) {
                              provider.selectReason(value);
                            }
                          },
                          child: Column(
                            children: reasons.map((e) {
                              return RadioListTile<String>(
                                value: e,
                                title: Text(
                                  e,
                                  style: textStyle14(FontWeight.w500),
                                ),
                                contentPadding: EdgeInsets.zero,
                                activeColor: AppColors.mainColors,
                              );
                            }).toList(),
                          ),
                        ),

                        const SizedBox(height: 20),

                        /// FEEDBACK
                        Text(
                          "Help us to improve *",
                          style: textStyle15(FontWeight.w600),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: provider.feedbackController,
                          maxLines: 4,
                          decoration: InputDecoration(
                            hintText:
                                "Share a short note about why you’re leaving...",
                            hintStyle: textStyle14(
                              FontWeight.w400,
                              color: AppColors.grey,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: AppColors.mainColors,
                              ),
                            ),
                          ),

                          onChanged: (_) => provider.notifyListeners(),
                        ),
                      ],
                    ),
                  ),
                ),

                /// DELETE BUTTON
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: AppButton(text: 'Delete', onTap: () {}),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
