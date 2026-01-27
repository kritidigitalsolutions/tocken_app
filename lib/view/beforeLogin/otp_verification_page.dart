import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:token_app/resources/app_colors.dart';
import 'package:token_app/utils/buttons.dart';
import 'package:token_app/viewModel/beforeLogin/auth_provider.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String phone;

  const OtpVerificationScreen({super.key, required this.phone});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final int otpLength = 6;
  late List<TextEditingController> controllers;
  late List<FocusNode> focusNodes;

  @override
  void initState() {
    super.initState();

    controllers = List.generate(otpLength, (_) => TextEditingController());
    focusNodes = List.generate(otpLength, (_) => FocusNode());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      focusNodes.first.requestFocus();
    });

    context.read<OtpVerificationProvider>().startTimer();
  }

  bool get isOtpComplete =>
      controllers.every((controller) => controller.text.isNotEmpty);

  String get otpValue =>
      controllers.map((controller) => controller.text).join();

  void clearAll() {
    for (var c in controllers) {
      c.clear();
    }
    focusNodes.first.requestFocus();
    setState(() {});
  }

  @override
  void dispose() {
    for (var c in controllers) {
      c.dispose();
    }
    for (var f in focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => OtpVerificationProvider(),
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),

                const Text(
                  "OTP Verification",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 12),

                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Enter the OTP sent to +91 ${widget.phone}",
                        style: const TextStyle(color: Colors.black54),
                      ),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Edit"),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                /// OTP BOXES
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                    otpLength,
                    (index) => SizedBox(
                      width: 48,
                      height: 56,
                      child: TextField(
                        controller: controllers[index],
                        focusNode: focusNodes[index],
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        maxLength: 1,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        decoration: InputDecoration(
                          counterText: "",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onChanged: (value) {
                          if (value.isNotEmpty && index < otpLength - 1) {
                            focusNodes[index + 1].requestFocus();
                          }
                          if (value.isEmpty && index > 0) {
                            focusNodes[index - 1].requestFocus();
                          }
                          setState(() {});
                        },
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                /// RESEND + TIMER
                Consumer<OtpVerificationProvider>(
                  builder: (context, provider, child) {
                    return Row(
                      children: [
                        const Text("Didn't get the OTP? "),
                        provider.canResend
                            ? GestureDetector(
                                onTap: () {
                                  clearAll();
                                  provider.resendOtp(context, widget.phone);
                                },
                                child: const Text(
                                  "Resend it",
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              )
                            : Text(
                                "Resend it",
                                style: TextStyle(color: Colors.grey.shade400),
                              ),
                        const Spacer(),
                        Text(
                          "00:${provider.seconds.toString().padLeft(2, '0')}",
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ],
                    );
                  },
                ),

                const SizedBox(height: 20),

                /// VERIFY BUTTON
                Consumer<OtpVerificationProvider>(
                  builder: (context, provider, child) {
                    return AppButton(
                      text: "Verify OTP",
                      isLoading: provider.isLoading,
                      onTap: isOtpComplete && !provider.isLoading
                          ? () {
                              provider.verifyOtp(
                                context,
                                widget.phone,
                                otpValue,
                              );
                            }
                          : null,
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
