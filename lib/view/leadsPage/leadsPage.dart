import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:token_app/resources/app_colors.dart';
import 'package:token_app/utils/buttons.dart';
import 'package:token_app/utils/helper/helper_method.dart';
import 'package:token_app/utils/text_style.dart';
import 'package:token_app/viewModel/afterLogin/leadScreenProvider/leads_screen_controller.dart';

class LeadsView extends StatelessWidget {
  const LeadsView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Column(
        children: [
          /// Custom App Bar
          Container(
            height: 56,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            alignment: Alignment.center,
            decoration: BoxDecoration(color: AppColors.white),
            child: const Text(
              "Leads",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ),
          Consumer<LeadsScreenController>(
            builder: (context, controller, _) {
              return Container(
                width: double.infinity,
                decoration: BoxDecoration(color: AppColors.white),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Row(
                      spacing: 12,
                      children: List.generate(controller.statusList.length, (
                        index,
                      ) {
                        final status = controller.statusList[index];
                        final isSelected = controller.selectedIndex == index;
                        final count = controller.getStatusCount(status);

                        return GestureDetector(
                          onTap: () => controller.onStatusSelected(index),
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  width: 2,
                                  color: isSelected
                                      ? AppColors.mainColors
                                      : AppColors.background,
                                ),
                              ),
                            ),
                            child: Center(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    status,
                                    style: textStyle14(
                                      color: isSelected
                                          ? AppColors.mainColors
                                          : AppColors.black,
                                      FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    ' (${count.toString()})',
                                    style: textStyle14(
                                      color: isSelected
                                          ? AppColors.mainColors
                                          : AppColors.black,
                                      FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              );
            },
          ),

          /// Content
          Expanded(
            child: Consumer<LeadsScreenController>(
              builder: (context, controller, _) {
                final leads = controller.filteredLeads;

                if (leads.isEmpty) {
                  return const Center(child: Text("No leads found"));
                }

                return ListView.separated(
                  padding: const EdgeInsets.all(10),
                  itemCount: leads.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final lead = leads[index];

                    return LeadCard(
                      name: lead["name"],
                      status: lead["status"],
                      title: lead["title"],
                      subtitle: lead["subtitle"],
                      location: lead["location"],
                      price: lead["price"],
                      phone: lead["phone"],
                      source: lead["source"],
                      id: lead["id"],
                      imageUrl: lead["imageUrl"],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class LeadCard extends StatelessWidget {
  final String name, status, title, subtitle, location;
  final String price, phone, source, id, imageUrl;

  const LeadCard({
    super.key,
    required this.name,
    required this.status,
    required this.title,
    required this.subtitle,
    required this.location,
    required this.price,
    required this.phone,
    required this.source,
    required this.id,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      color: AppColors.white,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Name + Status
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: statusColors(status).withAlpha(40),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        status,
                        style: TextStyle(
                          fontSize: 12,
                          color: statusColors(status),
                        ),
                      ),
                    ),
                  ],
                ),
                Text('2h 30m'),
              ],
            ),
            const SizedBox(height: 10),

            /// Image + Details
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    color: AppColors.grey,
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: NetworkImage(imageUrl),

                      fit: BoxFit.cover,
                      onError: (exception, stackTrace) =>
                          Center(child: Icon(Icons.image)),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        subtitle,
                        style: const TextStyle(color: Colors.grey),
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            size: 14,
                            color: Colors.grey,
                          ),
                          Text(
                            location,
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        price,
                        style: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            /// Contact Info
            Text(phone),
            Text(
              "Source: $source    ID: $id",
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),

            const SizedBox(height: 10),

            /// Buttons
            Row(
              children: [
                Expanded(
                  child: IconAppButton(
                    text: 'Call',
                    icon: Icons.call_outlined,
                    onTap: () async {
                      makePhoneCall('6666666666');
                    },
                    backgroundColor: AppColors.mainColors,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: IconAppButton(
                    text: 'WhatsApp',
                    icon: Icons.chat_bubble_outline,
                    onTap: () {},
                    backgroundColor: AppColors.green,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color statusColors(String status) {
    switch (status) {
      case 'New':
        return AppColors.blue;
      case 'Contacted':
        return AppColors.orange;
      case 'Closed':
        return AppColors.green;
      default:
        return AppColors.mainColors;
    }
  }
}
