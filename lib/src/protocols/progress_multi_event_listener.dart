import '/src/loading_progressbar_event.dart';

typedef MultiLoadingProgressbarEventFunction = Function(
    int index, LoadingProgressbarEvent event, bool visible, int progress);
typedef MultiLoadingProgressbarAnimatedEndEventFunction = Function(
    int index, bool visible, int progress);

abstract class ProgressMultiEventListener {
  void addEventListener(MultiLoadingProgressbarEventFunction eventListener);
  void addAnimatedEndListener(
      MultiLoadingProgressbarAnimatedEndEventFunction eventListener);
  void removeEventListener(MultiLoadingProgressbarEventFunction eventListener);
  void removeAnimatedEndEventListener(
      MultiLoadingProgressbarAnimatedEndEventFunction eventListener);
}
