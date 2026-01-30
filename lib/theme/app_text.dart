import 'package:flutter/material.dart';
import 'app_color.dart';

class AppText {
  /// ===== TITLE =====
  static TextStyle title(BuildContext context) {
    return TextStyle(
      fontFamily: 'Urbanist',
      fontSize: 22,
      fontWeight: FontWeight.bold,
      color: _textColor(context),
    );
  }

  /// ===== BODY =====
  static TextStyle body(BuildContext context) {
    return TextStyle(
      fontFamily: 'Urbanist',
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: _textColor(context),
    );
  }

  /// ===== CAPTION =====
  static TextStyle caption(BuildContext context) {
    return TextStyle(
      fontFamily: 'Urbanist',
      fontSize: 14,
      color: AppColor.grey,
    );
  }

  /// ===== LINK =====
  static TextStyle link(BuildContext context) {
    return TextStyle(
      fontFamily: 'Urbanist',
      fontSize: 14,
      fontWeight: FontWeight.normal,
      color: AppColor.grey,
    );
  }

  /// ===== BUTTON =====
  static TextStyle button(BuildContext context) {
    return const TextStyle(
      fontFamily: 'Urbanist',
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    );
  }

  /// ===== PRIVATE HELPERS =====
  static Color _textColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : AppColor.black;
  }

  static Color _mutedTextColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? Colors.white70
        : AppColor.grey.shade700;
  }
}