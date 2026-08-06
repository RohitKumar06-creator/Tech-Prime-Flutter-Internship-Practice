class BookNotFoundException implements Exception {
  @override
  String toString() {
    return "Book not found.";
  }
}

class BookAlreadyBorrowedException implements Exception {
  @override
  String toString() {
    return "Book is already borrowed.";
  }
}

class BookAlreadyReturnedException implements Exception {
  @override
  String toString() {
    return "Book is already available.";
  }
}

class DuplicateBookException implements Exception {
  @override
  String toString() {
    return "A book with this ISBN already exists.";
  }
}