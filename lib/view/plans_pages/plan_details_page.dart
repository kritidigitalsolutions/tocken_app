import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:token_app/data/status.dart';
import 'package:token_app/model/response_model/plan/plan_res_model.dart';
import 'package:token_app/resources/app_colors.dart';
import 'package:token_app/utils/buttons.dart';
import 'package:token_app/utils/error_custom_widget.dart';
import 'package:token_app/utils/text_style.dart';
import 'package:token_app/viewModel/afterLogin/plans_provider/plan_provider.dart';

class PlanDetailsPage extends StatelessWidget {
  final String type;
  const PlanDetailsPage({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.mainColors,
        elevation: 0,
        leading: iconButton(
          onTap: () {
            Navigator.pop(context);
          },
          icons: Icons.arrow_back,
          color: AppColors.white,
        ),
        title: Text(
          "$type Plans",
          style: textStyle17(FontWeight.w900, color: AppColors.white),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: Icon(Icons.share, color: AppColors.white),
          ),
        ],
      ),
      body: Consumer<PlanDetailsProvider>(
        builder: (context, provider, _) {
          final status = provider.plans.status;

          switch (status) {
            case Status.loading:
              return Center(child: CircularProgressIndicator());
            case Status.error:
              final error = provider.plans.message;
              return Center(
                child: ErrorCustomWidget.errorMessage(
                  error ?? "Failed to fetch",
                  () {},
                ),
              );
            case Status.completed:
              final plans = provider.plans.data;
              final planList = plans?.plans ?? [];
              final selectedPlan = provider.selectedPlan;
              return Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Perfect for those who searching\nfor PG!",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 16),

                          /// PLAN CARDS
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                  childAspectRatio: 0.95,
                                ),
                            itemCount: planList.length,
                            itemBuilder: (context, index) {
                              final plan = planList[index];

                              if (planList.isEmpty) {
                                return Text(
                                  "Not Found plan",
                                  style: textStyle15(FontWeight.bold),
                                );
                              }

                              return _PlanCardPro(
                                plan: plan,
                                isSelected: selectedPlan?.id == plan.id,
                                onTap: () => provider.selectPlan(plan),
                              );
                            },
                          ),

                          const SizedBox(height: 20),

                          /// FEATURES
                          if (provider.selectedPlan != null)
                            _FeaturesCard(
                              features: provider.selectedPlan!.features,
                              validityDays: provider.selectedPlan!.validityDays,
                            ),
                          SizedBox(height: 15),

                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Frequently Asked Questions",
                                  style: textStyle15(FontWeight.w900),
                                ),
                                const SizedBox(height: 15),

                                /// FAQ STATES
                                Builder(
                                  builder: (_) {
                                    switch (provider.faqs.status) {
                                      case Status.loading:
                                        return const CircularProgressIndicator();

                                      case Status.error:
                                        return Text(
                                          provider.faqs.message ??
                                              "Failed to load FAQs",
                                        );

                                      case Status.completed:
                                        final faqList =
                                            provider.faqs.data?.faqs ?? [];
                                        if (faqList.isEmpty) {
                                          return const Text(
                                            "No FAQs available",
                                          );
                                        }

                                        return FAQWidget(
                                          faqs: faqList.map((faq) {
                                            return FAQItem(
                                              question: faq.ques ?? "N/A",
                                              answer: faq.ans ?? "N/A",
                                            );
                                          }).toList(),
                                        );
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // /// OFFER STRIP
                  // Container(
                  //   color: Colors.black,
                  //   padding: const EdgeInsets.symmetric(
                  //     horizontal: 12,
                  //     vertical: 10,
                  //   ),
                  //   child: Row(
                  //     children: const [
                  //       Icon(Icons.local_offer, color: Colors.red),
                  //       SizedBox(width: 8),
                  //       Expanded(
                  //         child: Text(
                  //           "Upgrade to Premium & Save ₹200! Claim this limited offer.",
                  //           style: TextStyle(color: Colors.white),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),

                  /// CTA BUTTON
                  ///
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: AppButton(
                      text: "Subscribe to Pro Plan (₹199 Incl. GST)",
                      onTap: () {},
                    ),
                  ),
                ],
              );
          }
        },
      ),
    );
  }
}

