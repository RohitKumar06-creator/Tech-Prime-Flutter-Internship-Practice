// Variables in Dart

/*
Dart is a statically typed language, which means that you must declare the type of a variable when you create it. However, Dart also has a feature called type inference, which allows the compiler to automatically determine the type of a variable based on the value assigned to it.

dart has these types of variables:
1. int: Used to store integer values.
2. double: Used to store floating-point values.
3. String: Used to store text values.
4. bool: Used to store boolean values (true or false).
*/

// For example, here are some variable declarations in Dart:
void main() {
  // 1. Storing a name
  String name = "Rohit Kumar";
  print("My name is $name");

  // 2. Storing an age
  int age = 20;
  print("My age is $age");

  // 3. Storing a height
  double height = 6.2;
  print("My height is $height");

  // 4. Storing a boolean value
  bool isStudent = true;
  print("Am I a student? $isStudent");

  // Dynamic variable: A dynamic variable can hold values of any type, and its type can change at runtime. You can declare a dynamic variable using the dynamic keyword.
  dynamic myVariable = "Hello";
  print("Dynamic variable value: $myVariable");
  myVariable = 42;
  print("Dynamic variable value after change: $myVariable");

  // Instead of manually declaring the type of a variable, you can use the var keyword to let the compiler infer the type based on the assigned value. However, once a variable is assigned a value, its type cannot be changed.
  var myVar = "Hello, Dart!";
  print("Inferred variable value: $myVar");
  // but myVar can't be changed

  /*
1. Exercise 1
Create variables for:
Name
Age
City
CGPA
Print each one.
*/
  print("\nExercise 1:");
  print("===== Student Profile =====");
  String Name = "Rohit Kumar";
  int Age = 20;
  String City = "Islamabad";
  double CGPA = 3.5;
  print("Name: $Name");
  print("Age : $Age");
  print("City: $City");
  print("CGPA: $CGPA");
  print("===========================");
/*
Exercise 2
Create an integer variable salary with the value 50000.
Increase it by 10000 and print the updated salary.
*/
  print("\nExercise 2:");
  int salary = 50000;
  print("Initial salary: $salary");
  salary += 10000;
  print("Updated salary: $salary");

/*
Exercise 3 (Challenge)
Create variables representing yourself:

Name
University
Degree
Semester
Internship
Favourite Programming Language
CGPA

Print them in a neatly formatted "Developer Profile"
*/ 
print("\nExercise 3:");
  print("===== Developer Profile =====");
  String devName = "Rohit Kumar";
  String university = "Allama Iqbal Open University";
  String degree = "Bachelor of Science in Computer Science";
  int semester = 6;
  String internship = "TechPrime Flutter Internship";
  String favLanguage = "Dart";
  double devCGPA = 3.56;

  print("Name      : $devName");
  print("University: $university");
  print("Degree    : $degree");
  print("Semester  : $semester");
  print("Internship: $internship");
  print("Favourite Programming Language: $favLanguage");
  print("CGPA      : $devCGPA");
  print("===============================");
}
