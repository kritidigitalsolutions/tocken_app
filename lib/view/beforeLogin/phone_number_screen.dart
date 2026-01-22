import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:token_app/main.dart';
import 'package:token_app/resources/app_colors.dart';
import 'package:token_app/utils/buttons.dart';
import 'package:token_app/view/beforeLogin/otp_verification_page.dart';
import 'package:token_app/viewModel/beforeLogin/auth_provider.dart';

class PhoneNumberScreen extends StatefulWidget {
  const PhoneNumberScreen({super.key});

  @override
  State<PhoneNumberScreen> createState() => _PhoneNumberScreenState();
}

class _PhoneNumberScreenState extends State<PhoneNumberScreen> {
  late FocusNode _phoneFocusNode;

  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _phoneFocusNode = FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _phoneFocusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _phoneFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.read<PhoneNumberProvider>();
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// 🔹 TOP BAR
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => Navigator.pop(context),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (_) => MyHomePage()),
                          (route) => route.isFirst,
                        );
                      },
                      child: const Text(
                        "Skip for Now",
                        style: TextStyle(
                          color: Color(0xff0B3C8D),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 40),

                /// 🔹 TITLE
                const Text(
                  "Enter your phone number to proceed",
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 30),

                /// 🔹 LABEL
                const Text(
                  "Phone Number",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),

                const SizedBox(height: 8),

                /// 🔹 PHONE INPUT
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      /// 🇮🇳 FLAG
                      Image.asset(
                        'assets/auth/india_flag.png',
                        height: 22,
                        width: 22,
                      ),
                      const SizedBox(width: 6),

                      /// +91
                      const Text("(+91)", style: TextStyle(fontSize: 16)),

                      const SizedBox(width: 8),

                      /// INPUT
                      Expanded(
                        child: TextFormField(
                          controller: provider.phoneController,
                          focusNode: _phoneFocusNode,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(10),
                          ],
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "10 digit phone number",
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Phone number is required";
                            }

                            if (value.length != 10) {
                              return "Enter 10 digit mobile number";
                            }

                            if (!RegExp(r'^[6-9]\d{9}$').hasMatch(value)) {
                              return "Enter valid Phone Number";
                            }

                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                /// 🔹 SEND OTP BUTTON
                ///
                Selector<PhoneNumberProvider, bool>(
                  selector: (_, p) => p.isValid,
                  builder: (context, isLoading, child) {
                    return AppButton(
                      text: "Send OTP",
                      // isLoading: isLoading,
                      height: 54,
                      onTap: !isLoading
                          ? null
                          : () {
                              if (_formKey.currentState!.validate()) {
                                // context.read<PhoneNumberProvider>().login(
                                //   context,
                                // );
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => OtpVerificationScreen(
                                      phone: provider.phoneController.text
                                          .trim(),
                                    ),
                                  ),
                                );
                              }
                            },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
