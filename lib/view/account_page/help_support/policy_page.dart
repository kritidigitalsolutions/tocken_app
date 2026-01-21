import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:token_app/data/status.dart';
import 'package:token_app/resources/app_colors.dart';
import 'package:token_app/utils/error_custom_widget.dart';
import 'package:token_app/utils/text_style.dart';
import 'package:token_app/viewModel/policy_view_model/policy_provider.dart';

class PolicyPage extends StatelessWidget {
  final String title;
  final String type;
  const PolicyPage({super.key, required this.title, required this.type});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: textStyle17(FontWeight.w900)),
        centerTitle: true,
      ),
      backgroundColor: AppColors.background,
      body: Consumer<PolicyProvider>(
        builder: (context, provider, _) {
          final policyStatus = provider.policy.status;
          switch (policyStatus) {
            case Status.loading:
              return Center(child: CircularProgressIndicator());
            case Status.error:
              final error = provider.policy.message;
              return Center(
                child: ErrorCustomWidget.errorMessage(
                  error ?? "Failed to Fetch",
                  () {
                    provider.fetchPolicy(type);
                  },
                ),
              );
            case Status.completed:
              final data = provider.policy.data?.legal;
              return SingleChildScrollView(
                padding: EdgeInsets.all(15),
                child: Column(children: [Text(data?.content ?? 'N/A')]),
              );
          }
        },
      ),
    );
  }
}
