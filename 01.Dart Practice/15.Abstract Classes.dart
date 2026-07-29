void main() {
  /*
  What is an Abstract Class?
  An Abstract Class is a class that CANNOT
  be used to create objects.

  It is only used as a blueprint for other classes.
  Keyword: abstract
  Real Life Example
  Animal
  Every animal makes a sound.
  But an Animal itself doesn't have one
  specific sound.

  Dog -> Bark
  Cat -> Meow

  So Animal only says:
  "Every animal must have a sound."
  */
  
  // Animal animal = Animal();
  // ❌ Error
  // Cannot create object of an abstract class.

  Dog dog = Dog();
  Cat cat = Cat();

  dog.sound();
  cat.sound();

  dog.eat();
  cat.eat();

  /*
  Output

  Dog says: Bark
  Dog is eating.

  Cat says: Meow
  Cat is eating.
  */
}

// abstract class
abstract class Animal {
  // Abstract Method
  // No body
  void sound();
  // Normal Method
  void eat() {
    print("Animal is eating.");
  }
}

// Child classes
class Dog extends Animal {

  @override
  void sound() {
    print("Dog says: Bark");
  }
}

class Cat extends Animal {

  @override
  void sound() {
    print("Cat says: Meow");
  }
}

/*
=====================================================
Useful Notes

Abstract Class

- Cannot create objects.
- Used as a blueprint.
- Can contain both:

✔ Abstract Methods
✔ Normal Methods

Abstract Method

void sound();

No implementation.

Child classes MUST implement it.

Keyword

abstract

Override

@override

Used when implementing a parent class method.

Wrong

Animal animal = Animal();

Correct

Dog dog = Dog();

Cat cat = Cat();

=====================================================
*/