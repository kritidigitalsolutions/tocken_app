import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:token_app/resources/app_colors.dart';
import 'package:token_app/utils/text_style.dart';
import 'package:token_app/view/post_property_page/co_living_pages/profile_details_page.dart';
import 'package:token_app/view/post_property_page/pg_pages/pg_details.dart';
import 'package:token_app/view/post_property_page/rent_&_sale/commercial/office_details_page.dart';
import 'package:token_app/view/post_property_page/rent_&_sale/residential/apartment_page.dart';

class TypePropertySheet extends StatelessWidget {
  const TypePropertySheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Post Property", style: textStyle17(FontWeight.bold)),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),

            const SizedBox(height: 10),

            const Text(
              'What are you posting?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),

            const SizedBox(height: 20),

            /// Grid
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 1.1,
              children: [
                PropertyTile(
                  image: "assets/images/rent.svg",
                  label: 'Rent',
                  onTap: () {
                    final parentContext = context; // ✅ save valid context

                    Navigator.pop(context); // close first sheet

                    Future.microtask(() {
                      showModalBottomSheet(
                        context: parentContext,
                        backgroundColor: AppColors.white,
                        showDragHandle: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                        ),
                        builder: (ctx) {
                          return propertyTypeBottomSheet(ctx, "Rent");
                        },
                      );
                    });
                  },
                ),
                PropertyTile(
                  image: "assets/images/sale.svg",
                  label: 'Sale',
                  onTap: () {
                    final parentContext = context; // ✅ save valid context

                    Navigator.pop(context); // close first sheet

                    Future.microtask(() {
                      showModalBottomSheet(
                        context: parentContext,
                        backgroundColor: AppColors.white,
                        showDragHandle: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                        ),
                        builder: (ctx) {
                          return propertyTypeBottomSheet(ctx, "Sale");
                        },
                      );
                    });
                  },
                ),
                PropertyTile(
                  image: "assets/images/co-living.svg",
                  label: 'Co-Living',
                  onTap: () {
                    final parentContext = context; // ✅ save valid context

                    Navigator.pop(context); // close first sheet

                    Future.microtask(() {
                      showModalBottomSheet(
                        context: parentContext,
                        backgroundColor: AppColors.white,
                        showDragHandle: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                        ),
                        builder: (ctx) {
                          return propertyTypeCo_livingBottomSheet(ctx);
                        },
                      );
                    });
                  },
                ),
                PropertyTile(
                  image: "assets/images/pg.svg",
                  label: 'PG',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => PgDetailsPage()),
                    );
                  },
                ),
              ],
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class PropertyTile extends StatelessWidget {
  final String image;
  final String label;
  final VoidCallback onTap;
  const PropertyTile({
    super.key,
    required this.image,
    required this.label,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.grey.shade300, width: 1.5),
          borderRadius: BorderRadius.circular(12),
          color: AppColors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: SvgPicture.asset(image, fit: BoxFit.contain)),

            const SizedBox(height: 10),
            Text(
              label,
              style: textStyle15(FontWeight.w500, color: AppColors.black),
            ),
          ],
        ),
      ),
    );
  }
}

Widget propertyTypeBottomSheet(BuildContext context, String type) {
  return Column(
    children: [
      Text("Property Type", style: textStyle15(FontWeight.w600)),
      SizedBox(height: 15),
      Expanded(
        child: typeProperty(
          "Residential",
          "Turning, Spaces into Places, List with Heart",
          'assets/images/residen.svg',
          () {
            final childContext = context;
            Navigator.pop(context);
            showModalBottomSheet(
              backgroundColor: AppColors.white,
              showDragHandle: true,
              isScrollControlled: true,
              constraints: BoxConstraints(maxHeight: 600, minHeight: 500),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.vertical(
                  top: Radius.circular(20),
                ),
              ),
              context: childContext,
              builder: (ctx) {
                return propertyResidentList(ctx, type, "Residential");
              },
            );
          },
        ),
      ),
      SizedBox(height: 20),
      Expanded(
        child: typeProperty(
          "Commercial",
          "Where Vision Meets Venue: List for Business",
          'assets/images/commercial.svg',
          () {
            final childContext = context;
            Navigator.pop(context);
            showModalBottomSheet(
              backgroundColor: AppColors.white,
              showDragHandle: true,
              isScrollControlled: true,
              constraints: BoxConstraints(maxHeight: 600, minHeight: 500),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.vertical(
                  top: Radius.circular(20),
                ),
              ),
              context: childContext,
              builder: (ctx) {
                return propertyCommercialList(ctx, type, "Commercial");
              },
            );
          },
        ),
      ),
      SizedBox(height: 20),
    ],
  );
}

