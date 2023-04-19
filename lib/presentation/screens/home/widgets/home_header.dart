import 'package:cifraclub/domain/user/models/user.dart';
import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/constants/app_svgs.dart';
import 'package:cifraclub/presentation/constants/app_webp.dart';
import 'package:cifraclub/presentation/widgets/remote_image.dart';
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeHeader extends StatefulWidget implements PreferredSizeWidget {
  final User? user;
  final bool isPro;
  final VoidCallback openLogin;
  final VoidCallback openProfile;
  final double height;
  const HomeHeader(
      {super.key,
      required this.height,
      this.user,
      required this.openLogin,
      required this.openProfile,
      required this.isPro});

  @override
  State<HomeHeader> createState() => _HomeHeaderState();

  @override
  Size get preferredSize => Size.fromHeight(height);
}

class _HomeHeaderState extends State<HomeHeader> {
  @override
  Widget build(BuildContext context) {
    return CosmosAppBar(
      toolbarHeight: widget.height,
      automaticallyImplyLeading: false,
      title: Image.asset(
        widget.isPro ? AppWebp.logoCifraClubPro : AppWebp.logoCifraClub,
      ),
      actions: [
        if (widget.user == null)
          TextButton(
            onPressed: widget.openLogin,
            child: Text(
              context.text.login,
              style: context.typography.subtitle5.copyWith(fontWeight: FontWeight.bold),
            ),
          )
        else
          Center(
            child: Padding(
              padding: EdgeInsets.only(right: context.appDimensionScheme.rightMaginProfileIcon),
              child: InkWell(
                key: const Key("Open profile"),
                onTap: widget.openProfile,
                child: RemoteImage(
                  imageUrl: widget.user?.avatarUrl,
                  // coverage:ignore-start
                  imageBuilder: (image, imageProvider) => Container(
                    height: 56,
                    width: 56,
                    padding: const EdgeInsets.all(14.0),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: imageProvider,
                        ),
                      ),
                    ),
                  ),
                  // coverage:ignore-end
                  placeholder: Container(
                    height: 56,
                    width: 56,
                    padding: const EdgeInsets.all(14.0),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: SvgPicture.asset(AppSvgs.profilePlaceholderIcon),
                  ),
                ),
              ),
            ),
          )
      ],
    );
  }
}
