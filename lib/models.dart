library menu_bar;

import 'package:flutter/material.dart';

class BarItem{
  int id;
  String label;
  IconData icon;
  IconData? selectedIcon;
  Widget? badge;
  Color color;
  Color? selectedColor;
  TextStyle? textStyle;
  BarItem({
    required this.id,
    required this.label,
    required this.icon,
    required this.color,
    this.selectedIcon,
    this.selectedColor,
    this.badge,
    this.textStyle
  });
}

enum AnimationType{
  top,
  bottom
}