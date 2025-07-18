import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme_manager/color_pallete.dart';

class CustomButtom extends StatelessWidget {
  const CustomButtom({super.key, required this.onTap, this.backgroundColor=ColorPallete.primaryColor, required this.child});
  final VoidCallback onTap;
  final Color backgroundColor;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        padding: EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        side: BorderSide(color: ColorPallete.primaryColor)
      ),
      child: child,
    );
  }
}
