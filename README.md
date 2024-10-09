# LoadingProgressbar Widget
[![Pub Version](https://img.shields.io/pub/v/loading_progressbar?color=blue)](https://pub.dev/packages/loading_progressbar)

You can pull out the widget you defined in the progress bar whenever you want.<br/>
You just need to wrap it with LoadingProgressbar!<br/>

<img src="https://github.com/user-attachments/assets/163f6763-026f-43d9-9d99-5ad2faa06abb" alt="GIF" width="300">

<br/>
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

## Update 🎁
I have newly added the MultiLoadingProgressbar. <br/>
You can set up multiple progress bars and call them whenever needed. <br/>
I referenced the [loading_animation_widget](https://pub.dev/packages/loading_animation_widget) package.

<img src="https://github.com/user-attachments/assets/5bd3b5b4-f737-48f7-ba4c-902c1af9acd0" alt="GIF" width="320"/>

```dart
  final MultiLoadingProgressbarController controller = MultiLoadingProgressbarController(itemCount: 3);

  @override
  Widget build(BuildContext context) {
    return MultiLoadingProgressbar(
      controller: controller,
      progressbar: (context, progress) => [
        LoadingAnimationWidget.staggeredDotsWave(color: Colors.blueGrey, size: 36.0),
        LoadingAnimationWidget.hexagonDots(color: Colors.blueGrey, size: 36.0),
        LoadingAnimationWidget.beat(color: Colors.blueGrey, size: 36.0)
      ],
      child: Scaffold(
        ...
```
<br/>

The index of the `progressbar` widget you want
```dart
  final MultiLoadingProgressbarController controller = MultiLoadingProgressbarController(itemCount: 3);

  ...
  onPressed: () {
    controller.show();    // Called default index
  },
  ...
  onPressed: () {
    controller.show(index: 1);
  },
  ...
  onPressed: () {
    controller.show(index: 2);
  },  
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
        
      // Not required, default values
      alignment = Alignment.center,
      barrierColor: Colors.black54,
      barrierDismissible: true,
      transitionDuration: const Duration(milliseconds: 650),
      reverseDuration: const Duration(milliseconds: 650),
        
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
| parameter          |  required            |  type                          | default                     |
|--------------------|----------------------|--------------------------------|-----------------------------|
| progressbar        |  :heavy_check_mark:  |  Widget                        |                             |
| controller         |  :heavy_check_mark:  |  LoadingProgressbarController  |                             |
| alignment          |  :x:                 |  AlignmentGeometry             | Alignment.center            |
| barrierColor       |  :x:                 |  Color                         | Colors.black54              |
| barrierDismissible |  :x:                 |  bool                          | true                        |
| transitionDuration |  :x:                 |  Duration                      | Duration(milliseconds: 650) |
| reverseDuration    |  :x:                 |  Duration                      | transitionDuration          |
| child              |  :heavy_check_mark:  |  Widget                        |                             |

<br/>

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

  @override
  void dispose() {
    controller.dispose();
    // ..removeEventListener(eventListener)
    // ..removeAnimatedEndEventListener(eventListener)

    super.dispose();
  }
```

<br/>

#### LoadingProgressbarController's the point Functions

- `show()`
- `hide()`
- `isShowing`
- `setProgress(int progress)`
- `getProgress()`
- `addEventListener(...)`
- `addAnimatedEndListener(...)`
- `clearEventListener()`
- `clearAnimatedEndEventListener()`
- `dispose()`

<br/> 
