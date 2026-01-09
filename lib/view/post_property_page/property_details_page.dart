import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:token_app/resources/app_colors.dart';
import 'package:token_app/utils/buttons.dart';
import 'package:token_app/utils/text_style.dart';
import 'package:token_app/utils/textfield.dart';
import 'package:token_app/view/post_property_page/address_details_page.dart';
import 'package:token_app/viewModel/afterLogin/post_property_provider/post_propert_providers.dart';

class PropertyDetailsPage extends StatefulWidget {
  final String propertyType;
  const PropertyDetailsPage({super.key, required this.propertyType});

  @override
  State<PropertyDetailsPage> createState() => _PropertyDetailsPageState();
}

class _PropertyDetailsPageState extends State<PropertyDetailsPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<PropertyDetailsProvider>().clearData();
  }

  @override
  void dispose() {
    // Clear provider data when page is popped
    context.read<PropertyDetailsProvider>().clearData();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.read<PropertyDetailsProvider>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        leading: Consumer<PropertyDetailsProvider>(
          builder: (context, p, child) {
            return IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                p.clearData();
                Navigator.pop(context);
              },
            );
          },
        ),
        title: const Text(
          'Property Details',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            /// STEP INDICATOR
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [_stepBar(active: true), _stepBar(), _stepBar()],
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Step 1 of 3',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            /// FORM
            Expanded(
              child: Container(
                decoration: BoxDecoration(color: AppColors.background),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _label('Property Title'),
                      SizedBox(height: 8),
                      AppTextField(
                        controller: provider.propertyTitle,
                        hintText: 'e.g., Spacious 2BHK Apartment',
                        fillColor: AppColors.white,
                        filled: true,
                      ),

                      const SizedBox(height: 15),

                      _label('Property Type'),
                      SizedBox(height: 8),
                      _disabledField(widget.propertyType),

                      const SizedBox(height: 15),

                      _label('BHK Configuration'),
                      SizedBox(height: 8),
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: List.generate(provider.bhkTypeList.length, (
                          index,
                        ) {
                          return _choiceChip(provider.bhkTypeList[index]);
                        }),
                      ),

                      const SizedBox(height: 15),

                      // Property status
                      _label('Property Status'),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(child: _outlinedButton('Sell')),
                          const SizedBox(width: 12),
                          Expanded(child: _outlinedButton('Rent')),
                        ],
                      ),

                      const SizedBox(height: 15),

                      Selector<PropertyDetailsProvider, String>(
                        selector: (_, p) => p.price,
                        builder: (context, value, child) {
                          return Text(
                            value,
                            style: textStyle14(FontWeight.w500),
                          );
                        },
                      ),
                      const SizedBox(height: 8),
                      Selector<PropertyDetailsProvider, String>(
                        selector: (_, p) => p.priceHint,
                        builder: (context, value, child) {
                          return AppTextField(
                            controller: provider.amountCtr,
                            hintText: value,
                            fillColor: AppColors.white,
                            filled: true,
                            prefixIcon: Icon(
                              Icons.currency_rupee_outlined,
                              size: 18,
                            ),
                          );
                        },
                      ),

                      SizedBox(height: 15),
                      Text(
                        'Built-up Area',
                        style: textStyle14(FontWeight.w500),
                      ),
                      const SizedBox(height: 8),
                      AppTextField(
                        controller: provider.areaCtr,
                        hintText: 'Enter area in sq.ft',
                        fillColor: AppColors.white,
                        filled: true,
                        prefixIcon: Icon(Icons.area_chart_outlined, size: 18),
                      ),
                      SizedBox(height: 15),
                      _headerWithIcon(
                        "Furnishing Status",
                        Icons.chair_alt_outlined,
                      ),
                      SizedBox(height: 8),
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: List.generate(provider.furTypeList.length, (
                          index,
                        ) {
                          return Selector<PropertyDetailsProvider, String?>(
                            selector: (_, p) => p.furType,
                            builder: (context, value, child) {
                              final type = provider.furTypeList[index];
                              final bool isSelected = value == type;
                              return GestureDetector(
                                onTap: () {
                                  context
                                      .read<PropertyDetailsProvider>()
                                      .toggleFurni(type);
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? AppColors.mainColors
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: isSelected
                                          ? Colors.red
                                          : Colors.grey.shade300,
                                    ),
                                  ),
                                  child: Text(
                                    type,
                                    style: TextStyle(
                                      color: isSelected
                                          ? Colors.white
                                          : Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        }),
                      ),
                      SizedBox(height: 16),

                      // Floor number and other
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _headerWithIcon(
                                  "Floor Number",
                                  FontAwesomeIcons.hotel,
                                ),
                                SizedBox(height: 8),
                                AppTextField(
                                  controller: provider.floorNumberCtr,
                                  hintText: "e.g., 5",
                                  fillColor: AppColors.white,
                                  filled: true,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Total Floors',
                                  style: textStyle14(FontWeight.w500),
                                ),
                                SizedBox(height: 5),
                                AppTextField(
                                  controller: provider.totalFloorCtr,
                                  hintText: "e.g., 8",
                                  fillColor: AppColors.white,
                                  filled: true,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            /// CONTINUE BUTTON
            Selector<PropertyDetailsProvider, bool>(
              selector: (_, p) => p.isValid(),
              builder: (context, value, child) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AppButton(
                    text: "Continue",
                    onTap: !value
                        ? null
                        : () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddressDetailsPage(),
                              ),
                            );
                          },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // ---------- Widgets ----------
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

  Widget _label(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
    );
  }

  Widget _disabledField(String value) {
    return TextField(
      enabled: false,
      decoration: InputDecoration(
        hintText: value,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 14,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
      ),
    );
  }

  Widget _choiceChip(String text) {
    return Selector<PropertyDetailsProvider, String?>(
      selector: (_, provider) => provider.bhkType,
      builder: (context, selectedType, _) {
        final bool isSelected = selectedType == text;

        return GestureDetector(
          onTap: () {
            context.read<PropertyDetailsProvider>().toggleType(text);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: isSelected ? Colors.red : Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: isSelected ? Colors.red : Colors.grey.shade300,
              ),
            ),
            child: Text(
              text,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _outlinedButton(String text) {
    return Selector<PropertyDetailsProvider, String?>(
      selector: (_, p) => p.propertyStatus,
      builder: (context, value, child) {
        final isSelected = value == text;
        return GestureDetector(
          onTap: () {
            context.read<PropertyDetailsProvider>().toggleStatus(text);
            if (text == "Sell") {
              context.read<PropertyDetailsProvider>().togglePrice(
                'Price',
                "Enter price",
                "Sell",
              );
            } else {
              context.read<PropertyDetailsProvider>().togglePrice(
                "Monthly Rent",
                "Enter monthly rent",
                "Rent",
              );
            }
          },
          child: Container(
            height: 48,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: isSelected
                    ? AppColors.mainColors
                    : AppColors.grey.shade300,
                width: 1.5,
              ),
            ),
            child: Text(
              text,
              style: TextStyle(
                color: isSelected ? Colors.red : Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _headerWithIcon(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: AppColors.grey, size: 18),
        SizedBox(width: 10),
        Text(title, style: textStyle14(FontWeight.w500)),
      ],
    );
  }
}
