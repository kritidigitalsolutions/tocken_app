import 'package:flutter/material.dart';
import 'package:token_app/resources/app_colors.dart';
import 'package:token_app/utils/buttons.dart';
import 'package:token_app/utils/text_style.dart';

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
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Perfect for those who searching\nfor PG!",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 16),

                  /// PLAN CARDS
                  Row(
                    children: const [
                      Expanded(child: _PlanCardPro()),
                      SizedBox(width: 12),
                      Expanded(child: _PlanCardProPlus()),
                    ],
                  ),

                  const SizedBox(height: 20),

                  /// FEATURES
                  _FeaturesCard(),
                  SizedBox(height: 15),

                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "View less",

                          style: textStyle15(
                            FontWeight.w600,
                            color: AppColors.grey,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Pro plan is Valid for 60 days",

                          style: textStyle18(FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15),

                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Frequently Asked question",

                          style: textStyle15(FontWeight.w900),
                        ),
                        SizedBox(height: 15),
                        FAQWidget(
                          faqs: [
                            FAQItem(
                              question: "What is PG Seeker Plan?",
                              answer:
                                  "PG Seeker Plan helps you connect with verified PG owners easily.",
                            ),
                            FAQItem(
                              question: "Can I cancel my subscription?",
                              answer:
                                  "Yes, you can cancel anytime from your profile settings.",
                            ),
                            FAQItem(
                              question: "Is GST included in the price?",
                              answer: "Yes, all prices are inclusive of GST.",
                            ),

                            FAQItem(
                              question: "What is PG Seeker Plan?",
                              answer:
                                  "PG Seeker Plan helps you connect with verified PG owners easily.",
                            ),
                            FAQItem(
                              question: "Can I cancel my subscription?",
                              answer:
                                  "Yes, you can cancel anytime from your profile settings.",
                            ),
                            FAQItem(
                              question: "Is GST included in the price?",
                              answer: "Yes, all prices are inclusive of GST.",
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          /// OFFER STRIP
          Container(
            color: Colors.black,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              children: const [
                Icon(Icons.local_offer, color: Colors.red),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    "Upgrade to Premium & Save ₹200! Claim this limited offer.",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),

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
      ),
    );
  }
}

/// ---------------- PLAN CARDS ----------------

class _PlanCardPro extends StatelessWidget {
  const _PlanCardPro();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.mainColors),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _OfferBadge(),
          const SizedBox(height: 10),

          Row(
            children: [
              const Text(
                "Pro",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  "Most Popular",
                  style: TextStyle(color: Colors.white, fontSize: 11),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          const Text(
            "₹399",
            style: TextStyle(
              decoration: TextDecoration.lineThrough,
              color: Colors.grey,
            ),
          ),

          Row(
            children: const [
              Text(
                "₹199",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 4),
              Text("Incl. GST"),
            ],
          ),

          const SizedBox(height: 6),

          _SaveBadge("Save ₹200"),
        ],
      ),
    );
  }
}

class _PlanCardProPlus extends StatelessWidget {
  const _PlanCardProPlus();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _OfferBadge(),
          const SizedBox(height: 10),

          Row(
            children: [
              const Text(
                "Pro Plus",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    "Best Value",
                    style: TextStyle(color: Colors.white, fontSize: 11),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          const Text(
            "₹999",
            style: TextStyle(
              decoration: TextDecoration.lineThrough,
              color: Colors.grey,
            ),
          ),

          Row(
            children: const [
              Text(
                "₹499",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 4),
              Text("+18% GST"),
            ],
          ),

          const SizedBox(height: 6),

          _SaveBadge("Save ₹500"),
        ],
      ),
    );
  }
}

/// ---------------- COMMON WIDGETS ----------------

class _OfferBadge extends StatelessWidget {
  const _OfferBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.orange),
      ),
      child: const Text(
        "⚡ Offer Ends in 2 days",
        style: TextStyle(fontSize: 11),
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
        children: const [
          Text(
            "Pro Plan Features",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0B3C8A),
            ),
          ),
          SizedBox(height: 6),
          Text(
            "Made for people looking for reliable and verified PGs with ease.",
          ),
          SizedBox(height: 14),

          _FeatureItem("Access to 10 contacts"),
          _FeatureItem("Bookmark unlimited properties"),
          _FeatureItem("Phone number privacy"),
          _FeatureItem("On-demand support"),
          _FeatureItem("Premium Filters"),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "View less",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Pro plan is Valid for 60 days",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
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
