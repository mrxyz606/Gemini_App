// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:gemini_app/Shared/Constants/dimenstions.dart';

Widget AuthTextFormField({
    required TextEditingController controller,
    TextInputType type = TextInputType.text,
    bool obscured = false,
    bool suffixEnabled = false,
    IconData? suffixIcon,
    String hintText = "",
    String validatorText = "",
    void Function()? suffixFunction,
    void Function(String text)? onChanged
  }) {
    return TextFormField(
      cursorColor: Colors.green[300],
      keyboardType: type,
      obscureText: obscured,
      validator: (value) {
        if (value!.isEmpty) {
          return validatorText;
        }
        return null;
      },
      style: const TextStyle(color: Colors.white),
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        contentPadding: Pads.medium_Padding,
        suffixIcon: suffixEnabled ?
        IconButton(
          onPressed: suffixFunction,
          icon: Icon(
            suffixIcon,
            color: Colors.white.withOpacity(0.7),
          ),
        ) : null,
        hintStyle: TextStyle(color: Colors.white.withOpacity(0.8)),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide:
                BorderSide(color: Colors.white.withOpacity(0.85), width: 2)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide:
                BorderSide(color: Colors.white.withOpacity(0.85), width: 2)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
                color: Colors.green[300]!.withOpacity(0.85), width: 2)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
                color: Colors.red[300]!.withOpacity(0.85), width: 2)),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
                color: Colors.red.withOpacity(0.85), width: 2)),
        errorStyle: TextStyle(color: Colors.red[200])
      ),
    );
  }