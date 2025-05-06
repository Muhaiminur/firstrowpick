import 'package:flutter/material.dart';
import 'package:halftimepick/utils/colors.dart';

enum ValidationType { email, phone, both }

class PhnEmailTextfield extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final ValidationType validationType; // Add the validation type enum
  final String? Function(String?)? validator;

  const PhnEmailTextfield({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.validationType,
    this.validator,
  }) : super(key: key);

  @override
  _PhnEmailTextfieldState createState() => _PhnEmailTextfieldState();
}

class _PhnEmailTextfieldState extends State<PhnEmailTextfield> {
  bool isFocused = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: ProjectColors.primaryColor),
      child: TextFormField(
        cursorColor: ProjectColors.white,
        style: const TextStyle(
          color: Colors.white, // Set your desired text color
        ),
        controller: widget.controller,
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
              color:
                  isFocused ? ProjectColors.primaryColor : ProjectColors.grey,
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
        keyboardType: TextInputType.emailAddress,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          if (widget.validator != null) {
            if (widget.validationType == ValidationType.email) {
              // Check only email validation
              final isValidEmail = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                  .hasMatch(value ?? '');
              if (!isValidEmail) {
                return 'Please enter a valid email';
              }
            } else if (widget.validationType == ValidationType.phone) {
              // Check only phone validation
              final isValidPhoneNumber =
                  RegExp(r'^(?:\+88|0088)?01[13-9]\d{8}$')
                      .hasMatch(value ?? '');
              if (!isValidPhoneNumber) {
                return 'Please enter a valid phone number';
              }
            } else if (widget.validationType == ValidationType.both) {
              // Check both email and phone validation
              final isValidEmail = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                  .hasMatch(value ?? '');
              final isValidPhoneNumber =
                  RegExp(r'^(?:\+88|0088)?01[13-9]\d{8}$')
                      .hasMatch(value ?? '');

              if (!isValidEmail && !isValidPhoneNumber) {
                return 'Please enter a valid email or phone number';
              }
            }

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
