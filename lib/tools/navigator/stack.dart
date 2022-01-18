class TStack<T> {
  final _obj = <T>[];

  void push(T t) {
    _obj.add(t);
  }

  T? pop([T? t = null]) {
    if (_obj.isEmpty) {
      return null;
    }

    if (t != null) {
      if (_obj.remove(t)) {
      } else {
        t = null;
      }
    } else {
      t = _obj.removeLast();
    }
    return t;
  }

  List<T> get obj => List.unmodifiable(_obj);

  T? get last => _obj.isNotEmpty ? _obj.last : null;

  void clear() {
    _obj.clear();
  }
  bool get isEmpty{
    return _obj.isEmpty;
  }

  bool get isNotEmpty{
    return !isEmpty;
  }

}

void main() {
  TStack<int> stack = TStack();
  stack.push(0);
  stack.push(1);
  stack.push(2);
  print(stack.pop());
}
