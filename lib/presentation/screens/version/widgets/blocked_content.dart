// coverage:ignore-file
import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/widgets/cifraclub_button/button_type.dart';
import 'package:cifraclub/presentation/widgets/cifraclub_button/cifraclub_button.dart';
import 'package:cosmos/cosmos.dart';
import 'package:flutter/widgets.dart';

class BlockedContent extends StatefulWidget {
  final String? artistName;
  final bool isValidEmail;
  final bool? isConflictError;
  final Function(String) onChangeEmail;
  final Function(String) onTapSendEmail;

  const BlockedContent({
    super.key,
    required this.artistName,
    required this.isValidEmail,
    required this.onChangeEmail,
    required this.onTapSendEmail,
    required this.isConflictError,
  });

  @override
  State<BlockedContent> createState() => _BlockedContentState();
}

class _BlockedContentState extends State<BlockedContent> {
  late final _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _textEditingController.addListener(_updateText);
  }

  void _updateText() {
    setState(() {
      _textEditingController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.appDimensionScheme.screenMargin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.text.blockedVersionTitle,
            style: context.typography.body5.copyWith(color: context.colors.textSecondary),
          ),
          SizedBox.fromSize(size: const Size.fromHeight(8)),
          Text(
            context.text.blockedVersionDescription(widget.artistName ?? ""),
            style: context.typography.body10,
          ),
          SizedBox.fromSize(size: const Size.fromHeight(24)),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 548),
            child: CosmosInputField(
              labelText: context.text.yourEmail,
              hintText: context.text.yourEmail,
              onChanged: widget.onChangeEmail,
              maxLines: 1,
              textEditingController: _textEditingController,
              errorText: widget.isConflictError == true ? context.text.emailAlreadyRegistered : null,
              textInputType: TextInputType.emailAddress,
            ),
          ),
          SizedBox.fromSize(size: const Size.fromHeight(16)),
          CifraClubButton(
            type: ButtonType.solidOrange,
            width: context.appDimensionScheme.registerEmailButtonWidth,
            onPressed: widget.isValidEmail ? () => widget.onTapSendEmail(_textEditingController.text) : null,
            child: Text(
              context.text.registerEmail,
            ),
          )
        ],
      ),
    );
  }
}
