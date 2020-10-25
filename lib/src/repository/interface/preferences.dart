import 'dart:async';

abstract class Preferences {
//Preferences
  Future initPreferences();
  double getDouble(String value);
  String getString(String value);
  bool getBool(String value);
  void keepUser(String email);
  bool isUserGranted();
  void logout();
  void saveCockpitData(double aportacion, double porcGanancias, double gananciaMin, double gananciaMax,
  bool showRetiro, double retiro, String tipoGanancia, double referal1, double referal2, double referal3, double referal4,
  double referal5, double referal6, double referal7, double referal8, double referal9, double referal10);
  void resetCockpitData();
}