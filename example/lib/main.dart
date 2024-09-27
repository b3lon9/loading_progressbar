import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_logcat/flutter_logcat.dart';
import 'package:loading_progressbar/loading_progressbar.dart';

void main() {
  Log.configure(visible: kDebugMode, tag: "Neander");

  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightGreen),
      useMaterial3: true,
    ),
    home: const MyHomePage(title: 'Flutter LoadingProgressbar Demo'),
  ));
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final LoadingProgressbarController controller = LoadingProgressbarController();
  int count = 5;
  bool isProgressTextVisible = false;

  @override
  void initState() {
    super.initState();

    controller
      ..addEventListener((event, visible, progress) {
      Log.i("addEventListener.. event:$event, visible:$visible, progress:$progress");
      },)
      ..addAnimatedEndListener((visible, progress) {
        Log.d("addAnimatedEndListener.. visible:$visible, progress:$progress");
      },);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingProgressbar(
      progressbar: (context, progress) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              Visibility(
                visible: isProgressTextVisible,
                child: Text("$progress%",
                  style: DefaultTextStyle.of(context).style.copyWith(
                    color: Colors.black,
                    fontSize: 24.0,
                    decorationThickness: 0.0
                  ),
                ),
              )
            ],
          ),
        );
      },
      controller: controller,
      transitionDuration: const Duration(seconds: 1),
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Home Screen',
                style: TextStyle(
                  fontSize: 36.0,
                ),
              ),
              Text(count.toString(),
                style: const TextStyle(
                  fontSize: 24.0
                ),
              )
            ],
          ),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                heroTag: null,
                onPressed: () {
                  Log.d("LoadingProgressbar show()");
                  controller.show();
                },
                tooltip: 'Increment',
                child: const Icon(Icons.visibility),
              ),
              const SizedBox(height: 12.0,),
              FloatingActionButton(
                heroTag: null,
                onPressed: () {
                  Log.d("LoadingProgressbar hide() after 5 seconds");
                  controller.show();
                  if (count <= 0) {
                    count = 6;
                  }

                  Timer.periodic(const Duration(seconds: 1), (timer) {
                    if (count <= 0) {
                      timer.cancel();
                      controller.hide();
                    } else {
                      setState(() {
                        count--;
                      });
                    }
                  },);

                },
                tooltip: 'Increment',
                child: const Icon(Icons.visibility_off),
              ),
              const SizedBox(height: 12.0,),
              FloatingActionButton(
                heroTag: null,
                onPressed: () {
                  controller.show();
                  isProgressTextVisible = true;
                  Log.d("LoadingProgressbar increment setProgress(count--)");
                  Timer.periodic(const Duration(milliseconds: 250), (timer) {
                    if (controller.getProgress() >= 100) {
                      timer.cancel();
                      controller.hide();
                      isProgressTextVisible = false;
                    } else {
                      controller.setProgress(timer.tick);
                    }
                  },);
                },
                tooltip: 'Increment',
                child: const Icon(Icons.trending_up_outlined),
              ),
            ],
          ),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
