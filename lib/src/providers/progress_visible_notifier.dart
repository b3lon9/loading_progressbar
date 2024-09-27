import 'package:flutter/material.dart';
import '/src/protocols/progress_visible_protocol.dart';

class ProgressVisibleNotifier extends ValueNotifier<bool>
    implements ProgressVisibleProtocol {
  ProgressVisibleNotifier(super.value);

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
