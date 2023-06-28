import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/dialogs/list_operation_dialogs/list_operation_dialog.dart';
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';

class InputDialog extends StatefulWidget {
  const InputDialog({Key? key, required this.isNewList, this.listName, required this.onSave}) : super(key: key);
  final bool isNewList;
  final String? listName;
  final Function(BuildContext, String) onSave;

  static Future<T?> show<T>({
    required BuildContext context,
    required bool isNewList,
    String? listName,
    required Function(BuildContext, String) onSave,
  }) {
    return showDialog(
        context: context,
        builder: (context) {
          return ScaffoldMessenger(
            child: Stack(alignment: Alignment.center, children: [
              GestureDetector(
                onTap: () => close(context),
                behavior: HitTestBehavior.translucent,
                child: const Scaffold(
                  backgroundColor: Colors.transparent,
                ),
              ),
              InputDialog(
                isNewList: isNewList,
                listName: listName,
                onSave: onSave,
              ),
            ]),
          );
        });
  }

  static void close(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
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
      onSecondButtonTap: () => Navigator.pop(context),
      onFirstButtonTap: _textEditingController.text.isEmpty || _textEditingController.text.trim().isEmpty
          ? null
          : () {
              widget.onSave(context, _textEditingController.text);
            },
    );
  }
}
