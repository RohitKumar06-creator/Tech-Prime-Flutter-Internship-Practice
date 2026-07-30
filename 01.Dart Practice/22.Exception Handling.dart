// Exception Handling in Dart

void main() {
  /*
  What is an Exception?
  An Exception is an error that occurs while
  the program is running.

  Instead of crashing the program,
  we can handle the error using

  try
  catch

  Keywords
  try
  catch
  finally
  throw
  */

  print("Program Started\n");

  // ================= TRY & CATCH =================

  try {
    int result = 10 ~/ 0;

    print(result);
  } catch (e) {
    print("An Error Occurred");
    print(e);
  }

  print("");

  // ================= FINALLY =================

  try {
    int result = 20 ~/ 2;

    print(result);
  } catch (e) {
    print(e);
  } finally {
    print("This block always executes.");
  }

  print("");

  // ================= THROW =================
  try {
    checkAge(15);
  } catch (e) {
    print(e);
  }
}

// Function
void checkAge(int age) {
  if (age < 18) {
    throw Exception("Age must be 18 or above.");
  }
  print("Access Granted");
}

/*
Useful Notes

Exception
- Runtime error.

Keywords

try
catch
finally
throw

try

Contains the code that may produce an error.

catch

Runs if an exception occurs.

Example

try {
  int result = 10 ~/ 0;
}
catch(e){
  print(e);
}

finally

Always executes,
whether an error occurs or not.

Useful for
Closing files
Closing database connections
Cleaning resources

throw
Used to create your own exception.

Example
throw Exception("Invalid Age");
*/