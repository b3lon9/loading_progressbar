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
  ///
  /// ```dart
  /// progressbar: (context, progress) {
  ///   return Column(
  ///     children: [
  ///       CircularProgressIndicator(),
  ///       Text("$progress%"),
  ///     ]
  ///   }
  /// ```
  final Widget Function(BuildContext context, int progress) progressbar;

  /// Control all about LoadingProgressbar Widget's state.
  final LoadingProgressbarController controller;

  /// Progressbar Widget alignment.
  ///
  /// Default value os [Alignment.center]
  final AlignmentGeometry alignment;

  /// Progressbar Widget's behind color(background).
  ///
  /// Default value is [Colors.black54]
  final Color barrierColor;

  /// If [barrierDismissible] was 'true',
  /// It could be dismissible on touch LoadingProgressbar widget.
  ///
  /// If [barrierDismissible] was 'false',
  /// It couldn't be dismissible on touch LoadingProgressbar widget.
  ///
  /// <br/>
  ///
  /// Default value is 'true'
  final bool barrierDismissible;

  /// Transition Build to LoadingProgressbar Widget. Animated duration.
  ///
  /// If you don't want transition, you have to define [Duration(seconds: 0)]
  ///
  /// Default value is [Duration(milliseconds: 650]).
  final Duration transitionDuration;

  /// User Custom Widget Base.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: "LoadingProgressbar",
      tooltip: "Simple Changed 'child' and 'progressbar' each other.",
      child: Stack(
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
                onTap: barrierDismissible ? () => controller.hide() : null,
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
      ),
    );
  }
}

/// LoadingProgressbarController can control the LoadingProgressbar Widget.
///
/// [show] - Visible LoadingProgressbar's '[progressbar]' Widget. <br/>
/// [hide] - InVisible LoadingProgressbar's '[progressbar]' Widget. <br/>
/// [isShowing] - If you want current Progressbar visible state. <br/>
/// [setProgress] - Send progress level to '[progressbar]' Widget. <br/>
class LoadingProgressbarController
    implements
        ProgressVisibleProtocol,
        ProgressLevelProtocol,
        ProgressEventListener {
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
  ///
  /// If the AnimatedOpacity widget is removed from the widget tree
  /// or its state is changed, causing the widget to rebuild during
  /// the disappearance animation, the animation may stop, and onEnd
  /// might not be called. This is especially true if the screen transitions
  /// or the widget disappears before the animation completes.
  void _animateEnd(bool isVisible) {
    if (_animatedEndEventListener != null) {
      _animatedEndEventListener!(isVisible, getProgress());
    }
  }

  void dispose() {
    _isWidgetVisible = false;
    _progressVisibleNotifier.dispose();
    _progressLevelNotifier.dispose();
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
      _eventListener!(
          LoadingProgressbarEvent.progress, isShowing, getProgress());
    }
  }

  /// You can check current LoadingProgressbar's state. <br/>
  ///
  /// [status] - [LoadingProgressbarEvent] type "hide, show, progress" implemented function event. <br/>
  /// [visible] - '[progressbar]' Widget visible state. <br/>
  /// [progress] - LoadingProgressbar's progress gauge(level). <br/>
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

  /// This Event called when executed to animate end after [show], [hide] functions.
  @override
  void addAnimatedEndListener(
      LoadingProgressbarAnimatedEndEventFunction eventListener) {
    _animatedEndEventListener = eventListener;
  }

  @override
  void removeAnimatedEndEventListener(
      LoadingProgressbarAnimatedEndEventFunction eventListener) {
    if (_animatedEndEventListener.hashCode == eventListener.hashCode) {
      _animatedEndEventListener = null;
    }
  }
}
