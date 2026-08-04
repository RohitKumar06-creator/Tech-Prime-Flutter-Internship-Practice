// Stream:
// A Stream is used to handle multiple values over time.
// Unlike Future (one value), Stream can provide many values.
// Used in Firebase, chat apps, live updates, etc.

void main() async {


  print("Stream Started");


  await for (int number in numberStream()) {

    print(number);

  }


  print("Stream Ended");

}


// Creating Stream

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

Stream

- Provides multiple values asynchronously.
- Keeps listening for new data.


Future vs Stream


Future

- Returns one value.
- Example: API response.


Stream

- Returns multiple values.
- Example: Messages, Firebase updates.


async*

- Used to create a Stream function.


yield

- Sends a value from Stream.


await for

- Used to receive Stream values one by one.

Example:

await for (var data in stream) {

}

*/