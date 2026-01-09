import 'package:flutter/material.dart';
import 'package:token_app/resources/app_colors.dart';
import 'package:token_app/utils/text_style.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About Us", style: textStyle17(FontWeight.w900)),
        centerTitle: true,
      ),
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            _SectionTitle("Who We Are"),
            _SectionText(
              "We are a technology-driven real estate platform designed "
              "to simplify the process of buying, selling, and renting "
              "properties. Our mission is to provide a seamless and "
              "transparent experience for all users.",
            ),

            SizedBox(height: 16),

            _SectionTitle("Our Mission"),
            _SectionText(
              "Our mission is to connect people with the right properties "
              "by leveraging modern technology, verified listings, and "
              "user-friendly tools that make property transactions easy "
              "and reliable.",
            ),

            SizedBox(height: 16),

            _SectionTitle("What We Offer"),
            _SectionText(
              "• Verified property listings\n"
              "• Easy search and filtering options\n"
              "• Secure user authentication\n"
              "• Personalized user experience\n"
              "• Dedicated customer support",
            ),

            SizedBox(height: 16),

            _SectionTitle("Why Choose Us"),
            _SectionText(
              "We focus on trust, transparency, and simplicity. Our platform "
              "is built to ensure users find accurate information and enjoy "
              "a smooth experience throughout their property journey.",
            ),

            SizedBox(height: 16),

            _SectionTitle("Our Vision"),
            _SectionText(
              "To become the most trusted digital platform for real estate "
              "services by continuously innovating and putting users first.",
            ),

            SizedBox(height: 24),

            Center(
              child: Text(
                "© 2026 Token App. All rights reserved.",
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
