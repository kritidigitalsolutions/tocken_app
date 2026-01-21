import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:token_app/data/status.dart';
import 'package:token_app/resources/app_colors.dart';
import 'package:token_app/utils/buttons.dart';
import 'package:token_app/utils/text_style.dart';
import 'package:token_app/viewModel/policy_view_model/policy_provider.dart';

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
      body: Consumer<PolicyProvider>(
        builder: (context, provider, _) {
          final aboutUsStatus = provider.aboutUs.status;
          switch (aboutUsStatus) {
            case Status.loading:
              return Center(child: CircularProgressIndicator());
            case Status.error:
              final error = provider.aboutUs.message;
              return Center(
                child: errorMessage(error ?? "Failed to Fetch", () {
                  provider.fetchAboutUs();
                }),
              );
            case Status.completed:
              final data = provider.aboutUs.data?.aboutUs;
              return SingleChildScrollView(
                padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(data?.content ?? 'N/A'),
                    SizedBox(height: 10),
                    Text(data?.mission ?? 'N/A'),
                    SizedBox(height: 10),
                    Text(data?.vision ?? 'N/A'),
                  ],
                ),
              );
          }
        },
      ),
    );
  }

  Widget errorMessage(String text, VoidCallback onTap) {
    return Column(
      children: [
        Text(text, style: textStyle15(FontWeight.w600)),
        SizedBox(height: 12),
        OutlinedButton(
          onPressed: onTap,
          child: Text("Retry", style: textStyle15(FontWeight.w500)),
        ),
      ],
    );
  }
}
