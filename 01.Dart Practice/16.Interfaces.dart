// Interfaces in Dart

void main() {
  /*
  What is an Interface?

  An Interface is a contract.

  It tells a class:
  "You MUST implement these methods."

  In Dart, every class can act as an interface.

  Keyword

  implements
  */

  Dog dog = Dog();

  dog.sound();
  dog.eat();

  /*
  Output

  Dog is barking...
  Dog is eating...
  */
}

// Interface

class Animal {
  void sound() {}

  void eat() {}
}

// Implementing Class

class Dog implements Animal {

  @override
  void sound() {
    print("Dog is barking...");
  }

  @override
  void eat() {
    print("Dog is eating...");
  }
}

/*
=====================================================
Useful Notes

Interface

- A contract.
- Defines what methods a class must have.

Keyword

implements

Example

class Dog implements Animal

Difference from extends

extends
✔ Inherits code.

implements
✔ Does NOT inherit code.
✔ Must write every method again.

Every class in Dart can be used as an interface.

=====================================================
*/