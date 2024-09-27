import 'package:flutter/cupertino.dart';
import 'package:loading_progressbar/src/protocols/progress_level_protocol.dart';

class ProgressLevelNotifier extends ValueNotifier<int> implements ProgressLevelProtocol {
  ProgressLevelNotifier(super.value);

  @override
  int getProgress() {
    return value;
  }

  @override
  void setProgress(int progress) {
    value = progress;
    notifyListeners();
  }
}