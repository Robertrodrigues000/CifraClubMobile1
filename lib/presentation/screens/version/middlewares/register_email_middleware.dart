import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/shared/use_cases/validate_email.dart';
import 'package:cifraclub/domain/song/use_cases/send_email_to_blocked_song.dart';
import 'package:cifraclub/domain/songbook/models/email_options_result.dart';
import 'package:cifraclub/presentation/screens/version/middlewares/version_middleware.dart';
import 'package:cifraclub/presentation/screens/version/version_action.dart';
import 'package:cifraclub/presentation/screens/version/version_state.dart';
import 'package:injectable/injectable.dart';
import 'package:typed_result/typed_result.dart';

@injectable
class RegisterEmailMiddleware extends VersionMiddleware {
  final ValidateEmail _validateEmail;
  final SendEmailToBlockedSong _sendEmailToBlockedSong;

  RegisterEmailMiddleware(this._validateEmail, this._sendEmailToBlockedSong);

  @override
  void onAction(VersionAction action, VersionState state, ActionEmitter addAction) async {
    switch (action) {
      case OnChangeEmail():
        final isValid = _validateEmail(action.email);
        addAction(OnValidateEmail(isValid: isValid));
      case OnSendEmail():
        final result = await _sendEmailToBlockedSong(action.email, state.version!.completePath);
        result.when(
          success: (value) {
            addAction(OnEmailValidate(result: SendEmailSuccess()));
          },
          failure: (error) {
            switch (error) {
              case ConnectionError():
                addAction(OnEmailValidate(result: SendEmailNetworkError()));
              case ServerError():
                if (error.statusCode == 409) {
                  addAction(OnEmailValidate(result: SendEmailConflictError()));
                  break;
                }
                addAction(OnEmailValidate(result: SendEmailError()));
              default:
            }
          },
        );
      default:
        break;
    }
  }
}
