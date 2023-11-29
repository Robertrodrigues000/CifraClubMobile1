import 'package:cifraclub/domain/preferences/use_cases/get_font_size_preference.dart';
import 'package:cifraclub/domain/preferences/use_cases/set_font_size_preference.dart';
import 'package:cifraclub/domain/section/models/section.dart';
import 'package:cifraclub/domain/section/models/tab_section.dart';
import 'package:cifraclub/presentation/screens/version/middlewares/version_middleware.dart';
import 'package:cifraclub/presentation/screens/version/version_action.dart';
import 'package:cifraclub/presentation/screens/version/version_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class FontSizeMiddleware extends VersionMiddleware {
  final GetFontSizePreference _getFontSizePreference;
  final SetFontSizePreference _setFontSizePreference;

  FontSizeMiddleware(this._getFontSizePreference, this._setFontSizePreference);

  @override
  void onAction(VersionAction action, VersionState state, ActionEmitter addAction) {
    switch (action) {
      case OnContentParsed():
        _setFontSize(_getFontSizePreference(), action, state, addAction);
      case OnFontSizeDecrease():
        _setFontSize(_getFontSizePreference() - 2, action, state, addAction);
      case OnFontSizeIncrease():
        _setFontSize(_getFontSizePreference() + 2, action, state, addAction);
      case OnFontSizeRestore():
        _setFontSize(GetFontSizePreference.defaultValue, action, state, addAction);
      default:
        break;
    }
  }

  void _setFontSize(int fontSize, VersionAction action, VersionState state, ActionEmitter addAction) {
    if (action is! OnContentParsed) {
      if (fontSize == _getFontSizePreference() ||
          fontSize > GetFontSizePreference.maxValue ||
          fontSize < GetFontSizePreference.minValue) {
        return;
      }
    }

    _setFontSizePreference(fontSize);

    List<Section> sections = action is OnContentParsed ? action.sections : state.sections;
    List<Section> filteredSections = state.isTabsVisible ? sections : sections.where((e) => e is! TabSection).toList();

    addAction(
      OnReadyToProcessContent(
        sections: filteredSections,
        fontSize: fontSize,
        isFontDecreaseEnabled: fontSize > GetFontSizePreference.minValue,
        isFontIncreaseEnabled: fontSize < GetFontSizePreference.maxValue,
      ),
    );
  }
}
