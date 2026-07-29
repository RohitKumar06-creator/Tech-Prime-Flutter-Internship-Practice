// Mixins in Dart

void main() {
  /*
  What is a Mixin?
  A Mixin is used to share methods
  between multiple classes.

  Instead of copying code,
  multiple classes can reuse it.

  Keyword: with
  */

  Bird bird = Bird();
  bird.fly();

  Airplane airplane = Airplane();
  airplane.fly();

}

// Mixin

mixin Fly {

  void fly() {
    print("Flying...");
  }
}

// Classes 

class Bird with Fly {}

class Airplane with Fly {}

/*
=====================================================
Useful Notes

Mixin

- Used to share code.
- Avoids duplicate methods.

Keyword

with

Example

class Bird with Fly

class Airplane with Fly

Benefits

✔ Code Reuse
✔ Cleaner Code
✔ Multiple classes can use the same methods

=====================================================
*/