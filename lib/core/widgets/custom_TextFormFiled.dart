import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/app_assets.dart';
import '../theme_manager/color_pallete.dart';

class CustomTextFormFiled extends StatefulWidget {
  CustomTextFormFiled({
    super.key,
    this.controller,
    this.onChanged,
    this.onFiledSubmitted,
    required this.prefixIcon,
    required this.hintText,
    this.isPassword = false,
  });

  final TextEditingController? controller;
  void Function(String)? onChanged;
  void Function(String)? onFiledSubmitted;
  final Widget prefixIcon;
  String hintText;
  bool isPassword;

  @override
  State<CustomTextFormFiled> createState() => _CustomTextFormFiledState();
}

class _CustomTextFormFiledState extends State<CustomTextFormFiled> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      onChanged: widget.onChanged,
      onFieldSubmitted: widget.onFiledSubmitted,
      obscureText: widget.isPassword ? obscureText : false,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: ColorPallete.textFiledBorderColor,
        ),
        prefixIcon: widget.prefixIcon,
        suffixIcon: !widget.isPassword
            ? null
            : GestureDetector(
                onTap: () {
                  obscureText = !obscureText;
                  setState(() {});
                },
                child: obscureText
                    ? Icon(
                        Icons.visibility_off,
                        color: ColorPallete.textFiledBorderColor,
                      )
                    : Icon(
                        Icons.visibility,
                        color: ColorPallete.textFiledBorderColor,
                      ),
              ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: ColorPallete.textFiledBorderColor,
            width: 1.5,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: ColorPallete.textFiledBorderColor,
            width: 1.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: ColorPallete.textFiledBorderColor,
            width: 1.5,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: ColorPallete.textFiledBorderErrorColor,
            width: 1.5,
          ),
        ),
      ),
    );
  }
}
