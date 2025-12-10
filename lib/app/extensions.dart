import '../commons.dart';

extension BuildContextExt on BuildContext {
  double get fullHeight => MediaQuery.of(this).size.height;
  double get fullWidth => MediaQuery.of(this).size.width;
  void unfocusKeyboard() {
    var f = FocusScope.of(this);
    if (!f.hasPrimaryFocus) {
      f.unfocus();
    }
  }
}
