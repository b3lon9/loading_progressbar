import 'package:flutter/material.dart';
import 'package:loading_progressbar/src/protocols/progress_level_protocol.dart';
import 'package:loading_progressbar/src/protocols/visible_control_protocol.dart';
import 'package:loading_progressbar/src/providers/progress_level_notifier.dart';
import 'package:loading_progressbar/src/providers/visible_control_notifier.dart';

class LoadingProgressbar extends StatefulWidget {
  const LoadingProgressbar({
    super.key,
    required this.progressbar,
    required this.controller,
    this.alignment = Alignment.center,
    this.barrierColor = Colors.black54,
    this.barrierDismissible = true,
    this.transitionDuration = const Duration(seconds: 0),
    required this.child,
  });

  final Widget Function(BuildContext context, int progress) progressbar;
  /// Control all about LoadingProgressbar Widget's state.
  final LoadingProgressbarController controller;
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
  State<LoadingProgressbar> createState() => _LoadingProgressbarState();
}

class _LoadingProgressbarState extends State<LoadingProgressbar> {
  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        widget.child,
        ValueListenableBuilder(
          valueListenable: widget.controller._visibleControlNotifier,
          builder: (context, visible, child) => AnimatedOpacity(
            opacity: visible ? 1.0 : 0.0,
            duration: widget.transitionDuration,
            child: Visibility(
              visible: visible,
              child: GestureDetector(
                onTap: widget.barrierDismissible ? null : () { /* Block LoadingProgressbar Widget */ },
                child: Stack(
                  children: [
                    Center(
                      child: Container(
                        color: widget.barrierColor,
                      ),
                    ),
                    Align(
                      alignment: widget.alignment,
                      child: ValueListenableBuilder(
                        valueListenable: widget.controller._progressLevelNotifier,
                        builder: (context, progress, child) {
                          return widget.progressbar(context, progress);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class LoadingProgressbarController implements VisibleControlProtocol, ProgressLevelProtocol {
  /// Progressbar Widget INVISIBLE mode would be progress level smaller than [_minValue].
  ///
  /// Progressbar Widget INVISIBLE mode would be progress level bigger than [_maxValue].
  // int _minValue, _maxValue;

  late final ProgressLevelNotifier _progressLevelNotifier;
  late final VisibleControlNotifier _visibleControlNotifier;

  /// Constructor
  LoadingProgressbarController()
    //:
    // _minValue = minValue,
    // _maxValue = maxValue
  {
    this._progressLevelNotifier = ProgressLevelNotifier(0);
    this._visibleControlNotifier = VisibleControlNotifier(false);
  }


  @override
  bool get isShowing => _visibleControlNotifier.isShowing;

  @override
  void hide() {
    _visibleControlNotifier.hide();
  }

  @override
  void show() {
    _visibleControlNotifier.show();
  }

  @override
  int getProgress() {
    return _progressLevelNotifier.value;
  }

  @override
  void setProgress(int progress) {
    _progressLevelNotifier.setProgress(progress);
  }
}