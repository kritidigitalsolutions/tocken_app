import 'package:flutter/material.dart';
import 'package:token_app/resources/app_colors.dart';
import 'package:token_app/utils/text_style.dart';

class TermsAndConditionsPage extends StatelessWidget {
  const TermsAndConditionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Terms & Conditions", style: textStyle17(FontWeight.w900)),
        centerTitle: true,
      ),
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            _SectionTitle("1. Introduction"),
            _SectionText(
              "Welcome to our application. These Terms and Conditions "
              "govern your use of our app and services. By accessing or "
              "using the app, you agree to be bound by these terms.",
            ),

            SizedBox(height: 16),

            _SectionTitle("2. User Eligibility"),
            _SectionText(
              "You must be at least 18 years old to use this application. "
              "By using this app, you confirm that the information you "
              "provide is accurate and complete.",
            ),

            SizedBox(height: 16),

            _SectionTitle("3. User Responsibilities"),
            _SectionText(
              "• You agree not to misuse the application.\n"
              "• You must not upload false or misleading information.\n"
              "• You are responsible for maintaining account security.",
            ),

            SizedBox(height: 16),

            _SectionTitle("4. Privacy & Data"),
            _SectionText(
              "We respect your privacy. Personal data provided by users "
              "is stored securely and used only to improve services. "
              "We do not sell or share personal data with third parties.",
            ),

            SizedBox(height: 16),

            _SectionTitle("5. Intellectual Property"),
            _SectionText(
              "All content, logos, and materials in this app are the "
              "property of the company. Unauthorized use or duplication "
              "is strictly prohibited.",
            ),

            SizedBox(height: 16),

            _SectionTitle("6. Limitation of Liability"),
            _SectionText(
              "We are not responsible for any direct or indirect damages "
              "resulting from the use or inability to use the application.",
            ),

            SizedBox(height: 16),

            _SectionTitle("7. Termination"),
            _SectionText(
              "We reserve the right to suspend or terminate accounts that "
              "violate these Terms & Conditions without prior notice.",
            ),

            SizedBox(height: 16),

            _SectionTitle("8. Changes to Terms"),
            _SectionText(
              "These terms may be updated from time to time. Continued use "
              "of the app after changes implies acceptance of the updated terms.",
            ),

            SizedBox(height: 24),

            Center(
              child: Text(
                "Last updated: January 2026",
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
    );
  }
}

class _SectionText extends StatelessWidget {
  final String text;
  const _SectionText(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontSize: 14, height: 1.6, color: Colors.black87),
    );
  }
}
