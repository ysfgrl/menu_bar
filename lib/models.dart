library menu_bar;

import 'package:flutter/material.dart';

class BarItem{
  int id;
  String label;
  Widget icon;
  Widget? selectedIcon;
  Widget? badge;
  Color iconBgColor;
  Color? selectedIconBgColor;
  TextStyle? textStyle;
  BarItem({
    required this.id,
    required this.label,
    required this.icon,
    required this.iconBgColor,
    this.selectedIcon,
    this.selectedIconBgColor,
    this.badge,
    this.textStyle
  });
}

enum AnimationType{
  top,
  bottom
}