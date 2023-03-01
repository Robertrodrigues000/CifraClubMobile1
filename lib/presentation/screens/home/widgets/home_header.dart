import 'package:cifraclub/domain/user/models/user.dart';
import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/constants/app_webp.dart';
import 'package:cifraclub/presentation/widgets/remote_image.dart';
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';

class HomeHeader extends StatefulWidget implements PreferredSizeWidget {
  final User? user;
  final bool isPro;
  final VoidCallback openLogin;
  final VoidCallback openProfile;
  const HomeHeader(
      {super.key, required this.user, required this.openLogin, required this.openProfile, required this.isPro});

  static const preferredHomeHeaderSize = Size.fromHeight(56);

  @override
  State<HomeHeader> createState() => _HomeHeaderState();

  @override
  Size get preferredSize => HomeHeader.preferredHomeHeaderSize;
}

class _HomeHeaderState extends State<HomeHeader> {
  @override
  Widget build(BuildContext context) {
    return CosmosAppBar(
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
              style: CosmosTypography.of(context).subtitle5.copyWith(fontWeight: FontWeight.bold),
            ),
          )
        else
          InkWell(
            onTap: widget.openProfile,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: ClipOval(
                child: RemoteImage(imageUrl: widget.user?.avatarUrl ?? ""),
              ),
            ),
          )
      ],
    );
  }
}
