// Classes & Objects in Dart

/*
Class
  -----
  A Class is a blueprint or template used to create objects.

  Real Life Example:
  Imagine a blueprint of a house.
  The blueprint is NOT a real house.
  It only describes how a house should look.

  Similarly,
  A class describes what an object should have
  (properties and methods).

  Object
  ------
  An Object is an actual instance of a class.

  Blueprint  --->  House
  Class      --->  Object
  */


void main() {
  // Object
  // An object is an actual instance of a class.
  Car car1 = Car();
  print(car1.brand);
  car1.drive();

  // Creating Objects

  Student student1 = Student();
  Student student2 = Student();

  // Accessing Properties

  print(student1.name);
  print(student1.age);

  // Modifying Properties

  student1.name = "Rohit";
  student1.age = 22;

  print(student1.name);
  print(student1.age);

  // Calling Methods

  student1.study();
  student1.sleep();

  print("");

  // Second Object

  student2.name = "Ali";
  student2.age = 20;

  print(student2.name);
  print(student2.age);

  student2.study();
  student2.sleep();
}


class Car {
  String brand = "Toyota";
  String color = "Black";

  void drive() {
    print("Car is Driving");
  }
}

class Student {
  // Properties (Variables)

  String name = "Unknown";
  int age = 0;

  // Methods (Functions)

  void study() {
    print("$name is studying...");
  }

  void sleep() {
    print("$name is sleeping...");
  }
}

