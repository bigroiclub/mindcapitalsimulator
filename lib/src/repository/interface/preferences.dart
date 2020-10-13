import 'dart:async';

abstract class Preferences {
//Preferences
  Future initPreferences();
  String getString(String value);
  void keepUser(String email);
  bool isUserGranted();
  void logout();
}