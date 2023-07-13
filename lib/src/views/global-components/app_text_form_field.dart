import 'package:flutter/material.dart';
import 'package:share_near/src/utils/constants.dart';
import 'package:share_near/src/views/global-components/text_form_field_suffix_icon.dart';

class AppTextFormField extends StatelessWidget {
  const AppTextFormField({
    super.key,
    required this.label,
    required this.hintText,
    required this.svgIcon,
    required this.controller,
    this.obscure,
    this.textInputType,
    this.validator,
    this.maxLines,
    this.maxLength,
  });

  final String label;
  final String hintText;
  final String svgIcon;
  final bool? obscure;
  final int? maxLines;
  final int? maxLength;
  final TextInputType? textInputType;
  final TextEditingController controller;
  final Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: textInputType ?? TextInputType.text,
      obscureText: obscure ?? false,
      controller: controller,
      maxLines: maxLines ?? 1,
      maxLength: maxLength ?? 30,
      validator: (value) {
        return validator!(value);
      },
      decoration: InputDecoration(
        label: Text(
          label,
          style: const TextStyle(color: textColor),
        ),
        hintText: hintText,
        suffixIcon: TextFormSuffixIcon(
          svgIcon: svgIcon,
        ),
        counterText: "",
      ),
    );
  }
}

