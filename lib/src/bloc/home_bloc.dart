import 'package:bloc/bloc.dart';
import 'package:mindcapitalsimulator/src/bloc/event/home_event.dart';
import 'package:mindcapitalsimulator/src/bloc/state/home_state.dart';

import 'package:rate_my_app/rate_my_app.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {

  RateMyApp rateMyApp;

  @override
  HomeState get initialState => HomeInitState();

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    int _currentPage = 0;

    if (event is ChangePageEvent) {
      try {
        _currentPage = event.pageIndex;
        yield ChangePageState(_currentPage);
      } catch (error) {
        yield error is HomeStateError
            ? HomeStateError(error.message)
            : HomeStateError('Algo fue mal al cambiar pagina!');
      }
    } else if (event is CalculateEvent) {
      yield CalculateState();
    } else if (event is CalculateBackEvent) {
      yield CalculateBackState();
    } else if (event is RateMyAddEvent) {
      this.rateMyApp = event.rateMyApp;
      yield RateMyAppState(this.rateMyApp);
    }
  }
}
