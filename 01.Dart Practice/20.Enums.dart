// Enums in Dart

void main() {
  /*
  What is an Enum?
  An Enum (Enumeration) is a special data type
  used to define a fixed set of constant values.

  Instead of using random strings like
  "Monday"
  "Tuesday"
  "Wednesday"

  we use an enum.

  Why use Enums?

  Better Readability
  Prevents Invalid Values
  Easier to Maintain

  Keyword: enum
  */

  // Assigning an Enum Value

  Day today = Day.thursday;

  print(today);

  print("");

  // Using switch with Enum

  switch (today) {
    case Day.monday:
      print("Start of the week");
      break;

    case Day.tuesday:
      print("Second day");
      break;

    case Day.wednesday:
      print("Middle of the week");
      break;

    case Day.thursday:
      print("Almost Friday!");
      break;

    case Day.friday:
      print("Weekend is coming!");
      break;

    case Day.saturday:
      print("Weekend");
      break;

    case Day.sunday:
      print("Holiday");
      break;
  }

  print("");

  // Accessing all Enum Values

  print(Day.values);

  print("");

  // Accessing Enum Name

  print(today.name);
}

// Enums
enum Day {
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
  sunday
}

/*
Useful Notes
Enum
Represents a fixed set of constant values.

Keyword: enum

Syntax

enum Day {
  monday,
  tuesday,
  friday
}

Assign Value

Day today = Day.monday;

Access All Values

Day.values

Get Name

today.name

Why Use Enums?
Fixed Choices
Cleaner Code
No Spelling Mistakes
Easy switch Statements
*/