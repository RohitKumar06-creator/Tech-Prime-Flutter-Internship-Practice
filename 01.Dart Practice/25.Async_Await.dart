// Async/Await:
// async allows a function to perform asynchronous tasks.
// await pauses the function until a Future completes.

void main() async {

  print("Fetching Data...");


  String user = await fetchUser();


  print(user);


  print("Data Loaded");

}


// Async Function

Future<String> fetchUser() async {

  await Future.delayed(
    Duration(seconds: 3)
  );


  return "User: Rohit";

}