interface class ProgressMultiVisibleProtocol {
  bool get isShowing => false;
  void show({int? index}) =>
      UnimplementedError("show function has not been implemented");
  void hide() => UnimplementedError("hide function has not been implemented");
  int get index => 0;
}
