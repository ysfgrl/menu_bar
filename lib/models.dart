library menu_bar;

import 'package:flutter/material.dart';

class BarItem{
  int id;
  String label;
  IconData icon;
  IconData? selectedIcon;
  Widget? badge;
  Color iconColor;
  Color iconBgColor;
  Color? selectedIconColor;
  Color? selectedIconBgColor;
  TextStyle? textStyle;
  BarItem({
    required this.id,
    required this.label,
    required this.icon,
    required this.iconColor,
    required this.iconBgColor,
    this.selectedIcon,
    this.selectedIconColor,
    this.selectedIconBgColor,
    this.badge,
    this.textStyle
  });
}

enum AnimationType{
  top,
  bottom
}