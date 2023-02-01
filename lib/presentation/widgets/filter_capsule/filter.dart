import 'package:flutter/material.dart';

class Filter {
  final String label;
  final VoidCallback onTap;
  final bool isSelected;

  Filter({
    required this.label,
    required this.onTap,
    required this.isSelected,
  });
}
