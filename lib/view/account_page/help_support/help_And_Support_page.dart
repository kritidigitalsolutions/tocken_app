import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:token_app/resources/app_colors.dart';
import 'package:token_app/utils/text_style.dart';
import 'package:token_app/view/account_page/help_support/about_us.page.dart';
import 'package:token_app/view/account_page/help_support/policy_page.dart';
import 'package:token_app/viewModel/policy_view_model/policy_provider.dart';

class HelpAndSupportPage extends StatelessWidget {
  const HelpAndSupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<PolicyProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Help", style: textStyle17(FontWeight.w900)),
        centerTitle: true,
      ),
      backgroundColor: AppColors.background,
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _helpTile(
            context,
            title: "About Us",
            icon: Icons.info_outline,
            onTap: () {
              provider.fetchAboutUs();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => AboutUsPage()),
              );
            },
          ),
          _helpTile(
            context,
            title: "Terms & Conditions",
            icon: Icons.description_outlined,
            onTap: () {
              provider.fetchPolicy("terms");
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      PolicyPage(title: "Terms & Conditions", type: "terms"),
                ),
              );
            },
          ),
          _helpTile(
            context,

            title: "Privacy Policy",
            icon: Icons.privacy_tip_outlined,
            onTap: () {
              provider.fetchPolicy("privacy");
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      PolicyPage(title: "Privacy Policy", type: "privacy"),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _helpTile(
    BuildContext context, {
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(width: 1, color: AppColors.grey.shade300),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}
