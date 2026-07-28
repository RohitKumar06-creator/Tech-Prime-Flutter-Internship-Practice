// String Manipulation

void main() {
  // ================= String Manipulation =================

  /*
  String
  What is a String?
  A String is a sequence of characters used to store text.

  Example:
  "Hello"
  "Flutter"
  "Rohit"
  */

  // Syntax
  String name = "Rohit";

  print(name);

  // Length
  print("\nLength:");
  print(name.length);

  // Convert to Uppercase
  print("\nUppercase:");
  print(name.toUpperCase());

  // Convert to Lowercase
  print("\nLowercase:");
  print(name.toLowerCase());

  // Trim Spaces
  String text = "   Hello Flutter   ";

  print("\nOriginal Text:");
  print(text);

  print("\nTrimmed Text:");
  print(text.trim());

  // Replace Text
  String sentence = "I love Java";

  print("\nReplace:");
  print(sentence.replaceAll("Java", "Dart"));

  // Contains
  print("\nContains:");
  print(sentence.contains("love"));
  print(sentence.contains("Python"));

  // Starts With
  print("\nStarts With:");
  print(sentence.startsWith("I"));

  // Ends With
  print("\nEnds With:");
  print(sentence.endsWith("Java"));

  // Split String into List
  String fruits = "Apple,Banana,Orange";

  List<String> fruitList = fruits.split(",");

  print("\nSplit:");
  print(fruitList);

  // Join List into String
  String joined = fruitList.join(" - ");

  print("\nJoin:");
  print(joined);

  // Substring
  String framework = "Flutter";

  print("\nSubstring:");
  print(framework.substring(0, 4));

  // String Interpolation
  String studentName = "Ali";
  int age = 22;

  print("\nString Interpolation:");
  print("My name is $studentName and I am $age years old.");

  // Expression Interpolation
  int a = 10;
  int b = 20;

  print("Sum = ${a + b}");

  // Loop Through Characters
  print("\nCharacters in '$framework':");

  for (int i = 0; i < framework.length; i++) {
    print(framework[i]);
  }

  /*
  Useful String Methods

  length
  toUpperCase()
  toLowerCase()
  trim()
  replaceAll()
  contains()
  startsWith()
  endsWith()
  split()
  join()
  substring()
  */
}