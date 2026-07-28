// Collections in Dart
void main() {
  // List: Ordered collection of items: like a shopping list

  // Syntax

  List<String> fruits = ["Apple", "Banana", "Orange"];
  print(fruits[0]);

  // Changing an element
  fruits[1] = "Mango";
  print(fruits[1]);

  // Adding an item
  fruits.add("Pineapple");
  // this will add the element at the end of the list

  // Adding multiple items
  fruits.addAll(["Kiwi", "Peach"]);

  // Removing an item
  fruits.remove("Banana"); // we can also pass index of the item

  // Print all elemets in fruits list
  print("Fruits List\n");
  for (var i in fruits) {
    print(i);
  }

  // =========== Maps =============
  /* 
  Map
What is a Map?
A Map stores data in key-value pairs.
Example:
Name : Ali
Age  : 22
City : Lahore
Instead of using numbers as indexes, Maps use keys.
  */

  // Syntax
  Map<String, dynamic> student = {"name": "Ali", "age": 22, "city": "Lahore"};

  // Accessing an element
  print(student["name"]);

  // Adding a value
  student["email"] = "ali@gmail.com";

  // Updating a value
  student["age"] = 25;

  // Removing a value
  student.remove("city");

  // Print Entire map
  print(student);

  // Loop through a map
  student.forEach((key, value) {
    print("$key : $value");
  });

  /*
  Useful properties
  student.keys
student.values
student.length
student.containsKey("age")
student.containsValue("Ali")
  */

  // =========== Sets =============
  /*  
  Set
What is a Set?
A Set is a collection that stores unique values only.
Imagine a classroom attendance sheet.
Ali
Ahmed
Ali
Sara
Ahmed
A Set automatically removes duplicates.
Result
Ali
Ahmed
Sara
  */

  // Syntax
  Set<String> names = {"Ali", "Ahmed", "Sara"};

  // Adding values
  names.add("Usman");

  // Duplicate values
  names.add("Ali");

  // remove
  names.remove("Sara");

  // Looping
  for (String name in names) {
    print(name);
  }

  // Convert list to set
  List<int> numbers = [1, 2, 2, 3, 4, 4];

Set<int> unique = numbers.toSet();

print(unique);
}
