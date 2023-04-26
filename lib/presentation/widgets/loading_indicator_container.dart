// coverage:ignore-file
import 'package:cifraclub/extensions/build_context.dart';
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';

class LoadingIndicatorContainer extends StatelessWidget {
  const LoadingIndicatorContainer({
    super.key,
    required this.isLoading,
  });
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: isLoading ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 320),
      child: AnimatedScale(
        duration: const Duration(milliseconds: 320),
        scale: isLoading ? 1.0 : 0.8,
        child: Center(
          child: Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(8)), color: context.colors.neutralSecondary),
            child: const LoadingIndicator(),
          ),
        ),
      ),
    );
  }
}
