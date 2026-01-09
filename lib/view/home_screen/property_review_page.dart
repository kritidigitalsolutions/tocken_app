import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:token_app/resources/app_colors.dart';
import 'package:token_app/utils/buttons.dart';
import 'package:token_app/utils/helper/helper_method.dart';
import 'package:token_app/utils/text_style.dart';

class PropertyReviewPage extends StatelessWidget {
  const PropertyReviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        actions: [
          _circleIcon(Icons.star_border),
          const SizedBox(width: 10),
          _circleIcon(Icons.share),
          const SizedBox(width: 12),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _noImageSection(),
                  _titleSection(),
                  _highlights(),
                  _propertyDetails(),

                  // Furniture
                  _furnitureDetails(),
                  _preferenceDetails(),

                  SizedBox(height: 90),
                ],
              ),
            ),
          ),
          _bottomBar(context),
        ],
      ),
    );
  }

  /// ---------------- IMAGE PLACEHOLDER ----------------
  Widget _noImageSection() {
    return Container(
      height: 220,
      width: double.infinity,
      color: const Color(0xffEAF4FF),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.home_outlined, size: 80, color: Colors.blueGrey),
          const SizedBox(height: 10),
          const Text(
            "No Image Available",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.black54,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.camera_alt_outlined, color: Colors.white, size: 18),
                SizedBox(width: 6),
                Text(
                  "Request Property Photos",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// ---------------- TITLE ----------------
  Widget _titleSection() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: RichText(
        text: const TextSpan(
          style: TextStyle(color: Colors.black, fontSize: 18),
          children: [
            TextSpan(
              text: "1RK/Studio House for rent, ",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(text: "Khandari, Agra"),
          ],
        ),
      ),
    );
  }

  /// ---------------- HIGHLIGHTS ----------------
  Widget _highlights() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Highlights",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              _Highlight(icon: Icons.chair, text: "Semi\nFurnished"),
              _Highlight(icon: Icons.square_foot, text: "450 Sq ft"),
              _Highlight(icon: Icons.layers, text: "Floor 1/2"),
              _Highlight(icon: Icons.calendar_today, text: "Less than\na year"),
            ],
          ),
        ],
      ),
    );
  }

  /// ---------------- PROPERTY DETAILS ----------------
  Widget _propertyDetails() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Property Details",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          _DetailRow("Age of the Property", "Less than a year"),
          SizedBox(height: 10),
          _DetailRow("No. of Balconies", "1 Balcony"),
          SizedBox(height: 10),
          _DetailRow("Furnished Type", "Semi Furnished"),
          SizedBox(height: 10),
          _DetailRow("Facing", "North Facing"),
          SizedBox(height: 10),
          _DetailRow("Flooring Type", "Granite Tiles Flooring"),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Show More"),
              SizedBox(width: 8),
              Icon(Icons.keyboard_arrow_down),
            ],
          ),
          Divider(color: AppColors.grey.shade200),
        ],
      ),
    );
  }

  // ---------------- Furniture -----------

  Widget _furnitureDetails() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Furnitures", style: textStyle17(FontWeight.bold)),
          SizedBox(height: 10),
          Wrap(
            runSpacing: 10,
            spacing: 10,
            children: [
              _furnitureContainer("Fan", FontAwesomeIcons.fan, AppColors.blue),
              _furnitureContainer("Bed", FontAwesomeIcons.bed, AppColors.teal),
              _furnitureContainer(
                "Wardrobe",
                FontAwesomeIcons.doorClosed,
                AppColors.mainColors,
              ),
              _furnitureContainer(
                "Modular Kitchen",
                FontAwesomeIcons.kitchenSet,
                AppColors.grey,
              ),
              _furnitureContainer(
                "Light",
                FontAwesomeIcons.lightbulb,
                AppColors.orange,
              ),
            ],
          ),
          SizedBox(height: 15),
          Divider(color: AppColors.grey.shade200),
        ],
      ),
    );
  }

  Widget _preferenceDetails() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Preferences", style: textStyle17(FontWeight.bold)),
          SizedBox(height: 10),
          Wrap(
            runSpacing: 10,
            spacing: 10,
            children: [
              _furnitureContainer(
                "Professional",
                FontAwesomeIcons.person,
                AppColors.blue,
              ),
              _furnitureContainer(
                "Only Veg",
                FontAwesomeIcons.plateWheat,
                AppColors.teal,
              ),
              _furnitureContainer(
                "Student",
                FontAwesomeIcons.children,
                AppColors.mainColors,
              ),
              _furnitureContainer(
                "Bachelor",
                FontAwesomeIcons.person,
                AppColors.grey,
              ),
            ],
          ),
          SizedBox(height: 15),
          Divider(color: AppColors.grey.shade200),
        ],
      ),
    );
  }

  Widget _furnitureContainer(String title, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: AppColors.grey),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color),
          SizedBox(width: 5),
          Text(title),
        ],
      ),
    );
  }

  /// ---------------- BOTTOM BAR ----------------
  Widget _bottomBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey)),
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "₹ 4K",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              GestureDetector(
                onTap: () {
                  PricingDetailsBottomSheet.show(
                    context,
                    rent: 2000,
                    securityDeposit: 2000,
                    maintenance: 1500,
                  );
                },
                child: Text(
                  "See Pricing in Detail",
                  style: TextStyle(color: AppColors.mainColors),
                ),
              ),
            ],
          ),
          const Spacer(),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.mainColors,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {
              ViewContactBottomSheet.show(context);
            },
            child: Text(
              "View Contact",
              style: textStyle14(FontWeight.w600, color: AppColors.white),
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () async {
              makePhoneCall('9999999999');
            },
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.red[50],
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.call, color: AppColors.mainColors),
            ),
          ),
        ],
      ),
    );
  }

  /// ---------------- HELPERS ----------------
  Widget _circleIcon(IconData icon) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
      child: Icon(icon, color: Colors.black),
    );
  }
}

