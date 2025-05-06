import 'package:flutter/material.dart';
import 'package:halftimepick/utils/colors.dart';

class GeneralFormField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;

  const GeneralFormField({
    super.key,
    required this.controller,
    required this.hintText,
  });

  @override
  // ignore: library_private_types_in_public_api
  _GeneralFormFieldState createState() => _GeneralFormFieldState();
}

class _GeneralFormFieldState extends State<GeneralFormField> {
  bool isFocused = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      maxLines: null, // Allow multiple lines
      minLines: 3, // Set minimum lines
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: const TextStyle(
          color: ProjectColors.grey, // Change to your desired hint color
          fontSize: 14,
          fontFamily: 'Space Grotesk',
          fontWeight: FontWeight.w400,
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 16.0,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.0),
          borderSide: BorderSide(
            color: isFocused
                ? ProjectColors.primaryColor
                : ProjectColors.grey, // Change to your desired border color
            width: 0.4,
          ),
          gapPadding: 4.0,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.0),
          borderSide: const BorderSide(
            color: ProjectColors
                .primaryColor, // Change to your desired focused border color
            width: 0.4,
          ),
          gapPadding: 4.0,
        ),
      ),
      onChanged: (value) {
        setState(() {
          isFocused = true; // Update the focus state when the text changes
        });
      },
      onTap: () {
        setState(() {
          isFocused = true; // Update the focus state when tapped
        });
      },
      onFieldSubmitted: (value) {
        setState(() {
          isFocused = false; // Update the focus state when submitted
        });
      },
      style: const TextStyle(
        height: 1.5, // Set line height
      ),
      // Additional configuration as needed
    );
  }
}
