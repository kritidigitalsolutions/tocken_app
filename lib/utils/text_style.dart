import 'package:flutter/material.dart';
import 'package:token_app/resources/app_colors.dart';

class TextWithStyle {
  static Text appBar(String text) {
    return Text(
      text,
      style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
    );
  }
}

TextStyle textStyle11(FontWeight fontWeight, {Color color = AppColors.black}) {
  return TextStyle(fontSize: 11, fontWeight: fontWeight, color: color);
}

TextStyle textStyle12(FontWeight fontWeight, {Color color = AppColors.black}) {
  return TextStyle(fontSize: 12, fontWeight: fontWeight, color: color);
}

TextStyle textStyle13(FontWeight fontWeight, {Color color = AppColors.black}) {
  return TextStyle(fontSize: 13, fontWeight: fontWeight, color: color);
}

TextStyle textStyle14(FontWeight fontWeight, {Color color = AppColors.black}) {
  return TextStyle(fontSize: 14, fontWeight: fontWeight, color: color);
}

TextStyle textStyle15(FontWeight fontWeight, {Color color = AppColors.black}) {
  return TextStyle(fontSize: 15, fontWeight: fontWeight, color: color);
}

TextStyle textStyle16(FontWeight fontWeight, {Color color = AppColors.black}) {
  return TextStyle(fontSize: 16, fontWeight: fontWeight, color: color);
}

TextStyle textStyle17(FontWeight fontWeight, {Color color = AppColors.black}) {
  return TextStyle(fontSize: 17, fontWeight: fontWeight, color: color);
}

TextStyle textStyle18(FontWeight fontWeight, {Color color = AppColors.black}) {
  return TextStyle(fontSize: 18, fontWeight: fontWeight, color: color);
}

TextStyle textStyle20(FontWeight fontWeight, {Color color = AppColors.black}) {
  return TextStyle(fontSize: 20, fontWeight: fontWeight, color: color);
}
