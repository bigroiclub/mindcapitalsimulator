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

  @override
  void resetCockpitData() {
    _prefs.remove('aportacion');
    _prefs.remove('porcGanancias');
    _prefs.remove('gananciaMin');
    _prefs.remove('gananciaMax');
    _prefs.remove('showRetiro');
    _prefs.remove('retiro');
    _prefs.remove('tipoGanancia');
    _prefs.remove('referal1');
    _prefs.remove('referal2');
    _prefs.remove('referal3');
    _prefs.remove('referal4');
    _prefs.remove('referal5');
    _prefs.remove('referal6');
    _prefs.remove('referal7');
    _prefs.remove('referal8');
    _prefs.remove('referal9');
    _prefs.remove('referal10');
  }

  @override
  void saveCockpitData(double aportacion, double porcGanancias, double gananciaMin, double gananciaMax,
  bool showRetiro, double retiro, String tipoGanancia, double referal1, double referal2, double referal3, double referal4,
  double referal5, double referal6, double referal7, double referal8, double referal9, double referal10) {
    _prefs.setDouble('aportacion', aportacion);
    _prefs.setDouble('porcGanancias', porcGanancias);
    _prefs.setDouble('gananciaMin', gananciaMin);
    _prefs.setDouble('gananciaMax', gananciaMax);
    _prefs.setBool('showRetiro', showRetiro);
    _prefs.setDouble('retiro', retiro);
    _prefs.setString('tipoGanancia', tipoGanancia);
    _prefs.setDouble('referal1', referal1);
    _prefs.setDouble('referal2', referal2);
    _prefs.setDouble('referal3', referal3);
    _prefs.setDouble('referal4', referal4);
    _prefs.setDouble('referal5', referal5);
    _prefs.setDouble('referal6', referal6);
    _prefs.setDouble('referal7', referal7);
    _prefs.setDouble('referal8', referal8);
    _prefs.setDouble('referal9', referal9);
    _prefs.setDouble('referal10', referal10);
  }

  @override
  double getDouble(String key) {
    return _prefs.getDouble(key);
  }

  @override
  bool getBool(String key) {
    return _prefs.getBool(key);
  }
}
