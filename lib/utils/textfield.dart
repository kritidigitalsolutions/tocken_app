import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:token_app/resources/app_colors.dart';

class AppTextField extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;
  final String hintText;
  final TextInputType keyboardType;
  final bool isPassword;
  final int maxLines;
  final bool enabled;
  final bool? filled;
  final Color? fillColor;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool? readOnly;
  final String? Function(String?)? validator;

  final Color borderColor;
  final Color focusedBorderColor;
  final Color errorBorderColor;

  const AppTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
    this.maxLines = 1,
    this.enabled = true,
    this.prefixIcon,
    this.fillColor,
    this.filled,
    this.readOnly,
    this.suffixIcon,
    this.focusNode,
    this.validator,
    this.borderColor = AppColors.grey,
    this.focusedBorderColor = AppColors.mainColors,
    this.errorBorderColor = AppColors.mainColors,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool _obscureText = true;

  OutlineInputBorder _border(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: color, width: 1.5),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      keyboardType: widget.keyboardType,
      readOnly: widget.readOnly ?? false,
      obscureText: widget.isPassword ? _obscureText : false,
      enabled: widget.enabled,
      maxLines: widget.isPassword ? 1 : widget.maxLines,

      validator: widget.validator,
      decoration: InputDecoration(
        filled: widget.filled,
        fillColor: widget.fillColor,
        hintText: widget.hintText,
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
            : widget.suffixIcon,
        enabledBorder: _border(widget.borderColor),
        focusedBorder: _border(widget.focusedBorderColor),
        errorBorder: _border(widget.errorBorderColor),
        focusedErrorBorder: _border(widget.errorBorderColor),
        disabledBorder: _border(Colors.grey.shade300),
      ),
    );
  }
}

class AppNumberField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final int? maxLength;
  final bool allowDecimal;
  final int? min;
  final int? max;
  final Color borderColor;
  final Color focusedBorderColor;
  final Color errorBorderColor;
  final ValueChanged<String>? onChanged;

  const AppNumberField({
    super.key,
    required this.controller,
    required this.hintText,
    this.maxLength,
    this.allowDecimal = false,
    this.min,
    this.max,
    this.borderColor = AppColors.grey,
    this.focusedBorderColor = AppColors.mainColors,
    this.errorBorderColor = AppColors.mainColors,
    this.onChanged,
  });

  OutlineInputBorder _border(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: color, width: 1.5),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.numberWithOptions(
        decimal: allowDecimal,
        signed: false,
      ),
      inputFormatters: [
        FilteringTextInputFormatter.allow(
          allowDecimal ? RegExp(r'^\d*\.?\d*$') : RegExp(r'^\d*$'),
        ),
        if (maxLength != null) LengthLimitingTextInputFormatter(maxLength),
      ],
      onChanged: (value) {
        if (value.isEmpty) {
          onChanged?.call(value);
          return;
        }

        final numVal = allowDecimal
            ? double.tryParse(value)
            : int.tryParse(value);

        if (numVal == null) return;

        if (min != null && numVal < min!) {
          controller.text = min.toString();
          controller.selection = TextSelection.collapsed(
            offset: controller.text.length,
          );
        }

        if (max != null && numVal > max!) {
          controller.text = max.toString();
          controller.selection = TextSelection.collapsed(
            offset: controller.text.length,
          );
        }

        onChanged?.call(value);
      },
      decoration: InputDecoration(
        hintText: hintText,
        counterText: "",
        enabledBorder: _border(borderColor),
        focusedBorder: _border(focusedBorderColor),
        errorBorder: _border(errorBorderColor),
        focusedErrorBorder: _border(errorBorderColor),
        disabledBorder: _border(Colors.grey.shade300),
      ),
    );
  }
}

class CustomDropdown extends StatelessWidget {
  final String? value;
  final String hint;
  final List<String> items;
  final ValueChanged<String?> onChanged;
  final Color borderColor;
  final Color focusedBorderColor;

  const CustomDropdown({
    super.key,
    required this.value,
    required this.hint,
    required this.items,
    required this.onChanged,
    this.borderColor = Colors.grey,
    this.focusedBorderColor = Colors.red,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      initialValue: value,
      dropdownColor: AppColors.white,
      hint: Text(hint),
      icon: Icon(Icons.keyboard_arrow_down, color: focusedBorderColor),
      items: items
          .map((item) => DropdownMenuItem(value: item, child: Text(item)))
          .toList(),
      onChanged: onChanged,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 14,
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: borderColor, width: 1.2),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: focusedBorderColor, width: 1.5),
        ),

        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red, width: 1.2),
        ),

        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red, width: 1.5),
        ),
      ),
    );
  }
}
