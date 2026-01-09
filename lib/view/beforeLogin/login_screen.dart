import 'package:flutter/material.dart';
import 'package:token_app/main.dart';
import 'package:token_app/resources/app_colors.dart';
import 'package:token_app/utils/buttons.dart';
import 'package:token_app/view/beforeLogin/phone_number_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
              text: const TextSpan(
                style: TextStyle(color: Colors.black87, fontSize: 14),
                children: [
                  TextSpan(
                    text:
                        "By clicking Agree & Join or Continue, you agree to Hexahome’s ",
                  ),
                  TextSpan(
                    text: "Privacy Policy",
                    style: TextStyle(
                      color: AppColors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  TextSpan(text: " and "),
                  TextSpan(
                    text: "Terms and Conditions.",
                    style: TextStyle(
                      color: AppColors.blue,
                      decoration: TextDecoration.underline,
                    ),
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
