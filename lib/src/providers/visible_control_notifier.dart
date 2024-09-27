import 'package:flutter/cupertino.dart';
import 'package:loading_progressbar/src/protocols/visible_control_protocol.dart';

class VisibleControlNotifier extends ValueNotifier<bool> implements VisibleControlProtocol {
  VisibleControlNotifier(super.value);

  @override
  bool get isShowing => value;

  @override
  void hide() {
    value = false;
    notifyListeners();
  }

  @override
  void show() {
    value = true;
    notifyListeners();
  }
}