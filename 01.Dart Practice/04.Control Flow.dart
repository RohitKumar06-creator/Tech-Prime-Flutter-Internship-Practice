// Control Flow Statements in Dart
import 'dart:io';
/*
If-else
switch-case
*/

void main() {
  stdout.write("Enter your age: ");
  String? input = stdin.readLineSync();
  int age = int.parse(input!);

  // Checking age groups
  if (age < 0) {
    print("Invalid age.");
  }
  else if (age >= 0 && age < 13) {
    print("You are a minor.");
  } else if (age >= 13 && age < 18) {
    print("You are a teenager.");
  } else if (age >= 18 && age < 65) {
    print("You are an adult.");
  } else {
    print("You are a senior citizen.");
  }

  // Switch-case example
  stdout.write("Enter a day: ");
  String? day = stdin.readLineSync();

  switch (day) {
    case "Monday":
      print("Start of the work week");
      break;
    case "Tuesday":
      print("Second day of the week");
      break;
    case "Wednesday":
      print("Midweek day");
      break;
    case "Thursday":
      print("Almost there");
      break;
    case "Friday":
      print("Last work day!");
      break;
    case "Saturday":
    case "Sunday":
      print("It's the weekend!");
      break;
    default:
      print("Not a valid day");
  }
}
