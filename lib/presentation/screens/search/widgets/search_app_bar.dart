// coverage:ignore-file
import 'package:cifraclub/extensions/build_context.dart';
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';

class SearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onTapClear;
  final Function(String) onChanged;
  final String hintText;
  final TextEditingController textEditingController;
  final double searchInputHeight;
  final bool isScrolledUnder;
  final FocusNode? focusNode;

  const SearchAppBar({
    super.key,
    this.onTapClear,
    required this.onChanged,
    required this.hintText,
    required this.textEditingController,
    required this.searchInputHeight,
    required this.isScrolledUnder,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      scrolledUnderElevation: 0.0,
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
                  focusNode: focusNode,
                  textEditingController: textEditingController,
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
