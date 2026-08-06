import 'dart:io';

import 'book.dart';
import 'member.dart';
import 'exceptions.dart';

class Library {
  final List<Book> books = [];
  final List<Member> members = [];

  // ---------------- Add Book ----------------

  void addBook() {
    stdout.write("Title : ");
    String title = stdin.readLineSync()!;

    stdout.write("Author : ");
    String author = stdin.readLineSync()!;

    stdout.write("ISBN : ");
    String isbn = stdin.readLineSync()!;

    try {
      if (books.any((book) => book.isbn == isbn)) {
        throw DuplicateBookException();
      }

      books.add(Book(title, author, isbn));

      print("Book Added Successfully.");
      print("Books in library: ${books.length}");
    } catch (e) {
      print(e);
    }
  }

  // ---------------- Remove Book ----------------

  void removeBook() {
    stdout.write("Enter ISBN : ");

    String isbn = stdin.readLineSync()!;

    books.removeWhere((book) => book.isbn == isbn);

    print("Operation Completed.");
  }

  // ---------------- Show Books ----------------

  void showBooks() {
    if (books.isEmpty) {
      print("No Books Available.");
      return;
    }

    for (Book book in books) {
      book.displayInfo();
    }

    print("\nTotal Books : ${Book.totalBooks}");
  }

  // ---------------- Search ----------------

  void searchBook() {
    stdout.write("Enter ISBN : ");

    String isbn = stdin.readLineSync()!;

    try {
      Book book =
          books.firstWhere((book) => book.isbn == isbn);

      book.displayInfo();
    } catch (e) {
      print(BookNotFoundException());
    }
  }

  // ---------------- Borrow ----------------

  void borrowBook() {
    stdout.write("Enter ISBN : ");

    String isbn = stdin.readLineSync()!;

    try {
      Book book =
          books.firstWhere((book) => book.isbn == isbn);

      book.borrowBook();

      print("Book Borrowed.");
    } catch (e) {
      print(e);
    }
  }

  // ---------------- Return ----------------

  void returnBook() {
    stdout.write("Enter ISBN : ");

    String isbn = stdin.readLineSync()!;

    try {
      Book book =
          books.firstWhere((book) => book.isbn == isbn);

      book.returnBook();

      print("Book Returned.");
    } catch (e) {
      print(e);
    }
  }

  // ---------------- Members ----------------

  void addMember() {
    stdout.write("Name : ");
    String name = stdin.readLineSync()!;

    stdout.write("ID : ");
    int id = int.parse(stdin.readLineSync()!);

    stdout.write("Email : ");
    String email = stdin.readLineSync()!;

    members.add(Member(name, id, email));

    print("Member Added.");
  }

  void showMembers() {
    if (members.isEmpty) {
      print("No Members Found.");
      return;
    }

    for (Member member in members) {
      member.displayInfo();
      print("");
    }
  }
}