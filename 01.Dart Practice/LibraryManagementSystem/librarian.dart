import 'person.dart';

mixin Logger {
  void log(String message) {
    print("[LOG] $message");
  }
}

abstract interface class ManageLibrary {
  void manageLibrary();
}

class Librarian extends Person
    with Logger
    implements ManageLibrary {

  Librarian(
    super.name,
    super.id,
  );

  @override
  void manageLibrary() {
    log("$name is managing the library.");
  }

  @override
  void displayInfo() {
    print("======= Librarian =======");
    print("ID   : $id");
    print("Name : $name");
  }
}