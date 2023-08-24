// coverage:ignore-file
import 'package:cifraclub/extensions/build_context.dart';
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';

class SearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double topSafeArea;
  final double searchInputHeight;
  final VoidCallback? onTapClear;
  final Function(String) onChanged;
  final String hintText;

  const SearchAppBar({
    super.key,
    required this.topSafeArea,
    required this.searchInputHeight,
    this.onTapClear,
    required this.onChanged,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      flexibleSpace: ScrolledUnderBuilder(builder: (context, isScrolledUnder) {
        return Container(
          color: isScrolledUnder ? context.colors.neutralSecondary : context.colors.neutralPrimary,
          padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: context.appDimensionScheme.screenMargin,
                ),
                height: searchInputHeight,
                child: CosmosSearchBar(
                  onChanged: onChanged,
                  onTapClear: onTapClear,
                  invertColorsOnScroll: true,
                  cancelText: context.text.cancel,
                  hintText: hintText,
                  labelText: hintText,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(searchInputHeight);
}
