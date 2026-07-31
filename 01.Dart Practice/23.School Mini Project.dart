// School Management System

void main() {
  try {
    Student student = Student("Rohit", 22, Grade.A);

    student.study();
    student.login();

    print("");

    print("Name : ${student.name}");
    print("Age : ${student.age}");
    print("Grade : ${student.grade.name}");

    print("");

    // Static Member
    print("School : ${School.schoolName}");

    print("");

    // Generic Class
    Box<Student> studentBox = Box<Student>();
    studentBox.value = student;

    print("Stored Student : ${studentBox.value!.name}");

    print("");

    // Exception Example
    student.age = -10;

  } catch (e) {
    print(e);
  }
}

// 
// ENUM
// 

enum Grade {
  A,
  B,
  C,
  D
}

// 
// ABSTRACT CLASS
// 

abstract class Person {

  void study();

}

// 
// INTERFACE
// 

class Login {

  void login() {}

}

// 
// MIXIN
// 

mixin Greeting {

  void greet() {
    print("Welcome to the School!");
  }

}

// 
// STATIC MEMBERS
// 

class School {

  static String schoolName = "ABC Public School";

}

// 
// INHERITANCE
// 

class Student extends Person
    with Greeting
    implements Login {

  // Private Variables

  String _name;
  int _age;

  Grade grade;

  // Constructor

  Student(this._name, this._age, this.grade);

  // Getter

  String get name => _name;

  int get age => _age;

  // Setter

  set name(String value) {
    _name = value;
  }

  set age(int value) {

    if (value < 0) {
      throw Exception("Age cannot be negative.");
    }

    _age = value;
  }

  // Abstract Method

  @override
  void study() {

    greet();

    print("$_name is studying.");
  }

  // Interface Method

  @override
  void login() {

    print("$_name logged into the system.");

  }

}

// 
// GENERIC CLASS
// 

class Box<T> {

  T? value;

}