/// ---------------- REUSABLE WIDGETS ----------------

class _Highlight extends StatelessWidget {
  final IconData icon;
  final String text;
  const _Highlight({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 26,
          backgroundColor: Colors.grey.shade300,
          child: Icon(icon, color: Colors.orange),
        ),
        const SizedBox(height: 6),
        Text(text, textAlign: TextAlign.center),
      ],
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String title;
  final String value;
  const _DetailRow(this.title, this.value);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            title,
            style: textStyle14(FontWeight.w600, color: AppColors.grey),
          ),
        ),

        Expanded(
          child: Text(
            value,
            style: textStyle14(FontWeight.bold, color: AppColors.black),
          ),
        ),
      ],
    );
  }
}

class PricingDetailsBottomSheet {
  static void show(
    BuildContext context, {
    required int rent,
    required int securityDeposit,
    int maintenance = 0,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 12,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /// drag handle
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),

              /// title
              const Text(
                "Pricing Details",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 16),

              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(color: AppColors.background),
                child: Column(
                  children: [
                    _priceRow("Monthly Rent", rent),
                    _priceRow("Security Deposit", securityDeposit),
                    if (maintenance > 0)
                      _priceRow("Maintenance Charges", maintenance),

                    SizedBox(height: 15),

                    Text(
                      "Electricity and Water charges are excluded from the Maintenance Charges",
                    ),
                  ],
                ),
              ),
              const Divider(height: 28),

              _priceRow(
                "Total Payable (Move-in)",
                rent + securityDeposit + maintenance,
                isTotal: true,
              ),

              const SizedBox(height: 20),

              SizedBox(height: 15),
              AppButton(
                text: "Contact Owner",
                onTap: () async {
                  makePhoneCall("9999999999");
                },
              ),
            ],
          ),
        );
      },
    );
  }

  static Widget _priceRow(String label, int amount, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 16 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
            ),
          ),
          const Spacer(),
          Text(
            "₹$amount",
            style: TextStyle(
              fontSize: isTotal ? 16 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

// view contact

class ViewContactBottomSheet {
  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 12,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /// drag handle
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),

              /// title
              const Text(
                "Owners Details to Contact",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 16),

              Container(
                decoration: BoxDecoration(color: AppColors.background),
                padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: AppColors.grey,
                        child: Icon(Icons.person, color: AppColors.white),
                      ),
                      title: Text(
                        'Amit kumar',
                        style: textStyle15(FontWeight.bold),
                      ),
                    ),
                    Divider(color: AppColors.grey.shade200),
                    SizedBox(height: 10),
                    Text("Phone Number", style: textStyle15(FontWeight.w900)),
                    SizedBox(height: 8),
                    Text("9999999999", style: textStyle15(FontWeight.w900)),
                  ],
                ),
              ),
              SizedBox(height: 15),

              Text(
                "Please make sure to use your registered phone number 9999999999 to contact the seller.",
              ),
              SizedBox(height: 15),
              AppButton(
                text: "Call Amit",
                onTap: () async {
                  makePhoneCall("9999999999");
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
