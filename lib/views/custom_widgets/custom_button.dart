import 'package:flutter/material.dart';
import 'package:halftimepick/utils/colors.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onTap;
  final String buttonText;
  final double borderRadius;
  final double height;
  final double width;

  const CustomButton({
    super.key,
    required this.onTap,
    required this.buttonText,
    this.borderRadius = 8.0,
    this.height = 50.0,
    this.width = double.infinity,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        alignment: Alignment.center,
        width: width,
        height: height,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        decoration: BoxDecoration(
          color: ProjectColors.bottomnavselectedcolor,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Text(
          buttonText,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: Colors.white,
                fontSize: 14,
                fontFamily: 'Space Grotesk',
                fontWeight: FontWeight.w500,
              ),
        ),
      ),
    );
  }
}
