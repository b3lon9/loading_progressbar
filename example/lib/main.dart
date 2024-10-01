import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_logcat/flutter_logcat.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:loading_progressbar/loading_progressbar.dart';

void main() {
  Log.configure(visible: kDebugMode, tag: "Neander");

  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
      useMaterial3: true,
    ),
    home: Builder(
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: const Text('Flutter LoadingProgressbar Demo'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const LoadingProgressbarExample(),));
                },
                child: const Text("LoadingProgressbar Widget Example"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const MultiLoadingProgressbarExample(),));
                },
                child: const Text("MultiLoadingProgressbar Widget Example"),
              )
            ],
          ),
        ),
      ),
    ),
  ));
}

/// Single
///
/// [LoadingProgressbar] Widget Example :)
class LoadingProgressbarExample extends StatefulWidget {
  const LoadingProgressbarExample({super.key});

  @override
  State<LoadingProgressbarExample> createState() => _LoadingProgressbarExampleState();
}

class _LoadingProgressbarExampleState extends State<LoadingProgressbarExample> {
  final LoadingProgressbarController controller = LoadingProgressbarController();

  @override
  void initState() {
    super.initState();

    controller
      ..addEventListener((event, visible, progress) {
        Log.i("addEventListener.. event:$event, visible:$visible, progress:$progress");
      },)
      ..addAnimatedEndListener((visible, progress) {
        Log.d("addAnimatedEndListener.. visible:$visible, progress:$progress");
        if (visible) {
          controller.hide();
        }
      },);
  }

  @override
  void dispose() {
    controller.dispose();
    // ..removeEventListener(eventListener)
    // ..removeAnimatedEndEventListener(eventListener)

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingProgressbar(
      controller: controller,
      progressbar: (context, progress) {
        return const CircularProgressIndicator();
      },
      transitionDuration: const Duration(seconds: 2),
      child: Scaffold(
        backgroundColor: Colors.blueGrey,
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('LoadingProgressbar \nSingle Example',
                style: TextStyle(
                  color: Colors.white60,
                  fontSize: 28.0,
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          heroTag: null,
          onPressed: () {
            Log.d("LoadingProgressbar show()");
            controller.show();
          },
          tooltip: 'Default LoadingProgressbar',
          child: const Icon(Icons.play_arrow_outlined),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}


class MultiLoadingProgressbarExample extends StatefulWidget {
  const MultiLoadingProgressbarExample({super.key});

  @override
  State<MultiLoadingProgressbarExample> createState() => _MultiLoadingProgressbarExampleState();
}

class _MultiLoadingProgressbarExampleState extends State<MultiLoadingProgressbarExample> {
  final MultiLoadingProgressbarController controller = MultiLoadingProgressbarController(itemCount: 3);

  @override
  void initState() {
    super.initState();

    controller
      ..addEventListener((index, event, visible, progress) {
        Log.i("addEventListener.. index:$index, event:$event, visible:$visible, progress:$progress");

      },)
      ..addAnimatedEndListener((index, visible, progress) {
        Log.d("addAnimatedEndListener.. index:$index, visible:$visible, progress:$progress");
        if (visible) {
          controller.hide();
        }
      },);
  }

  @override
  void dispose() {
    controller.dispose();
    // ..removeEventListener(eventListener)
    // ..removeAnimatedEndEventListener(eventListener)

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiLoadingProgressbar(
      controller: controller,
      progressbar: (context, progress) => [
        LoadingAnimationWidget.staggeredDotsWave(color: Colors.blueGrey, size: 36.0),
        LoadingAnimationWidget.hexagonDots(color: Colors.blueGrey, size: 36.0),
        LoadingAnimationWidget.beat(color: Colors.blueGrey, size: 36.0)
      ],
      transitionDuration: const Duration(seconds: 2),
      child: Scaffold(
        backgroundColor: Colors.blueGrey,
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('LoadingProgressbar\nMulti Example',
                style: TextStyle(
                  color: Colors.white60,
                  fontSize: 28.0,
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              heroTag: null,
              onPressed: () {
                Log.d("MultiLoadingProgressbar show()");
                controller.show();
              },
              tooltip: 'MultiLoadingProgressbar',
              child: const Text("Wave"),
            ),
            const SizedBox(height: 9.0,),
            FloatingActionButton(
              heroTag: null,
              onPressed: () {
                Log.d("MultiLoadingProgressbar show(index: 1)");
                controller.show(index: 1);
              },
              tooltip: 'MultiLoadingProgressbar',
              child: const Text("Dots"),
            ),
            const SizedBox(height: 9.0,),
            FloatingActionButton(
              heroTag: null,
              onPressed: () {
                Log.d("MultiLoadingProgressbar show(index: 2)");
                controller.show(index: 2);
              },
              tooltip: 'MultiLoadingProgressbar',
              child: const Text("Beat"),
            ),
          ],
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
