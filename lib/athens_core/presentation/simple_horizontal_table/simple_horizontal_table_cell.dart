import 'package:flutter/material.dart';

class SimpleHorizontalTableCell {
  final IconData? icon;
  final String lowerText;
  final String? upperText;

  SimpleHorizontalTableCell({this.icon, required this.lowerText, this.upperText}) : assert(icon != null || upperText != null);
}