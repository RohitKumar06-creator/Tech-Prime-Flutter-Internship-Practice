// Optional & Named Parameters in Dart

/*
Optional Parameters:
- Use [].
- They can be omitted when calling the function.

Named Parameters:
- Use {}.
- Passed using parameter names.
*/

// Optional Parameter
void introduce(String name, [int age = 18]) {
  print("Name: $name");
  print("Age: $age");
}

// Named Parameter
void student({
  required String name,
  required int age,
  String city = "Islamabad",
}) {
  print("Name: $name");
  print("Age: $age");
  print("City: $city");
}

void main() {
  print("=== Optional Parameters ===");
  introduce("Rohit");
  introduce("Ali", 21);

  print("\n=== Named Parameters ===");
  student(name: "Rohit", age: 21);
  student(name: "Ali", age: 22, city: "Lahore");
}