// Future:
// A Future represents a value that will be available later.
// It is used for asynchronous operations like API calls and Firebase.

void main() async {

  print("Program Started");


  // Calling Future using async/await

  String name = await getName();

  print(name);


  int marks = await getMarks();

  print("Marks: $marks");


  print("Program Ended");

}


// Future returning String

Future<String> getName() async {

  await Future.delayed(
    Duration(seconds: 2)
  );

  return "Rohit";

}


// Future returning Integer

Future<int> getMarks() async {

  await Future.delayed(
    Duration(seconds: 1)
  );

  return 95;

}