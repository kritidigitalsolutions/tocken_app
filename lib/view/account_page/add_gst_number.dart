import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:token_app/resources/app_colors.dart';
import 'package:token_app/utils/buttons.dart';
import 'package:token_app/utils/text_style.dart';
import 'package:token_app/utils/textfield.dart';
import 'package:token_app/viewModel/afterLogin/account_pages_provider/account_pages_provider.dart';

class AddGstNumber extends StatelessWidget {
  AddGstNumber({super.key});

  final TextEditingController ctr = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = context.read<ProfileEditProvider>();
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Personal Settings', style: textStyle17(FontWeight.w900)),
        backgroundColor: AppColors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: _inputItem(
                    "First Name",
                    provider.firstNameController,
                    "First Name",
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: _inputItem(
                    "Last Name",
                    provider.lastNameController,
                    "First Name",
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            _inputItem("Username", ctr, "Username", readOnly: true),
            SizedBox(height: 15),
            Text("Phone Number", style: textStyle15(FontWeight.w900)),
            SizedBox(height: 10),
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
                  Text("(+91) ${provider.phone}"),
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
            SizedBox(height: 15),
            _inputItem("Email", ctr, "email"),
            SizedBox(height: 15),
            _inputItem("GST Number", ctr, "GST Number"),
            // SizedBox(height: 15),

            // Text("Role", style: textStyle15(FontWeight.w900)),
            // Container(
            //   width: double.infinity,
            //   padding: const EdgeInsets.all(14),
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(12),
            //     color: AppColors.grey.shade300,
            //     border: Border.all(color: AppColors.grey.shade400),
            //   ),
            //   child: Text(provider.role),
            // ),
            SizedBox(height: 20),
            Consumer<ProfileEditProvider>(
              builder: (context, p, child) {
                return AppButton(
                  isLoading: p.isLoading,
                  text: "Save",
                  onTap: () {
                    p.editProfile(context);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _inputItem(
    String title,
    TextEditingController controller,
    String hint, {
    bool readOnly = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: textStyle15(FontWeight.w900)),
        SizedBox(height: 8),
        AppTextField(
          controller: controller,
          hintText: hint,
          readOnly: readOnly,
          fillColor: readOnly ? AppColors.white70 : AppColors.white,
          filled: true,
        ),
      ],
    );
  }
}
