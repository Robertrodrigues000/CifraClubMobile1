import 'package:cifraclub/domain/log/repository/log_repository.dart';
import 'package:cifraclub/extensions/build_context.dart';
import 'package:flutter/material.dart';

class ArtistListItem extends StatelessWidget {
  final String title;
  final int ranking;

  const ArtistListItem({super.key, required this.title, required this.ranking});

  @override
  Widget build(BuildContext context) {
    final typography = context.typography;

    return InkWell(
      onTap: () => logger?.log(tag: runtimeType.toString(), message: "Tapped on $title"), // coverage:ignore-line
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 40,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "$ranking",
                  style: typography.subtitle3.copyWith(color: context.colors.textSecondary),
                ),
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            Text(
              title,
              style: typography.subtitle3,
            )
          ],
        ),
      ),
    );
  }
}
