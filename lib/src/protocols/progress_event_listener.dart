import '/src/loading_progressbar_event.dart';

typedef LoadingProgressbarEventFunction = Function(
    LoadingProgressbarEvent event, bool visible, int progress);
typedef LoadingProgressbarAnimatedEndEventFunction = Function(
    bool visible, int progress);

abstract class ProgressEventListener {
  void addEventListener(LoadingProgressbarEventFunction eventListener);
  void addAnimatedEndListener(
      LoadingProgressbarAnimatedEndEventFunction eventListener);
  void removeEventListener(LoadingProgressbarEventFunction eventListener);
  void removeAnimatedEndEventListener(
      LoadingProgressbarAnimatedEndEventFunction eventListener);
}
