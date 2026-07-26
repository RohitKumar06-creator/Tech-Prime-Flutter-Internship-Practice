// Operators in Dart
import 'dart:io';
/*
There are several types of operators in Dart, including:
1. Arithmetic Operators: Used for mathematical operations like addition, subtraction, multiplication, division, etc
2. Relational Operators: Used to compare values, such as equal to, not equal to, greater than, less than, etc.
3. Logical Operators: Used to combine multiple boolean expressions, such as AND, OR, NOT
*/

// For example, here are some examples of operators in Dart:
void main() {
  // 1. Arithmetic Operators
  int a = 10;
  int b = 5;
  print("Addition: ${a + b}"); // Addition
  print("Subtraction: ${a - b}"); // Subtraction
  print("Multiplication: ${a * b}"); // Multiplication
  print("Division: ${a / b}"); // Division
  print("Integer Division: ${a ~/ b}"); // Integer Division
  print("Modulus: ${a % b}"); // Modulus

  // 2. Relational Operators
  print("Is a equal to b? ${a == b}"); // Equal to
  print("Is a not equal to b? ${a != b}"); // Not equal to
  print("Is a greater than b? ${a > b}"); // Greater than
  print("Is a less than b? ${a < b}"); // Less than
  print(
    "Is a greater than or equal to b? ${a >= b}",
  ); // Greater than or equal to
  print("Is a less than or equal to b? ${a <= b}"); // Less than or equal to

  // 3. Logical Operators
  bool x = true;
  bool y = false;
  print("x AND y: ${x && y}"); // AND operator
  // print("x OR y: ${x || y}"); // OR operator
  print("NOT x: ${!x}"); // NOT operator

  // Calculator using operators
  int num1;
  int num2;
  print("Enter first number: ");
  num1 = int.parse(stdin.readLineSync()!);
  print("Enter second number: ");
  num2 = int.parse(stdin.readLineSync()!);
  print("Enter operator (+, -, *, /): ");
  print("Addition : ${num1 + num2}");
  print("Subtraction : ${num1 - num2}");
  print("Multiplication : ${num1 * num2}");
  print("Division : ${num1 / num2}");
}
