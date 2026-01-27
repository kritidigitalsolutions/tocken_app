import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:token_app/resources/app_colors.dart';
import 'package:token_app/utils/buttons.dart';
import 'package:token_app/utils/text_style.dart';
import 'package:token_app/utils/textfield.dart';
import 'package:token_app/viewModel/beforeLogin/auth_provider.dart';

class UserDetails extends StatelessWidget {
  final String phone;
  const UserDetails({super.key, required this.phone});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserDetailsProvider>(context);

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                style: textStyle17(FontWeight.w900),
                children: [
                  TextSpan(text: "Fill your "),
                  TextSpan(
                    text: "information",
                    style: TextStyle(color: AppColors.mainColors),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 6),
            Text(
              "Please set-up your profile here",
              style: textStyle14(FontWeight.w500, color: AppColors.grey),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// PROFILE IMAGE
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 55,
                    backgroundColor: AppColors.grey.shade300,
                    backgroundImage: provider.profileImage != null
                        ? FileImage(provider.profileImage!)
                        : null,
                    child: provider.profileImage == null
                        ? const Icon(
                            Icons.person,
                            size: 50,
                            color: AppColors.white,
                          )
                        : null,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: provider.pickImage,
                      child: CircleAvatar(
                        radius: 18,
                        backgroundColor: AppColors.mainColors,
                        child: const Icon(
                          Icons.edit,
                          size: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            /// ROLE
            const Text(
              "Select your Role *",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),

            Wrap(
              children: ["Individual", "Agent", "Builder"]
                  .map(
                    (role) => GestureDetector(
                      onTap: () => provider.selectRole(role),
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 15,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: provider.selectedRole == role
                                ? AppColors.mainColors
                                : AppColors.grey.shade400,
                          ),
                        ),
                        child: Text(
                          role,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: provider.selectedRole == role
                                ? AppColors.mainColors
                                : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),

            const SizedBox(height: 24),

            /// FIRST & LAST NAME
            Row(
              children: [
                Expanded(
                  child: _input(
                    "First Name *",
                    provider.firstNameController,
                    "First name",
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _input(
                    "Last Name *",
                    provider.lastNameController,
                    "Last name",
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            /// EMAIL
            _input("Email ID", provider.emailController, "Email ID (Optional)"),

            const SizedBox(height: 20),

            /// PHONE NUMBER
            const Text(
              "Phone Number *",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),

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
                  Text("(+91) $phone"),
                  const Spacer(),
                  Row(
                    children: [
                      const Text(
                        "Verified",
                        style: TextStyle(color: Colors.green),
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

            /// BUTTON
            ///
            Consumer<UserDetailsProvider>(
              builder: (context, provider, child) {
                return AppButton(
                  text: "Confirm details",
                  isLoading: provider.isLoading,
                  onTap: provider.isValid && !provider.isLoading
                      ? () {
                          provider.registerUser(context, phone);
                        }
                      : null,
                );
              },
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _input(String label, TextEditingController controller, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        AppTextField(
          controller: controller,
          hintText: hint,
          borderColor: AppColors.grey.shade400,
        ),
      ],
    );
  }
}
