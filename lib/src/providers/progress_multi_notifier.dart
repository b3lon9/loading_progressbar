import 'package:flutter/cupertino.dart';

/// For MultiLoadingProgressbar Index
class ProgressMultiNotifier extends ValueNotifier<int> {
  ProgressMultiNotifier(
    super.value, {
    required int itemCount,
  }) : this._defaultIndex = value {
    _multiCount = itemCount;
  }

  /// Default Index
  /// If you don't define index in show() function.
  ///
  /// [defaultIndex] used to it.
  int _defaultIndex;

  /// Multi Progressbar Total Count
  int _multiCount = 0;

  /// Again Default Value.
  void normalize() {
    value = _defaultIndex;
  }

  /// Getter [_multiCount] - Total
  int get itemCount => _multiCount;
}
