// Loops In Dart
import 'dart:io';
/*
There are three types of loops in Dart: 
1. For Loop: Used to execute a block of code a specific number of times.
2. While Loop: Used to execute a block of code as long as a specified condition is true.
3. Do-While Loop: Used to execute a block of code at least once, and then continue executing it as long as a specified condition is true.
*/

// printing table of a specific number using a for loop
void main() {
  stdout.write("Enter the number whose table you want to print: ");
  int? number = int.parse(stdin.readLineSync()!);

  print("Table of $number:");
  for (int i = 1; i <= 10; i++) {
    print("$number x $i = ${number * i}");
  }

  // printing table of a specific number using a while loop
  stdout.write("\nEnter the number whose table you want to print using while loop: ");
  int? numberWhile = int.parse(stdin.readLineSync()!);
  int j = 1;
  print("Table of $numberWhile (using while loop):");
  while (j <= 10) {
    print("$numberWhile x $j = ${numberWhile * j}");
    j++;
  }

  // positive number check using do-while loop
  int k;
  do {
    stdout.write("\nEnter a positive number: ");
    k = int.parse(stdin.readLineSync()!);
    if (k < 0) {
      print("Please enter a positive number.");
    }
  } while (k < 0);
  // This marks the end of loop practice
}
