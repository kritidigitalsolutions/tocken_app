import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:token_app/resources/app_colors.dart';
import 'package:token_app/utils/buttons.dart';
import 'package:token_app/viewModel/afterLogin/post_property_provider/pg_provider.dart';

class SummaryPage extends StatefulWidget {
  final String? propertyType;
  final String? type;
  final String? proClasses;
  const SummaryPage({super.key, this.proClasses, this.propertyType, this.type});

  @override
  State<SummaryPage> createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {
  @override
  Widget build(BuildContext context) {
    final pro = context.read<PgDetailsProvider>();
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text("Summary"),
        centerTitle: true,
        actions: [TextButton(onPressed: () {}, child: const Text("Help"))],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Description header
            const Text(
              "Description *",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     const Text(
            //       "Description *",
            //       style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            //     ),
            //     // OutlinedButton.icon(
            //     //   onPressed: () {
            //     //     // TODO: AI generate
            //     //   },
            //     //   icon: const Icon(Icons.auto_awesome, size: 16),
            //     //   label: const Text("Generate With AI"),
            //     // ),
            //   ],
            // ),
            // const SizedBox(height: 8),

            /// TextField
            TextField(
              controller: pro.descController,
              maxLines: 6,
              maxLength: 1500,
              decoration: InputDecoration(
                hintText: "Enter other attractive things about your property",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 8),
            const Text(
              "Here are some useful things to include in your description:",
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),

            const BulletText("About your property."),
            const BulletText("About the property environment."),
            const BulletText("More amenities and preference."),
            const BulletText("Contact details and web links aren’t allowed."),

            const Spacer(),

            /// Complete Button
            /// Save Button
            AppButton(
              text: "Complete & Posting",
              onTap: () {
                if (widget.type == "Rent" &&
                    widget.proClasses == "Residential") {
                  pro.postProperty();
                  return;
                }
                pro.pgPost();
              },
            ),
            SizedBox(height: 15),
            AppButton(
              text: "Cancel",
              onTap: () {},
              textColor: AppColors.black,
              backgroundColor: AppColors.red.shade100,
            ),
          ],
        ),
      ),
    );
  }
}

/// Reusable bullet widget
class BulletText extends StatelessWidget {
  final String text;
  const BulletText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("• "),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}
