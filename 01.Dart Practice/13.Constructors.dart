// Constructors in Dart

void main() {
  /*
  What is a Constructor?
  A Constructor is a special method that is automatically
  called when an object is created.

  It is mainly used to initialize (give values to)
  the properties of an object.
  Syntax
  ClassName(parameter1, parameter2);
  */

  // Creating Objects

  Student student1 = Student("Rohit", 22);
  Student student2 = Student("Ali", 20);

  // Accessing Properties

  print(student1.name);
  print(student1.age);

  print("");

  print(student2.name);
  print(student2.age);

  print("");

  // Calling Methods

  student1.study();
  student2.study();
}

// Class

class Student {
  // Properties

  String name;
  int age;

  /*
  Constructor

  Student(this.name, this.age);

  "this" refers to the current object's properties.

  Equivalent to:

  Student(String name, int age) {
      this.name = name;
      this.age = age;
  }
  */

  Student(this.name, this.age);

  // Methods

  void study() {
    print("$name is studying...");
  }

  void sleep() {
    print("$name is sleeping...");
  }
}

/*
=====================================================
Useful Notes

Constructor
- Special method.
- Same name as the class.
- Has no return type.
- Automatically runs when an object is created.
- Used to initialize object properties.

Creating an Object

Student student = Student("Rohit", 22);

Constructor Syntax

Student(this.name, this.age);

Without Shorthand

Student(String name, int age) {
  this.name = name;
  this.age = age;
}

"this"
- Refers to the current object's variables.

Benefits of Constructors

✔ Initialize data immediately
✔ Avoid writing extra assignment code
✔ Makes objects ready to use after creation

=====================================================
*/