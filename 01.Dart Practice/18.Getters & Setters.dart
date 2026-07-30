// Getters & Setters in Dart

void main() {
  /*
  What are Getters & Setters?

  Getter: A Getter is used to READ the value of a private variable.
  Setter: A Setter is used to UPDATE the value of a private variable.
  
  Why use them?
Data Hiding (Encapsulation), Validation, Controlled Access

  Keywords: get, set
  */

  Student student = Student();

  // Using Setter
  student.name = "Rohit";
  student.age = 22;

  // Using Getter
  print(student.name);
  print(student.age);

  print("");

  // Validation Example

  student.age = -10;

  print(student.age);
}

// Class

class Student {
  // Private Variables
  // "_" makes a variable private within the library.

  String _name = "";
  int _age = 0;

  // ================= GETTERS =================
  String get name {
    return _name;
  }

  int get age {
    return _age;
  }
  // ================= SETTERS =================
  set name(String value) {
    _name = value;
  }

  set age(int value) {
    if (value >= 0) {
      _age = value;
    } else {
      print("Invalid Age");
    }
  }
}

/*
Useful Notes
Getter: Used to access (read) a private variable.
Syntax
String get name {
  return _name;
}
Setter: Used to update (write) a private variable.
Syntax:
set name(String value) {
  _name = value;
}
Private Variable
String _name;
The "_" makes the variable private.
Why Use Getters & Setters?
Data Hiding, Validation, Better Control, Encapsulation
Example
student.name = "Rohit";   // Setter
print(student.name);      // Getter

*/
