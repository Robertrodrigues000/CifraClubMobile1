import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/screens/songbook/lists/widgets/list_operation_dialogs/list_operation_dialog.dart';
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';

class InputDialog extends StatefulWidget {
  const InputDialog({Key? key, required this.isNewList, this.listName, required this.onTap}) : super(key: key);
  final bool isNewList;
  final String? listName;
  final Function(String) onTap;

  static Future<T?> show<T>(
      {required BuildContext context, required bool isNewList, String? listName, required Function(String) onTap}) {
    return showDialog(
        context: context,
        builder: (context) {
          return InputDialog(
            isNewList: isNewList,
            listName: listName,
            onTap: onTap,
          );
        });
  }

  @override
  State<InputDialog> createState() => _InputDialogState();
}

class _InputDialogState extends State<InputDialog> {
  late final TextEditingController _textEditingController = TextEditingController(text: widget.listName);
  late final FocusNode focusNode = FocusNode();

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
    return ListOperationDialog(
      title: widget.isNewList ? context.text.createList : context.text.renameList,
      description: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: CosmosInputField(
          labelText: context.text.inputDialogLabel,
          hintText: context.text.inputDialogHint,
          focusNode: focusNode,
          textEditingController: _textEditingController,
          maxLength: 50,
          maxLines: 2,
          minLines: 1,
          textInputType: TextInputType.text,
        ),
      ),
      secondButtonText: context.text.cancel,
      firstButtonText: widget.isNewList ? context.text.create : context.text.save,
      // coverage:ignore-start
      onSecondButtonTap: () => Navigator.pop(context),
      // coverage:ignore-end
      onFirstButtonTap: _textEditingController.text.isEmpty
          ? null
          : () {
              widget.onTap(_textEditingController.text);
              Navigator.pop(context);
            },
    );
  }
}
