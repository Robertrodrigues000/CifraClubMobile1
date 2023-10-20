sealed class FloatingFooterBarAction {}

class FloatingFooterBarDidTapOnListen implements FloatingFooterBarAction {}

class FloatingFooterBarDidTapOnAutoscroll implements FloatingFooterBarAction {}

class FloatingFooterBarDidTapOnOptions implements FloatingFooterBarAction {}

class FloatingFooterBarDidTapOnVideo implements FloatingFooterBarAction {}

class FloatingFooterBarDidTapOnResetFontSize implements FloatingFooterBarAction {}

class FloatingFooterBarDidTapOnIncreaseFontSize implements FloatingFooterBarAction {}

class FloatingFooterBarDidTapOnDecreaseFontSize implements FloatingFooterBarAction {}

class FloatingFooterBarDidTapOnConfirmFontSize implements FloatingFooterBarAction {}

class FloatingFooterBarDidTapOnCloseAutoScroll implements FloatingFooterBarAction {}

class FloatingFooterBarDidTapOnPlayAutoScroll implements FloatingFooterBarAction {}

class FloatingFooterBarDidSelectAutoScrollSpeed implements FloatingFooterBarAction {
  final double speedFactor;

  FloatingFooterBarDidSelectAutoScrollSpeed({required this.speedFactor});
}
