import 'package:flutter/material.dart';
import 'package:token_app/resources/app_colors.dart';
import 'package:token_app/utils/text_style.dart';

// Common button like submit

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final Color backgroundColor;
  final Color textColor;
  final double height;
  final double radius;
  final bool isLoading;

  const AppButton({
    super.key,
    required this.text,
    required this.onTap,
    this.backgroundColor = AppColors.mainColors,
    this.textColor = AppColors.white,
    this.height = 48,
    this.radius = 12,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
        ),
        onPressed: isLoading ? null : onTap,
        child: isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: AppColors.white,
                ),
              )
            : Text(text, style: textStyle15(color: textColor, FontWeight.w600)),
      ),
    );
  }
}

// Outline button

class OutlineAppButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color borderColor;

  const OutlineAppButton({
    super.key,
    required this.text,
    required this.onTap,
    this.borderColor = AppColors.mainColors,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      width: double.infinity,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: borderColor),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: onTap,
        child: Text(
          text,
          style: TextStyle(
            color: borderColor,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

// icon button with text

class IconAppButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onTap;
  final Color? iconColor;
  final Color textColor;
  final Color? backgroundColor;

  const IconAppButton({
    super.key,
    required this.text,
    required this.icon,
    required this.onTap,
    this.iconColor = AppColors.white,
    this.textColor = AppColors.white,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: onTap,
        icon: Icon(icon, size: 20, color: iconColor),
        label: Text(
          text,
          style: textStyle15(FontWeight.bold, color: textColor),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}

// Gradient button

class GradientButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const GradientButton({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 48,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: const LinearGradient(
            colors: [AppColors.mainColors, AppColors.orange],
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: AppColors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

// Textbutton

class TextAppButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color color;
  final double size;

  const TextAppButton({
    super.key,
    required this.text,
    required this.onTap,
    this.color = AppColors.mainColors,
    this.size = 14,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      child: Text(
        text,
        style: TextStyle(
          fontSize: size,
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

// Circle Icon Button

class CircleIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const CircleIconButton({super.key, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(50),
      child: Container(
        height: 48,
        width: 48,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.mainColors,
        ),
        child: Icon(icon, color: AppColors.white),
      ),
    );
  }
}

IconButton iconButton({
  required VoidCallback onTap,
  required IconData icons,
  Color color = AppColors.grey,
  double size = 20,
}) {
  return IconButton(
    onPressed: onTap,
    icon: Icon(icons, size: size, color: color),
  );
}
