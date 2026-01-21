import 'package:flutter/material.dart';
import 'package:token_app/utils/text_style.dart';

class ErrorCustomWidget {
  static Widget errorMessage(String text, VoidCallback onTap) {
    return Column(
      children: [
        Text(text, style: textStyle15(FontWeight.w600)),
        SizedBox(height: 12),
        OutlinedButton(
          onPressed: onTap,
          child: Text("Retry", style: textStyle15(FontWeight.w500)),
        ),
      ],
    );
  }
}
