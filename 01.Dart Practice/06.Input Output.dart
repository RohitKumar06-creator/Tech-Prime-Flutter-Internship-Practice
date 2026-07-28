// Input Output in Dart
import 'dart:io';

void main() {
  stdout.write("Enter Your Name: ");
  String? name = stdin.readLineSync();

  stdout.write("Enter Your Age: ");
  int? age = int.parse(stdin.readLineSync()!);

  stdout.write("Enter Your Height in centimeters: ");
  double? height = double.parse(stdin.readLineSync()!);

  stdout.write("Enter Your Weight in kilograms: ");
  double? weight = double.parse(stdin.readLineSync()!);

  double bmi = (weight * 10000) / (height * height);

  String getBMICategory(double bmi) {
  if (bmi < 18.5) {
    return "Underweight";
  } else if (bmi >= 18.5 && bmi < 25) {
    return "Normal Weight";
  } else if (bmi >= 25 && bmi < 30) {
    return "Overweight";
  } else {
    return "Obese";
  }
}

  print("======= User Information ======== ");
  print("Name        : $name");
  print("Age         : $age");
  print("Height      : $height cm");
  print("Weight      : $weight kg");
  print("BMI         : ${bmi.toStringAsFixed(2)}");
  print("BMI Category: ${getBMICategory(bmi)}");
}
