import 'package:flutter/material.dart';
import 'package:token_app/resources/app_colors.dart';
import 'package:token_app/utils/text_style.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Privacy Policy", style: textStyle17(FontWeight.w900)),
        centerTitle: true,
      ),
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            _SectionTitle("Introduction"),
            _SectionText(
              "This Privacy Policy explains how we collect, use, and protect "
              "your personal information when you use our application. "
              "By using this app, you agree to the practices described here.",
            ),

            SizedBox(height: 16),

            _SectionTitle("Information We Collect"),
            _SectionText(
              "We may collect the following information:\n"
              "• Personal details such as name, phone number, and email\n"
              "• Account and profile information\n"
              "• Usage data to improve app performance",
            ),

            SizedBox(height: 16),

            _SectionTitle("How We Use Your Information"),
            _SectionText(
              "Your information is used to:\n"
              "• Provide and improve our services\n"
              "• Verify user identity\n"
              "• Communicate important updates\n"
              "• Ensure platform security",
            ),

            SizedBox(height: 16),

            _SectionTitle("Data Security"),
            _SectionText(
              "We implement appropriate security measures to protect your "
              "personal data from unauthorized access, alteration, or disclosure. "
              "However, no method of transmission over the internet is 100% secure.",
            ),

            SizedBox(height: 16),

            _SectionTitle("Data Sharing"),
            _SectionText(
              "We do not sell, trade, or rent users' personal information. "
              "Data may be shared only when required by law or to provide "
              "essential services related to app functionality.",
            ),

            SizedBox(height: 16),

            _SectionTitle("Cookies & Tracking"),
            _SectionText(
              "Our app may use cookies or similar technologies to enhance "
              "user experience, analyze trends, and improve overall service quality.",
            ),

            SizedBox(height: 16),

            _SectionTitle("User Rights"),
            _SectionText(
              "Users have the right to access, update, or delete their personal "
              "information. Requests can be made through the app support section.",
            ),

            SizedBox(height: 16),

            _SectionTitle("Policy Updates"),
            _SectionText(
              "We may update this Privacy Policy from time to time. Continued "
              "use of the app after updates implies acceptance of the revised policy.",
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
