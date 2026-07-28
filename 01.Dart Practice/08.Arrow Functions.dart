// Arrow functions in dart

// Arrow functions are the compact way of writing functions that only contains one expression

// Normal Function
String greet(String name) {
  return "Hello $name";
}

// Arrow Function
String arrowGreet(String name) => "Hello $name";

// is even number arrow function
bool isEven(int number) => number % 2 == 0;

// Length of string
int lengthOfString(String word) => word.length;

void main() {
  print(greet("Rohit"));
  print(arrowGreet("Rohit"));

  int num = 6;
  print("Is $num an even number? ${isEven(num)}");

  print("Number of characters in word 'Dart is Wonderful' are: ${lengthOfString("Dart is Wonderful")}");
}
