// Asynchronous Dart:
// Asynchronous programming allows tasks to run without blocking the program.
// Future handles one value, async/await waits for Future results,
// and Stream handles multiple values over time.


void main() async {

  print("Program Started\n");


  // ================= FUTURE =================


  print("Fetching User Data...");


  String user = await fetchUser();


  print(user);



  print("");



  // ================= ASYNC/AWAIT =================


  print("Calculating Marks...");


  int marks = await calculateMarks();


  print("Marks: $marks");



  print("");



  // ================= STREAM =================


  print("Receiving Numbers...");


  await for (int number in numberStream()) {

    print(number);

  }



  print("\nProgram Finished");

}



// ================= FUTURE =================


Future<String> fetchUser() async {

  await Future.delayed(
    Duration(seconds: 2)
  );


  return "User: Rohit";

}



// ================= ASYNC/AWAIT =================


Future<int> calculateMarks() async {

  await Future.delayed(
    Duration(seconds: 1)
  );


  return 95;

}



// ================= STREAM =================


Stream<int> numberStream() async* {


  for (int i = 1; i <= 5; i++) {


    await Future.delayed(
      Duration(seconds: 1)
    );


    yield i;

  }

}



/*
Useful Notes

Future

- Returns a single value in the future.
- Used for API calls, Firebase requests, etc.


async

- Makes a function asynchronous.


await

- Waits for a Future to complete.


Stream

- Returns multiple values over time.
- Used for live updates.


async*

- Creates a Stream function.


yield

- Sends values from a Stream.


Future Example:

Future<String> getData()


Stream Example:

Stream<int> getNumbers()


*/