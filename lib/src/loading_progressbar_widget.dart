import 'package:flutter/material.dart';
import '/src/loading_progressbar_event.dart';
import '/src/protocols/progress_event_listener.dart';
import '/src/protocols/progress_level_protocol.dart';
import '/src/protocols/progress_visible_protocol.dart';
import '/src/providers/progress_level_notifier.dart';
import '/src/providers/progress_visible_notifier.dart';

class LoadingProgressbar extends StatelessWidget {
  const LoadingProgressbar({
    super.key,
    required this.progressbar,
    required this.controller,
    this.alignment = Alignment.center,
    this.barrierColor = Colors.black54,
    this.barrierDismissible = true,
    this.transitionDuration = const Duration(milliseconds: 650),
    required this.child,
  });

  /// Your custom Progressbar Widget.
  final Widget Function(BuildContext context, int progress) progressbar;
  /// Control all about LoadingProgressbar Widget's state.
  final LoadingProgressbarController controller;
  /// Progressbar Widget alignment.
  ///
  /// Default value os [Alignment.center]
  final AlignmentGeometry alignment;
  final Color barrierColor;
  /// If [barrierDismissible] was 'true',
  /// It could be dismissible on touch LoadingProgressbar widget.
  ///
  /// If [barrierDismissible] was 'false',
  /// It couldn't be dismissible on touch LoadingProgressbar widget.
  final bool barrierDismissible;
  /// Transition Build to LoadingProgressbar Widget. Animated duration.
  ///
  /// Default value [Duration(seconds: 0].
  final Duration transitionDuration;
  /// User Custom Widget
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        child,
        StatefulBuilder(
          builder: (context, setState) => ValueListenableBuilder(
            valueListenable: controller._progressVisibleNotifier,
            builder: (context, visible, child) => AnimatedOpacity(
              opacity: visible ? 1.0 : 0.0,
              duration: transitionDuration,
              onEnd: () {
                if (!visible) {
                  setState(() {
                    controller._isWidgetVisible = false;
                  });
                }
                controller._animateEnd(visible);
              },
              child: Visibility(
                visible: controller._isWidgetVisible,
                child: child!,
              ),
            ),
            child: GestureDetector(
              onTap: barrierDismissible
                ? () => controller.hide()
                : null,
              child: Stack(
                children: [
                  Center(
                    child: Container(
                      color: barrierColor,
                    ),
                  ),
                  Align(
                    alignment: alignment,
                    child: ValueListenableBuilder(
                      valueListenable: controller._progressLevelNotifier,
                      builder: (context, progress, child) {
                        return progressbar(context, progress);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}

class LoadingProgressbarController implements ProgressVisibleProtocol, ProgressLevelProtocol, ProgressEventListener {
  /// Progressbar Widget INVISIBLE mode would be progress level smaller than [_minValue].
  ///
  /// Progressbar Widget INVISIBLE mode would be progress level bigger than [_maxValue].
  // int _minValue, _maxValue;

  late final ProgressLevelNotifier _progressLevelNotifier;
  late final ProgressVisibleNotifier _progressVisibleNotifier;

  /// [_isWidgetVisible] visible value changed after Animate End
  bool _isWidgetVisible = false;

  LoadingProgressbarEventFunction? _eventListener;
  LoadingProgressbarAnimatedEndEventFunction? _animatedEndEventListener;

  /// Constructor
  LoadingProgressbarController()
    //:
    // _minValue = minValue,
    // _maxValue = maxValue
  {
    this._progressLevelNotifier = ProgressLevelNotifier(0);
    this._progressVisibleNotifier = ProgressVisibleNotifier(false);
  }


  /// Called at the end of AnimatedOpacity's onEnd() function.
  void _animateEnd(bool isVisible) {
    if (_animatedEndEventListener != null) {
      _animatedEndEventListener!(isVisible, getProgress());
    }
  }

  @override
  bool get isShowing => _progressVisibleNotifier.isShowing;

  @override
  void hide() {
    _progressVisibleNotifier.hide();
    if (_eventListener != null) {
      _eventListener!(LoadingProgressbarEvent.hide, false, getProgress());
    }
  }

  @override
  void show() {
    _isWidgetVisible = true;
    _progressVisibleNotifier.show();
    if (_eventListener != null) {
      _eventListener!(LoadingProgressbarEvent.show, true, getProgress());
    }
  }

  @override
  int getProgress() {
    return _progressLevelNotifier.value;
  }

  @override
  void setProgress(int progress) {
    _progressLevelNotifier.setProgress(progress);
    if (_eventListener != null) {
      _eventListener!(LoadingProgressbarEvent.progress, isShowing, getProgress());
    }
  }

  @override
  void addEventListener(LoadingProgressbarEventFunction eventListener) {
    _eventListener = eventListener;
  }

  @override
  void removeEventListener(LoadingProgressbarEventFunction eventListener) {
    if (eventListener.hashCode == eventListener.hashCode) {
      this._eventListener = null;
    }
  }

  @override
  void addAnimatedEndListener(LoadingProgressbarAnimatedEndEventFunction eventListener) {
    _animatedEndEventListener = eventListener;
  }

  @override
  void removeAnimatedEndEventListener(LoadingProgressbarAnimatedEndEventFunction eventListener) {
    if (_animatedEndEventListener.hashCode == eventListener.hashCode) {
      _animatedEndEventListener = null;
    }
  }
}