import 'package:shared_preferences/shared_preferences.dart';

import 'interface/preferences.dart';

class PreferencesInterfaceImpl extends Preferences {
  SharedPreferences _prefs;

  PreferencesInterfaceImpl() {
    initPreferences();
  }

  @override
  Future initPreferences() async {
    _prefs = _prefs ?? await SharedPreferences.getInstance();
  }

  @override
  void keepUser(String email) {
    _prefs.setString('userEmail', email);
  }

  @override
  bool isUserGranted() {
    if (this.getString('userEmail') != null)
      return true;
    else
      return false;
  }

  @override
  void logout() {
    _prefs.remove('userEmail');
  }

  @override
  String getString(String value) {
    return _prefs.getString(value);
  }
}
