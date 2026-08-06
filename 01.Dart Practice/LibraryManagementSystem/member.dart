import 'person.dart';

class Member extends Person {
  String _email;

  Member(
    super.name,
    super.id,
    this._email,
  );

  // Getter
  String get email => _email;

  // Setter
  set email(String value) {
    if (value.isNotEmpty) {
      _email = value;
    }
  }

  @override
  void displayInfo() {
    print("========== Member ==========");
    print("ID    : $id");
    print("Name  : $name");
    print("Email : $_email");
  }
}