extension IntExtension on int {
  void forEach(void Function(int index) function) {
    for (var i = 0; i < this; i++) {
      function(i);
    }
  }
}
