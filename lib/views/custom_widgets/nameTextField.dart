import 'package:flutter/material.dart';
import 'package:halftimepick/utils/colors.dart';

class FullNameTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String? Function(String?)? validator;

  const FullNameTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.validator,
  });

  @override
  // ignore: library_private_types_in_public_api
  _FullNameTextFieldState createState() => _FullNameTextFieldState();
}

class _FullNameTextFieldState extends State<FullNameTextField> {
  bool isFocused = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: ProjectColors.primaryColor),
      child: TextFormField(
        cursorColor: ProjectColors.grey,
        style: const TextStyle(
          color: Colors.white, // Set your desired text color
        ),
        keyboardType: TextInputType.name,
        controller: widget.controller,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: const TextStyle(
            color: ProjectColors.textfieldHint,
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
              color: isFocused ? ProjectColors.grey : ProjectColors.grey,
              width: 0.1,
            ),
            gapPadding: 4.0,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
            borderSide: const BorderSide(
              color: ProjectColors.grey,
              width: 1,
            ),
            gapPadding: 4.0,
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
            borderSide: const BorderSide(
              color: Colors.red, // Red color for validation error
              width: 0.1,
            ),
            gapPadding: 4.0,
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
            borderSide: const BorderSide(
              color: Colors.red, // Red color for validation error when focused
              width: 0.1,
            ),
            gapPadding: 4.0,
          ),
        ),
        validator: (value) {
          if (widget.validator != null) {
            return widget.validator!(value);
          }
          return null;
        },
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
        // Additional configuration as needed
      ),
    );
  }
}
