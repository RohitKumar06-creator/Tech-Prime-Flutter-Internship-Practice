void main() {
  /*
  What is Inheritance?
  Inheritance allows one class to inherit the
  properties and methods of another class.
  Parent Class (Superclass)
            ↓
      Child Class (Subclass)
  Keyword:
  extends
  Real Life Example

        Animal
           ↓
      -------------
      |           |
     Dog         Cat

  Every animal can eat.
  Dog can also bark.
  Cat can also meow.

  Instead of writing the eat() method multiple
  times, we inherit it.
  */

  // Creating Object

  Dog dog = Dog();

  // Parent Class Method

  dog.eat();

  // Child Class Method

  dog.bark();

  print("");

  Cat cat = Cat();

  cat.eat();
  cat.meow();
}

// Parent Class

class Animal {
  void eat() {
    print("Animal is eating...");
  }
}

// Child Class

class Dog extends Animal {
  void bark() {
    print("Dog is barking...");
  }
}

class Cat extends Animal {
  void meow() {
    print("Cat is meowing...");
  }
}

/*
=====================================================
Useful Notes

Inheritance
- Allows one class to reuse another class.

Keyword

extends

Parent Class
- Class whose properties and methods are inherited.

Child Class
- Class that inherits from another class.

Benefits

✔ Code Reusability
✔ Less Duplicate Code
✔ Easier Maintenance

Example

Animal
   ↓
 Dog
 Cat

Dog can use

dog.eat();

even though eat() belongs to Animal.

=====================================================
*/