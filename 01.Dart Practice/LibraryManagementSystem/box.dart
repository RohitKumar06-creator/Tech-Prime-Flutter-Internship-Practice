class Box<T> {
  T? value;

  void store(T item) {
    value = item;
  }

  T? getItem() {
    return value;
  }
}