Widget typeProperty(
  String label,
  String subtitle,
  String image,
  VoidCallback onTap,
) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: AppColors.mainColors.withAlpha(100),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center, // ✅ vertical
                crossAxisAlignment: CrossAxisAlignment.center, // ✅ horizontal
                children: [
                  Text(label, textAlign: TextAlign.center),
                  const SizedBox(height: 6),
                  Text(subtitle, textAlign: TextAlign.center),
                ],
              ),
            ),
          ),
          Expanded(
            child: Center(child: SvgPicture.asset(image, fit: BoxFit.contain)),
          ),
        ],
      ),
    ),
  );
}

Widget propertyResidentList(
  BuildContext context,
  String type,
  String propertyCategory,
) {
  final typeList = [
    "Apartment",
    "Builder Floor",
    "Independent House",
    "Villa",
    "1RK/Studio House",
    "Others",
  ];
  return Container(
    padding: EdgeInsets.all(15),
    child: Column(
      children: [
        Text("Looking to rent a?", style: textStyle15(FontWeight.bold)),

        ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final selectedType = typeList[index];
            return ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ApartmentDetailsPage(
                      type: type,
                      propertyClass: propertyCategory,
                      propertyType: selectedType,
                    ),
                  ),
                );
              },
              leading: CircleAvatar(
                radius: 18,
                backgroundColor: AppColors.red.shade100,
                child: SvgPicture.asset(
                  "",
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(Icons.error);
                  },
                ),
              ),
              title: Text(typeList[index]),
            );
          },
          separatorBuilder: (context, index) {
            return Divider();
          },
          itemCount: typeList.length,
        ),
      ],
    ),
  );
}

Widget propertyCommercialList(
  BuildContext context,
  String type,
  String propertyCategory,
) {
  final typeList = [
    "Office",
    "Retail Shop",
    "Showroom",
    "Warehouse",
    "Plot/Land",
    "Others",
  ];
  return Container(
    padding: EdgeInsets.all(15),
    child: Column(
      children: [
        Text("Looking to rent a?", style: textStyle15(FontWeight.bold)),

        ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final selectedType = typeList[index];
            return ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => OfficeSpaceDetailsPage(
                      type: type,
                      propertyClass: propertyCategory,
                      propertyType: selectedType,
                    ),
                  ),
                );
              },
              leading: CircleAvatar(
                radius: 18,
                backgroundColor: AppColors.red.shade100,
                child: SvgPicture.asset(
                  "",
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(Icons.error);
                  },
                ),
              ),
              title: Text(typeList[index]),
            );
          },
          separatorBuilder: (context, index) {
            return Divider();
          },
          itemCount: typeList.length,
        ),
      ],
    ),
  );
}

// Co-living

Widget propertyTypeCo_livingBottomSheet(BuildContext context) {
  return Column(
    children: [
      Text("Property Type", style: textStyle15(FontWeight.w600)),
      SizedBox(height: 15),
      Expanded(
        child: typeProperty(
          "Looking for Room/Flat",
          "Turning, Spaces into Places, List with Heart",
          'assets/images/residen.svg',
          () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => ProfileDetailsPage()),
            );
            // Navigator.pop(context);
          },
        ),
      ),
      SizedBox(height: 20),
      Expanded(
        child: typeProperty(
          "Have a Room/Flat to share",
          "Where Vision Meets Venue: List for Business",
          'assets/images/commercial.svg',
          () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => ProfileDetailsPage()),
            );
          },
        ),
      ),
      SizedBox(height: 20),
    ],
  );
}
