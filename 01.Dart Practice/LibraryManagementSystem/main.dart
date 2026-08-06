import 'dart:io';

import 'library.dart';

void main() {
  Library library = Library();

  bool running = true;

  while (running) {
    print("\n========== Library Management System ==========");
    print("1. Add Book");
    print("2. Remove Book");
    print("3. View All Books");
    print("4. Search Book");
    print("5. Borrow Book");
    print("6. Return Book");
    print("7. Add Member");
    print("8. View Members");
    print("9. Exit");
    print("===============================================");

    stdout.write("Enter your choice: ");

    int? choice = int.tryParse(stdin.readLineSync() ?? "");

    switch (choice) {
      case 1:
        library.addBook();
        break;

      case 2:
        library.removeBook();
        break;

      case 3:
        library.showBooks();
        break;

      case 4:
        library.searchBook();
        break;

      case 5:
        library.borrowBook();
        break;

      case 6:
        library.returnBook();
        break;

      case 7:
        library.addMember();
        break;

      case 8:
        library.showMembers();
        break;

      case 9:
        running = false;
        print("\nThank you for using the Library Management System.");
        break;

      default:
        print("\nInvalid Choice.");
    }
  }
}