// Static Members in Dart

void main() {
  /*
  What are Static Members?
  Static members belong to the CLASS,
  not to an OBJECT.
  This means you can access them
  without creating an object.
  Keyword: static
  */
  // ================= Static Variable =================
  print("Company Name:");
  print(Employee.company);
  print("");

  // ================= Static Method =================

  int sum = Calculator.add(10, 20);

  print("Addition:");
  print(sum);

  print("");

  // ================= Non-Static Members =================

  Employee employee = Employee();

  employee.name = "Rohit";

  print(employee.name);
}

// ================= Employee Class =================

class Employee {

  // Non-static Variable
  String name = "";

  // Static Variable
  static String company = "OpenAI";
}

// ================= Calculator Class =================

class Calculator {

  // Static Method
  static int add(int a, int b) {
    return a + b;
  }

  static int subtract(int a, int b) {
    return a - b;
  }
}

/*=====================================================
Useful Notes
Static

- Belongs to the class.
- Shared by all objects.
- No object is needed.
Keyword: static

Static Variable
static String company = "OpenAI";
Access
Employee.company
Static Method
static int add(int a, int b) {
  return a + b;
}

Access
Calculator.add(10, 20);

Non-Static Members
Need an object.
Employee employee = Employee();
employee.name = "Rohit";

Difference
Static
Belongs to Class
Shared
No Object Required

Non-Static
Belongs to Object
Each Object Has Its Own Copy
Object Required
*/