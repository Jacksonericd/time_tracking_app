extension StringExtension on String {
  String toTwoDigits() {
    if (length == 1) {
      return "0$this";
    }
    return this;
  }
}
