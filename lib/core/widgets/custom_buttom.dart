import 'package:flutter/material.dart';
import '../theme_manager/color_pallete.dart';

class CustomButtom extends StatelessWidget {
  const CustomButtom({
    super.key,
    required this.onTap,
    this.backgroundColor = ColorPallete.primaryColor,
    this.borderColor=ColorPallete.primaryColor,
    required this.child,
  });

  final VoidCallback onTap;
  final Color backgroundColor;
  final Color borderColor;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: backgroundColor,
        padding: EdgeInsets.symmetric(vertical: 12 ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        side: BorderSide(color: borderColor),
      ),
      child: child,
    );
  }
}
