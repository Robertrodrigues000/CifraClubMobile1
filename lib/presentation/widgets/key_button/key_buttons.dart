// coverage:ignore-file
import 'package:cifraclub/domain/version/models/musical_scale.dart';
import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/widgets/key_button/key_button.dart';
import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart';

class KeyButtons extends StatefulWidget {
  final MusicalScale musicalScale;
  final String originalKey;
  final String selectedKey;
  final Function(String) onKeySelected;

  const KeyButtons({
    super.key,
    required this.musicalScale,
    required this.originalKey,
    required this.selectedKey,
    required this.onKeySelected,
  });

  @override
  State<KeyButtons> createState() => _KeyButtonsState();
}

class _KeyButtonsState extends State<KeyButtons> {
  late String selectedKey;

  @override
  void initState() {
    super.initState();
    selectedKey = widget.selectedKey;
  }

  KeyButtonState getKeyButtonState(String key, String originalKey, String selectedKey) {
    if (key == selectedKey) {
      return KeyButtonState.selected;
    }
    if (key == originalKey) {
      return KeyButtonState.original;
    }
    return KeyButtonState.unselected;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      var numberOfButtonsPerRow = 6;
      var rows = widget.musicalScale.notes.slices(numberOfButtonsPerRow);
      var numberOfSpacers = numberOfButtonsPerRow - 1;
      var width = constraints.maxWidth;
      var buttonWidth = (width -
              2 * context.appDimensionScheme.screenMargin -
              numberOfSpacers * context.appDimensionScheme.keyButtonPadding) /
          numberOfButtonsPerRow;
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: rows.first
                .map((key) => KeyButton(
                    size: buttonWidth,
                    text: key,
                    keyButtonState: getKeyButtonState(key, widget.originalKey, selectedKey),
                    onTap: (key) {
                      setState(() {
                        selectedKey = key;
                      });
                      widget.onKeySelected(key);
                    }))
                .toList(),
          ),
          const SizedBox(
            height: 12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: rows.last
                .map((key) => KeyButton(
                    size: buttonWidth,
                    text: key,
                    keyButtonState: getKeyButtonState(key, widget.originalKey, selectedKey),
                    onTap: (key) {
                      setState(() {
                        selectedKey = key;
                      });
                      widget.onKeySelected(key);
                    }))
                .toList(),
          ),
        ],
      );
    });
  }
}
