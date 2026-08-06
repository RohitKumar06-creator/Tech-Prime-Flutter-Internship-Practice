import 'enums.dart';
import 'exceptions.dart';

class Book {
  static int totalBooks = 0;

  String _title;
  String _author;
  String _isbn;

  BookStatus status = BookStatus.available;

  Book(this._title, this._author, this._isbn) {
    totalBooks++;
  }

  // Getters
  String get title => _title;
  String get author => _author;
  String get isbn => _isbn;

  // Setters
  set title(String value) {
    if (value.isNotEmpty) {
      _title = value;
    }
  }

  set author(String value) {
    if (value.isNotEmpty) {
      _author = value;
    }
  }

  void borrowBook() {
    if (status == BookStatus.borrowed) {
      throw BookAlreadyBorrowedException();
    }

    status = BookStatus.borrowed;
  }

  void returnBook() {
    if (status == BookStatus.available) {
      throw BookAlreadyReturnedException();
    }

    status = BookStatus.available;
  }

  void displayInfo() {
    print("-----------------------------");
    print("Title  : $_title");
    print("Author : $_author");
    print("ISBN   : $_isbn");
    print("Status : ${status.name}");
  }
}