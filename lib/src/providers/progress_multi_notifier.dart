import 'package:flutter/cupertino.dart';

/// For MultiLoadingProgressbar Index
class ProgressMultiNotifier extends ValueNotifier<int> {
  ProgressMultiNotifier(super.value) : this._defaultIndex = value;

  /// Default Index
  /// If you don't define index in show() function.
  ///
  /// [defaultIndex] used to it.
  int _defaultIndex;

  /// Multi Progressbar Total Count
  int multiCount = 0;

  /// Again Default Value.
  void normalize() {
    value = _defaultIndex;
  }
}
