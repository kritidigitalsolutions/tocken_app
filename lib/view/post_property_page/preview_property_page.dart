import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:token_app/resources/app_colors.dart';
import 'package:token_app/utils/buttons.dart';
import 'package:token_app/utils/text_style.dart';
import 'package:token_app/view/post_property_page/success_page.dart';
import 'package:token_app/view/post_property_page/type_property_page.dart';
import 'package:token_app/viewModel/afterLogin/post_property_provider/post_propert_providers.dart';

class PreviewPropertyScreen extends StatelessWidget {
  const PreviewPropertyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final typeProProvider = context.read<TypePropertyProvider>();
    final propertyDetailSPr = context.read<PropertyDetailsProvider>();
    final addressProvider = context.read<AddressDetailsProvider>();
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text(
          'Preview Property',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// STEP INDICATOR
            Container(
              decoration: BoxDecoration(color: AppColors.white),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        _stepBar(active: true),
                        _stepBar(active: true),
                        _stepBar(active: true),
                      ],
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Step 3 of 3',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),

            /// Property Image
            Expanded(
              child: Container(
                decoration: BoxDecoration(color: AppColors.background),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Image.network(
                            'https://images.unsplash.com/photo-1600585154340-be6161a56a0c',
                            height: 220,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                height: 220,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: AppColors.grey,
                                ),
                                child: Center(child: Icon(Icons.error_outline)),
                              );
                            },
                          ),
                          Positioned(
                            right: 12,
                            bottom: 12,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.6),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Text(
                                '1 / 1',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      /// Tags
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Row(
                          children: [
                            _chip(
                              'For ${propertyDetailSPr.sellOrRent}',
                              Colors.green,
                            ),
                            const SizedBox(width: 8),
                            _chip(
                              typeProProvider.selectedType ?? 'NA',
                              Colors.grey.shade200,
                              textColor: Colors.black,
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 12),

                      /// Price & Title
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              propertyDetailSPr.propertyTitle.text.trim(),
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 6),
                            Text(
                              '₹ ${propertyDetailSPr.amountCtr.text.trim()}',
                              style: TextStyle(
                                fontSize: 22,
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 8),

                      /// Location
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              size: 18,
                              color: Colors.grey,
                            ),
                            SizedBox(width: 6),
                            Text(
                              '${addressProvider.city}, ${addressProvider.addressCtr.text.trim()}',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      /// Property Details
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 12),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Property Details',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Expanded(
                                  child: _detailItem(
                                    icon: Icons.home,
                                    title: 'Configuration',
                                    value: propertyDetailSPr.bhkType ?? 'N/A',
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: _detailItem(
                                    icon: Icons.crop_square,
                                    title: 'Area',
                                    value:
                                        "${propertyDetailSPr.areaCtr.text.trim()} sq.ft",
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                  child: _detailItem(
                                    icon: Icons.chair_alt_outlined,
                                    title: 'Furnishing',
                                    value: propertyDetailSPr.furType ?? 'N?A',
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: _detailItem(
                                    icon: FontAwesomeIcons.hotel,
                                    title: 'Floor',
                                    value:
                                        "${propertyDetailSPr.floorNumberCtr.text.trim()} To ${propertyDetailSPr.totalFloorCtr.text.trim()}",
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 12),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Text(
                          "Address Details",
                          style: textStyle15(FontWeight.w600),
                        ),
                      ),
                      SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Text(
                          addressProvider.addressCtr.text.trim(),
                          style: textStyle13(
                            FontWeight.w600,
                            color: AppColors.grey,
                          ),
                        ),
                      ),

                      const SizedBox(height: 90),
                    ],
                  ),
                ),
              ),
            ),

            Container(
              decoration: BoxDecoration(color: AppColors.white),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Expanded(
                      child: IconAppButton(
                        text: "Edit",
                        icon: Icons.edit,
                        onTap: () {
                          typeProProvider.clearAll();
                          propertyDetailSPr.clearData();
                          addressProvider.clearAll();
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TypePropertyPage(),
                            ),
                            (route) => route.isFirst,
                          );
                        },
                        backgroundColor: AppColors.white,
                        textColor: AppColors.black,
                        iconColor: AppColors.grey,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: AppButton(
                        text: "Submit Property",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => SuccessPage()),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _chip(
    String text,
    Color color, {
    Color textColor = Colors.white,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(text, style: TextStyle(color: textColor)),
    );
  }

  Widget _stepBar({bool active = false}) {
    return Expanded(
      child: Container(
        height: 4,
        margin: const EdgeInsets.only(right: 6),
        decoration: BoxDecoration(
          color: active ? Colors.red : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }

  static Widget _detailItem({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: Colors.red),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: textStyle13(FontWeight.w500, color: AppColors.grey),
                ),
                Text(value, style: textStyle15(FontWeight.w600)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
