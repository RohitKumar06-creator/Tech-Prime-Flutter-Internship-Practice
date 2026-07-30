// Generics in Dart

void main() {
  /*
  What are Generics?
  Generics allow us to write reusable code
  that works with different data types.
  Instead of writing separate classes for
  int
  String
  double

  we can write one generic class.
  Generic Syntax

  <T>
  T stands for Type.
  */

  // ================= Generic List =================

  List<String> names = ["Ali", "Rohit", "Ahmed"];
  List<int> marks = [80, 90, 95];
  print(names);
  print(marks);
  print("");

  // ================= Generic Class =================
  Box<String> nameBox = Box<String>();
  nameBox.value = "Flutter";
  print(nameBox.value);
  Box<int> numberBox = Box<int>();
  numberBox.value = 100;
  print(numberBox.value);
}

// Generic Class

class Box<T> {

  T? value;
}

/*
Useful Notes
Generics
- Used to write reusable code.
- Works with different data types.

Generic Syntax
<T>
T = Type
Example
Box<String>
Box<int>
List<String>
List<int>

Benefits
Code Reuse
Type Safety
Less Duplicate Code
*/