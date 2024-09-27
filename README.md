# LoadingProgressbar Widget
[![Pub Version](https://img.shields.io/pub/v/loading_progressbar?color=blue)](https://pub.dev/packages/loading_progressbar)

You can pull out the widget you defined in the progress bar whenever you want.<br/>

<img src="https://github.com/user-attachments/assets/163f6763-026f-43d9-9d99-5ad2faa06abb" alt="GIF" width="300">

<br/>

## Getting started 🌱

#### Add
```text
flutter pub add loading_progressbar
```

#### Import
```dart
import 'package:loading_progressbar/loading_progressbar.dart';
```

<br/>

## Example 🎈
```dart
final LoadingProgressbarController controller = LoadingProgressbarController();

  @override
  Widget build(BuildContext context) {
    return LoadingProgressbar(
      controller: controller,
      progressbar: (context, progress) {
        return CircularProgressIndicator(value: progress / 100);
      },
      child: Scaffold(
        body: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                // ViSIBLE 'progressbar' Widget
                controller.show();
              },
              child: Text("show"),
            ),
            ElevatedButton(
              onPressed: () {
                // INVISIBLE 'progressbar' Widget
                controller.hide();
              },
              child: Text("hide"),
            ),
          ]
        ),
      )
    )
  }
```

<br/>

## Usage 🚀
|  parameter           |  required            |  type                          | default                       |
|----------------------|----------------------|--------------------------------|-------------------------------|
|  progressbar         |  :heavy_check_mark:  |  Widget                        |                               |
|  controller          |  :heavy_check_mark:  |  LoadingProgressbarController  |                               |
|  alignment           |  :x:                 |  AlignmentGeometry             |  Alignment.center             |
|  barrierColor        |  :x:                 |  Color                         |  Colors.black54               |
|  barrierDismissible  |  :x:                 |  bool                          |  true                         |
|  transitionDuration  |  :x:                 |  Duration                      |  Duration(milliseconds: 650)  |
|  child               |  :heavy_check_mark:  |  Widget                        |                               |

#### Listen Event

- Function Events (show, hide, change progress)
- AnimatedEnd Event : It indicates that the animation has completed after using the show or hide function.

```dart
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
      },);
  }
```

#### LoadingProgressbarController's the point Functions

- `show()`
- `hide()`
- `isShowing`
- `setProgress(int progress)`
- `getProgress()`
