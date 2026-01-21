import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:token_app/data/status.dart';
import 'package:token_app/main.dart';
import 'package:token_app/resources/app_colors.dart';
import 'package:token_app/utils/buttons.dart';
import 'package:token_app/utils/text_style.dart';
import 'package:token_app/view/beforeLogin/phone_number_screen.dart';
import 'package:token_app/viewModel/policy_view_model/policy_provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<PolicyProvider>();
    return Scaffold(
      backgroundColor: const Color(0xffF2F4F7),
      body: Column(
        children: [
          /// 🔹 TOP IMAGE WITH CURVE
          Stack(
            children: [
              ClipPath(
                clipper: BottomCurveClipper(),
                child: Image.asset(
                  'assets/auth/login.jpg',
                  height: MediaQuery.of(context).size.height * 0.6,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),

              /// 🔹 TOP BAR
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset('assets/tocken.png', height: 60, width: 100),
                      TextAppButton(
                        text: "Skip login",
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (_) => MyHomePage()),
                            (route) => route.isFirst,
                          );
                        },
                        color: AppColors.black,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          /// 🔹 PRIVACY TEXT
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: const TextStyle(color: Colors.black87, fontSize: 14),
                children: [
                  const TextSpan(
                    text:
                        "By clicking Agree & Join or Continue, you agree to Hexahome’s ",
                  ),
                  TextSpan(
                    text: "Privacy Policy",
                    style: TextStyle(
                      color: AppColors.blue,
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        provider.fetchPolicy("privacy");
                        showModalBottomSheet(
                          constraints: BoxConstraints(
                            maxHeight: 500,
                            minHeight: 500,
                          ),
                          showDragHandle: true,
                          isScrollControlled: true,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(15),
                            ),
                          ),
                          context: context,
                          builder: (_) {
                            return policyBottomSheet(context, "Privacy Policy");
                          },
                        );
                        print("Privacy Policy tapped");
                      },
                  ),
                  const TextSpan(text: " and "),
                  TextSpan(
                    text: "Terms and Conditions.",
                    style: const TextStyle(
                      color: AppColors.blue,
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        provider.fetchPolicy("terms");
                        showModalBottomSheet(
                          showDragHandle: true,
                          isScrollControlled: true,
                          constraints: BoxConstraints(
                            maxHeight: 500,
                            minHeight: 500,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(15),
                            ),
                          ),
                          context: context,
                          builder: (_) {
                            return policyBottomSheet(
                              context,

                              "Terms & Conditions",
                            );
                          },
                        );
                        print("terms and condition Policy tapped");
                      },
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          /// 🔹 AGREE & JOIN BUTTON
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: SizedBox(
              width: double.infinity,
              height: 54,
              child: AppButton(
                text: "Agree & Join",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => PhoneNumberScreen()),
                  );
                },
              ),
            ),
          ),

          //  const SizedBox(height: 16),

          // /// 🔹 GOOGLE BUTTON
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 24),
          //   child: SizedBox(
          //     width: double.infinity,
          //     height: 54,
          //     child: OutlinedButton.icon(
          //       style: OutlinedButton.styleFrom(
          //         backgroundColor: Colors.white,
          //         shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(14),
          //         ),
          //       ),
          //       onPressed: () {},
          //       icon: Image.network(
          //         "https://upload.wikimedia.org/wikipedia/commons/0/09/IOS_Google_icon.png",
          //         height: 22,
          //       ),
          //       label: const Text(
          //         "Continue with Google",
          //         style: TextStyle(
          //           color: Colors.black87,
          //           fontSize: 16,
          //           fontWeight: FontWeight.w600,
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          const SizedBox(height: 12),

          /// 🔹 SIGN IN
          TextAppButton(
            text: "Sign In",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => PhoneNumberScreen()),
              );
            },
            color: AppColors.blue,
            size: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  "Already have your account?",
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 4),
              TextAppButton(
                text: "Log in",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => PhoneNumberScreen()),
                  );
                },
                color: AppColors.blue,
                size: 16,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget policyBottomSheet(BuildContext context, String title) {
    return Consumer<PolicyProvider>(
      builder: (context, provider, _) {
        final policyState = provider.policy;
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
            color: AppColors.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(title, style: textStyle17(FontWeight.bold)),
              const SizedBox(height: 16),

              /// 🔹 LOADING
              if (policyState.status == Status.loading)
                const Padding(
                  padding: EdgeInsets.all(20),
                  child: Center(child: CircularProgressIndicator()),
                ),

              /// 🔹 ERROR
              if (policyState.status == Status.error)
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    policyState.message ?? 'Failed to load policy',
                    style: const TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                ),

              /// 🔹 SUCCESS
              if (policyState.status == Status.completed)
                Expanded(
                  child: SingleChildScrollView(
                    child: Text(
                      policyState.data?.legal?.content ?? '',
                      style: const TextStyle(
                        fontSize: 14,
                        height: 1.6,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

class BottomCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 60);

    path.quadraticBezierTo(
      size.width / 2,
      size.height,
      size.width,
      size.height - 60,
    );

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
