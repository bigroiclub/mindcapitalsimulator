import 'package:rate_my_app/rate_my_app.dart';

abstract class HomeState {}

class HomeInitState extends HomeState {
  @override
  String toString() => 'HomeStateEmpty';
}

class ChangePageState extends HomeState {
  final int pageIndex;

  ChangePageState(this.pageIndex);

  @override
  String toString() => 'Change Page State';
}

class CalculateState extends HomeState {
  @override
  String toString() => 'CalculationState';
}

class CalculateBackState extends HomeState {
  @override
  String toString() => 'CalculateBackState';
}

class RateMyAppState extends HomeState {
  final RateMyApp rateMyApp;

  RateMyAppState(this.rateMyApp);
  
  @override
  String toString() => 'RateMyAppState';
}

class HomeStateError extends HomeState {
  final String message;

  HomeStateError(this.message);

  @override
  String toString() => 'HomeStateError';
}