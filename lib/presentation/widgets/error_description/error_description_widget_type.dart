import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/constants/app_webp.dart';
import 'package:flutter/material.dart';

enum ErrorDescriptionWidgetType {
  connection(),
  server(),
  privateList(),
  loggedOut();

  // coverage:ignore-start
  String getImageLight() {
    switch (this) {
      case connection:
      case server:
        return AppWebp.withoutConnectionLight;
      case privateList:
        return AppWebp.privateListErrorLight;
      case loggedOut:
        return AppWebp.loggedOutListErrorLight;
    }
  }

  String getImageDark() {
    switch (this) {
      case connection:
      case server:
        return AppWebp.withoutConnectionDark;
      case privateList:
        return AppWebp.privateListErrorDark;
      case loggedOut:
        return AppWebp.loggedOutListErrorDark;
    }
  }
  // coverage:ignore-end

  String getTitle(BuildContext context) {
    switch (this) {
      case connection:
        return context.text.connectionErrorTitle;
      case server:
        return context.text.serverErrorTitle;
      case privateList:
        return context.text.privateListErrorTitle;
      case loggedOut:
        return context.text.loggedOutListErrorTitle;
    }
  }

  String getDescription(BuildContext context) {
    switch (this) {
      case connection:
        return context.text.connectionErrorDescription;
      case server:
        return context.text.serverErrorDescription;
      case privateList:
        return context.text.privateListErrorDescription;
      case loggedOut:
        return context.text.loggedOutListErrorDescription;
    }
  }

  String getButtonText(BuildContext context) {
    switch (this) {
      case connection:
        return context.text.reload;
      case server:
        return context.text.tryAgain;
      case privateList:
        return context.text.privateListErrorButtonText;
      case loggedOut:
        return context.text.loggedOutListErrorButtonText;
    }
  }
}
