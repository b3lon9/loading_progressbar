import 'package:flutter/cupertino.dart';

/// For MultiLoadingProgressbar Index
class ProgressMultiNotifier extends ValueNotifier<int> {
  ProgressMultiNotifier(super.value);

  /// Multi Progressbar Total Count
  int multiCount = 0;
}
