import 'package:flutter/material.dart';

class InstructorCard extends StatelessWidget {
  const InstructorCard({super.key, required this.assetName});
  final String assetName;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      child: Container(
        constraints: const BoxConstraints(maxHeight: 160, minHeight: 0),
        child: AspectRatio(
          aspectRatio: 170 / 160,
          child: Image.asset(
            assetName,
            fit: BoxFit.fitHeight,
          ),
        ),
      ),
    );
  }
}
