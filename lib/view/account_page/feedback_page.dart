import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:token_app/utils/buttons.dart';
import 'package:token_app/utils/text_style.dart';
import 'package:token_app/utils/textfield.dart';
import 'package:token_app/viewModel/afterLogin/account_pages_provider/account_pages_provider.dart';

import '../../resources/app_colors.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  @override
  Widget build(BuildContext context) {
    final provider = context.read<FeedbackProvider>();
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: Text("Feedback", style: textStyle17(FontWeight.w900)),
        centerTitle: true,
      ),
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Feedback Type
            const Text(
              "Feedback type *",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),

            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: provider.feedbackTypes.map((type) {
                return Selector<FeedbackProvider, String>(
                  selector: (_, p) => p.selectedType,
                  builder: (context, value, child) {
                    final isSelected = value == type;
                    return GestureDetector(
                      onTap: () {
                        provider.toggle(type);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: isSelected
                                ? AppColors.mainColors
                                : AppColors.grey.shade400,
                          ),
                          color: AppColors.white,
                        ),
                        child: Text(
                          type,
                          style: TextStyle(
                            color: isSelected
                                ? AppColors.mainColors
                                : AppColors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),

            const SizedBox(height: 20),

            /// Feedback Input
            Selector<FeedbackProvider, String>(
              selector: (_, p) => p.feedbackController.text.trim(),
              builder: (context, text, child) {
                return TextField(
                  controller: context
                      .read<FeedbackProvider>()
                      .feedbackController,
                  maxLines: 5,
                  maxLength: 200,

                  decoration: InputDecoration(
                    fillColor: AppColors.white,
                    filled: true,
                    hintText: "Write more about it",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    counterText: "${text.length}/200 characters",
                  ),
                );
              },
            ),
            const SizedBox(height: 20),

            /// Name
            const Text("Name", style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            AppTextField(
              controller: provider.nameController,
              hintText: "name",
              fillColor: AppColors.white,
              filled: true,
            ),

            const SizedBox(height: 20),

            /// Email
            const Text("Email", style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            AppTextField(
              controller: provider.emailController,
              hintText: "Email ID (Optional)",
              fillColor: AppColors.white,
              filled: true,
            ),

            const SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppColors.grey.shade300,
                border: Border.all(color: AppColors.grey.shade400),
              ),
              child: Row(
                children: [
                  Image.asset("assets/auth/india_flag.png", height: 20),
                  const SizedBox(width: 6),
                  Text("(+91) 9999999999"),
                  const Spacer(),
                  Row(
                    children: [
                      const Text(
                        "Verified",
                        style: TextStyle(color: AppColors.green),
                      ),
                      Icon(
                        Icons.check_circle,
                        color: AppColors.green,
                        size: 18,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            /// Submit Button
            AppButton(text: "Submit", onTap: () {}),
          ],
        ),
      ),
    );
  }
}
