abstract class HomeEvent{
}

class HomeEventEmpty extends HomeEvent{
  @override
  String toString() => 'Empty Event';
}

class ChangePageEvent extends HomeEvent{
  final int pageIndex;

  ChangePageEvent(this.pageIndex);  

  @override
  String toString() => 'Change Page Event';
}

class CalculateEvent extends HomeEvent{
  @override
  String toString() => 'CalculateEvent Event';
}

class CalculateBackEvent extends HomeEvent{
  @override
  String toString() => 'CalculateBackEvent Event';
}