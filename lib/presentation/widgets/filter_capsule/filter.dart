import 'package:flutter/material.dart';

class Filter {
  final String label;
  final VoidCallback onTap;
  final bool isSelected;
  final String? leadingIconUri;
  final String? trailingIconUri;

  Filter({
    required this.label,
    required this.onTap,
    required this.isSelected,
    this.leadingIconUri,
    this.trailingIconUri,
  });
}
