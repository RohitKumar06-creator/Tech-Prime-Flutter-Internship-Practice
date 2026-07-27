// Functions in Dart
import 'dart:io';

/*
Functions are a block of code that can be called and executed when needed. They help in organizing code, making it reusable, and improving readability.
*/

// Greeting A User
// Declaring a function
String greetUser(String name) {
  stdout.write("Choose a Language: \n1.English\n2.French\n3.Italian\n4.Spanish\n");
  String? language = stdin.readLineSync();
  if (language == "1") {
    return ("Hello $name");
  } else if (language == "2") {
    return ("Salut $name");
  } else if (language == "3") {
    return ("Ciao $name");
  } else if (language == "4") {
    return ("Hola $name");
  } else {
    return "Invalid Input";
  }
}

void main() {
  stdout.write("Enter your Name: ");
  String? name = stdin.readLineSync()!;
  // Calling the function
  print("${greetUser(name)}!");
}
