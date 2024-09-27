import 'package:flutter/material.dart';
import '/src/protocols/visible_control_protocol.dart';

class VisibleControlNotifier extends ValueNotifier<bool> implements VisibleControlProtocol {
  VisibleControlNotifier(super.value);

  @override
  bool get isShowing => value;

  @override
  void hide() {
    value = false;
  }

  @override
  void show() {
    value = true;
  }
}