/// ---------------- PLAN CARDS ----------------

class _PlanCardPro extends StatelessWidget {
  final Plan plan;
  final bool isSelected;
  final VoidCallback onTap;

  const _PlanCardPro({
    required this.plan,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final saveMoney = (plan.originalPrice ?? 0) - (plan.price ?? 0);

    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.mainColors.withOpacity(0.1)
              : AppColors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected ? AppColors.mainColors : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _OfferBadge(plan.offerEndsInDays ?? 0),
            const SizedBox(height: 10),

            Row(
              children: [
                Expanded(
                  child: Text(
                    plan.planName ?? "N/A",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (plan.tag != null)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      plan.tag!,
                      style: const TextStyle(color: Colors.white, fontSize: 11),
                    ),
                  ),
              ],
            ),

            const SizedBox(height: 10),

            if (plan.originalPrice != null)
              Text(
                "₹ ${plan.originalPrice}",
                style: const TextStyle(
                  decoration: TextDecoration.lineThrough,
                  color: Colors.grey,
                ),
              ),

            Row(
              children: [
                Text(
                  "₹ ${plan.price ?? 0}",
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (plan.gstIncluded == true)
                  const Padding(
                    padding: EdgeInsets.only(left: 4),
                    child: Text("Incl. GST"),
                  ),
              ],
            ),

            const SizedBox(height: 6),

            if (saveMoney > 0) _SaveBadge("Save ₹ $saveMoney"),
          ],
        ),
      ),
    );
  }
}

/// ---------------- COMMON WIDGETS ----------------

class _OfferBadge extends StatelessWidget {
  final int offerEnd;
  const _OfferBadge(this.offerEnd);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.orange),
      ),
      child: Text(
        "⚡ Offer Ends in ${offerEnd.toString()} days",
        style: const TextStyle(fontSize: 11),
      ),
    );
  }
}

class _SaveBadge extends StatelessWidget {
  final String text;
  const _SaveBadge(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 12),
      ),
    );
  }
}

/// ---------------- FEATURES ----------------

class _FeaturesCard extends StatelessWidget {
  final List<String> features;
  final int? validityDays;

  const _FeaturesCard({required this.features, this.validityDays});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFEAF3FF),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Plan Features",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0B3C8A),
            ),
          ),
          const SizedBox(height: 14),

          ...features.map((f) => _FeatureItem(f)),

          if (validityDays != null) ...[
            const SizedBox(height: 12),
            Center(
              child: Text(
                "Plan valid for $validityDays days",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _FeatureItem extends StatelessWidget {
  final String text;
  const _FeatureItem(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: AppColors.green, size: 20),
          const SizedBox(width: 8),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}

class FAQItem {
  final String question;
  final String answer;

  FAQItem({required this.question, required this.answer});
}

class FAQWidget extends StatefulWidget {
  final List<FAQItem> faqs;

  const FAQWidget({super.key, required this.faqs});

  @override
  State<FAQWidget> createState() => _FAQWidgetState();
}

class _FAQWidgetState extends State<FAQWidget> {
  int _expandedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.faqs.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        final faq = widget.faqs[index];
        final isExpanded = _expandedIndex == index;

        return Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () {
                  setState(() {
                    _expandedIndex = isExpanded ? -1 : index;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          faq.question,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Icon(
                        isExpanded
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                      ),
                    ],
                  ),
                ),
              ),

              /// Answer
              AnimatedCrossFade(
                firstChild: const SizedBox(),
                secondChild: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  child: Text(
                    faq.answer,
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
                  ),
                ),
                crossFadeState: isExpanded
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration: const Duration(milliseconds: 200),
              ),
            ],
          ),
        );
      },
    );
  }
}
