interface class ProgressVisibleProtocol {
  bool get isShowing => false;
  void show() => UnimplementedError("show function has not been implemented");
  void hide() => UnimplementedError("hide function has not been implemented");
}