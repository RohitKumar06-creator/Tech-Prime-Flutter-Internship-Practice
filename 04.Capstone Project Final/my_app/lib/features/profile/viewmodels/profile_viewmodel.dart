import 'package:flutter/material.dart';

class ProfileViewModel extends ChangeNotifier {
  // User Profile Data State
  String _ecareId = '1092302';
  String _username = 'Jenny';
  String _firstName = 'Jane';
  String _lastName = 'Doe';

  String _dateOfBirth = 'Feb 12, 1994';
  String _gender = 'Female';
  String _phoneNumber = '+6282332877994';
  String _email = 'jenny123@gmail.com';
  String _city = 'Bandung';
  String _province = 'West Java';
  String _address = 'Jl. Sekar Wangi 20 A, Bancangan';

  bool _notificationsEnabled = true;

  // Getters
  String get ecareId => _ecareId;
  String get username => _username;
  String get firstName => _firstName;
  String get lastName => _lastName;

  /// Returns only the entered name without appending any extra default text
  String get displayName {
    if (_firstName.isEmpty && _username.isNotEmpty) return _username;
    if (_lastName.isNotEmpty) return '$_firstName $_lastName';
    return _firstName;
  }

  String get dateOfBirth => _dateOfBirth;
  String get gender => _gender;
  String get phoneNumber => _phoneNumber;
  String get email => _email;
  String get city => _city;
  String get province => _province;
  String get address => _address;
  bool get notificationsEnabled => _notificationsEnabled;

  void loginUser({required String usernameOrEmail}) {
    if (usernameOrEmail.contains('@')) {
      _email = usernameOrEmail;
      _username = usernameOrEmail.split('@').first;
      _firstName = _username;
    } else {
      _username = usernameOrEmail;
      _firstName = usernameOrEmail;
      _email = '$usernameOrEmail@gmail.com';
    }
    _lastName = ''; // Reset last name on fresh login
    notifyListeners();
  }

  void setGender(String val) {
    _gender = val;
    notifyListeners();
  }

  void setNotificationsEnabled(bool val) {
    _notificationsEnabled = val;
    notifyListeners();
  }

  void updateDateOfBirth(DateTime picked) {
    _dateOfBirth =
        "${_getMonthName(picked.month)} ${picked.day}, ${picked.year}";
    notifyListeners();
  }

  void updateAccountDetails({
    required String username,
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String email,
    required String city,
    required String province,
    required String address,
  }) {
    _username = username;
    _firstName = firstName;
    _lastName = lastName;
    _phoneNumber = phoneNumber;
    _email = email;
    _city = city;
    _province = province;
    _address = address;
    notifyListeners();
  }

  String _getMonthName(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return months[month - 1];
  }
}
