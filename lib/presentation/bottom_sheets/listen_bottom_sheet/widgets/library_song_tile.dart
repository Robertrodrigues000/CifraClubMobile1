import 'dart:typed_data';

import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/constants/app_svgs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LibrarySongTile extends StatelessWidget {
  final Uint8List? image;
  final String artistName;
  final String songName;
  final VoidCallback onTap;

  const LibrarySongTile({
    super.key,
    required this.image,
    required this.artistName,
    required this.songName,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.colors.neutralPrimary,
      child: InkWell(
        onTap: onTap,
        child: Ink(
          height: 72,
          padding: EdgeInsets.symmetric(horizontal: context.appDimensionScheme.screenMargin),
          child: Row(
            children: [
              // coverage:ignore-start
              if (image != null)
                ClipOval(
                  child: Image.memory(
                    image!,
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                  ),
                )
              else
                SizedBox(
                  width: 40,
                  height: 40,
                  child: ClipOval(
                    child: SvgPicture.asset(
                      AppSvgs.artistsAvatarPlaceHolder,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              // coverage:ignore-end
              SizedBox.fromSize(size: const Size.fromWidth(16)),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      songName,
                      style: context.typography.subtitle3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox.fromSize(size: const Size.fromHeight(2)),
                    Text(
                      artistName,
                      style: context.typography.subtitle5,
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
