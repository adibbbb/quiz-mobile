enum MyState { initial, loading, loaded, failed }

extension MyStateExtension on MyState {
  bool get isInitial => this == MyState.initial;
  bool get isLoading => this == MyState.loading;
  bool get isLoaded => this == MyState.loaded;
  bool get isFailed => this == MyState.failed;
  bool get isFirstTry =>
      (this == MyState.initial) ||
      (this == MyState.loading); // cuma tambahan buat persingkat penulisan

  MyState get loading => MyState.loading;
  MyState get loaded => MyState.loaded;
  MyState get initial => MyState.initial;
  MyState get failed => MyState.failed;
}
