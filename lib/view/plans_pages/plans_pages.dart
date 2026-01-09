import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:token_app/resources/app_colors.dart';
import 'package:token_app/view/plans_pages/plan_details_page.dart';
import 'package:token_app/viewModel/afterLogin/plans_provider/plan_provider.dart';

class PlansPage extends StatelessWidget {
  const PlansPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PlanDetailsProvider>(
      builder: (context, provider, _) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "I am a:",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),
                Text(
                  "Are you a Buyer, Seller, Agent, Landlord, Tenant, PG Owner or Co-Living user ?",
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                ),

                const SizedBox(height: 20),

                // Grid
                Expanded(
                  child: GridView.builder(
                    itemCount: provider.roles.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 14,
                      crossAxisSpacing: 14,
                      childAspectRatio: 1.1,
                    ),
                    itemBuilder: (context, index) {
                      final role = provider.roles[index];
                      final isSelected = provider.selectedRole == role.title;

                      return GestureDetector(
                        onTap: () {
                          provider.selectRole(role.title);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: AppColors.white,
                            border: Border.all(
                              color: isSelected
                                  ? AppColors.mainColors
                                  : Colors.grey.shade300,
                              width: 1.5,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(role.icon, height: 60),
                              const SizedBox(height: 10),
                              Text(
                                role.title,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: isSelected
                                      ? AppColors.mainColors
                                      : Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 8),

                // Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: provider.isSelected
                          ? AppColors.mainColors
                          : Colors.grey.shade300,
                      padding: EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: provider.isSelected
                        ? () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => PlanDetailsPage(
                                  type: provider.selectedRole ?? '',
                                ),
                              ),
                            );
                          }
                        : null,
                    child: Text(
                      "Select a plan ${provider.selectedRole ?? ''}",
                      style: TextStyle(
                        fontSize: 16,
                        color: provider.isSelected
                            ? Colors.white
                            : Colors.grey.shade600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
