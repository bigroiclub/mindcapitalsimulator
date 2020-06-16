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
  String toString() => 'CalculationStaterror';
}

class CalculateBackState extends HomeState {
  @override
  String toString() => 'CalculateBackStateerror';
}

class HomeStateError extends HomeState {
  final String message;

  HomeStateError(this.message);

  @override
  String toString() => 'HomeStateError';
}