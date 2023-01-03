extension StringExtension on String {
  String capitalize() {
    var result = this[0].toUpperCase();
    for (int i = 1; i < this.length; i++) {
      (this[i - 1] == " ") ? result = result + this[i].toUpperCase() : result = result + this[i];
    }
    return result;
  }
}
