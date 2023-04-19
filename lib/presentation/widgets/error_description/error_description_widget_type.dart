import 'package:cifraclub/extensions/build_context.dart';
import 'package:flutter/material.dart';

enum ErrorDescriptionWidgetType {
  connection(),
  server();

  String getTitle(BuildContext context) {
    switch (this) {
      case connection:
        return context.text.connectionErrorTitle;
      case server:
        return context.text.serverErrorTitle;
    }
  }

  String getDescription(BuildContext context) {
    switch (this) {
      case connection:
        return context.text.connectionErrorDescription;
      case server:
        return context.text.serverErrorDescription;
    }
  }

  String getButtonText(BuildContext context) {
    switch (this) {
      case connection:
        return context.text.reload;
      case server:
        return context.text.tryAgain;
    }
  }
}
