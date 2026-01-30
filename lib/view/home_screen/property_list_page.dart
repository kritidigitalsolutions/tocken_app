import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:token_app/resources/app_colors.dart';
import 'package:token_app/utils/buttons.dart';
import 'package:token_app/utils/text_style.dart';
import 'package:token_app/view/home_screen/filter/filter_page.dart';
import 'package:token_app/view/home_screen/location_screen.dart';
import 'package:token_app/view/home_screen/property_review_page.dart';
import 'package:token_app/viewModel/afterLogin/home_screen_provider.dart';

class PropertyListPage extends StatelessWidget {
  const PropertyListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: iconButton(
          onTap: () {
            context.read<HomeScreenProvicer>().clearAll();
            Navigator.pop(context);
          },
          icons: Icons.arrow_back,
        ),
        title: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => LocationScreen()),
            );
          },
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Text(
              "Kamla Nagar, Agra",
              style: TextStyle(color: Colors.black, fontSize: 14),
            ),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => LocationScreen()),
              );
            },
            child: Icon(Icons.search, color: Colors.black),
          ),
          SizedBox(width: 10),
          Icon(Icons.swap_vert, color: Colors.black),
          SizedBox(width: 10),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Filters row
          SingleChildScrollView(
            padding: EdgeInsets.all(12),
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => FilterPage()),
                    );
                  },
                  child: CircleAvatar(
                    backgroundColor: AppColors.grey.shade100,
                    child: Icon(Icons.filter_alt, color: AppColors.grey),
                  ),
                ),

                SizedBox(width: 8),
                _filterChip("1 BHK", removable: true),
                const SizedBox(width: 8),
                _filterChip("Property Type"),
                const SizedBox(width: 8),
                _filterChip("Furnishing"),
              ],
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(12),
              child: Column(
                children: [
                  const SizedBox(height: 16),

                  const Text(
                    "Showing Similar Properties near to Rashmi Nagar, Kamla Nagar, Agra",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),

                  const SizedBox(height: 12),

                  /// Property Card
                  Column(
                    children: List.generate(4, (index) {
                      return _propertyCard(context);
                    }),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// ---------------- PROPERTY CARD ----------------

  Widget _propertyCard(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => PropertyReviewPage()),
        );
      },
      child: Card(
        color: AppColors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Image Section
            Stack(
              children: [
                Container(
                  height: 180,
                  decoration: BoxDecoration(
                    color: AppColors.red[50],
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      "No Image Available",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),

                Positioned(
                  top: 10,
                  left: 10,
                  child: _badge("1RK/Studio House"),
                ),

                Positioned(
                  top: 10,
                  right: 10,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.favorite_border,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ),

                Positioned(
                  bottom: 10,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        "Request Photos",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "1RK/Studio House for rent in Khandari, Agra",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 8),

                  /// Price Row
                  Row(
                    children: const [
                      Text(
                        "₹ 4K / Month",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 10),
                      Text(
                        "+4000 Deposit",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  /// Info Row
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      _infoText("450 Sq ft", "Built-up Area"),
                      _infoText("1 RK", "BHK"),
                      _infoText("Semi Furnished", "Furnishing"),
                    ],
                  ),

                  const SizedBox(height: 10),

                  Wrap(
                    spacing: 8,
                    children: const [
                      _tag("North Facing"),
                      _tag("1 Covered Parking"),
                      _tag("1 Open Parking"),
                    ],
                  ),

                  const SizedBox(height: 10),

                  RichText(
                    text: const TextSpan(
                      text:
                          "This newly built large room with separate bath... ",
                      style: TextStyle(color: Colors.black),
                      children: [
                        TextSpan(
                          text: "more",
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 12),

                  /// Bottom Row
                  Row(
                    children: [
                      const CircleAvatar(child: Icon(Icons.person)),
                      const SizedBox(width: 8),
                      const Text(
                        "Posted by\nAshish",
                        style: TextStyle(fontSize: 12),
                      ),
                      const Spacer(),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.mainColors,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Text(
                          "View Number",
                          style: textStyle14(
                            FontWeight.bold,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        icon: const Icon(
                          Icons.call,
                          color: AppColors.mainColors,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// ---------------- REUSABLE WIDGETS ----------------

  static Widget _filterChip(String text, {bool removable = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.mainColors),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          Text(text),
          if (removable)
            const Padding(
              padding: EdgeInsets.only(left: 6),
              child: Icon(Icons.close, size: 16),
            ),
        ],
      ),
    );
  }

  static Widget _badge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey.shade700,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(text, style: const TextStyle(color: Colors.white)),
    );
  }
}

/// -------- SMALL COMPONENTS --------

class _infoText extends StatelessWidget {
  final String title;
  final String subtitle;

  const _infoText(this.title, this.subtitle);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          subtitle,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
        Spacer(),
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
}

class _tag extends StatelessWidget {
  final String text;
  const _tag(this.text);

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(text, style: const TextStyle(fontSize: 12)),
      backgroundColor: Colors.grey.shade100,
    );
  }
}
