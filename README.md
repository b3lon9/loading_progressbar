# LoadingProgressbar Widget
[![Pub Version](https://img.shields.io/pub/v/loading_progressbar?color=blue)](https://pub.dev/packages/loading_progressbar)

Simple Management LoadingProgressbar <br/>

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
