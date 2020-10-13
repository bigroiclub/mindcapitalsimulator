import 'package:bloc/bloc.dart';
import 'package:mindcapitalsimulator/src/dao/factory_dao.dart';
import 'package:mindcapitalsimulator/src/repository/preferences_impl.dart';

import 'event/login_event.dart';
import 'state/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final FactoryDao factoryDao;
  final PreferencesInterfaceImpl preferences;
  String _email;
  bool _isUserLogin = false;

  LoginBloc({this.preferences, this.factoryDao});

  @override
  LoginState get initialState {
    if(preferences.isUserGranted())
      _isUserLogin = true;
    return LoginInitState(_isUserLogin);
  }

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is EmailChangedEvent) {
      try {
        _email = event.email.toLowerCase();
      } catch (error) {
        yield error is LoginStateError
            ? LoginStateError(error.message)
            : LoginStateError(
                'Algo fue mal al modificar el correo electrónico!');
      }
    } else if (event is SignInEvent) {
      try {
        if (this._email.isNotEmpty) {
          //Miramos si el usuario ya se ha registrado anteriormente
          if(preferences.isUserGranted()) {
            yield SignInSuccess();
          } else {
            //Si no se ha registrado miramos si existe en la base de datos
            if (await this.factoryDao.loginDao.signIn(this._email) != null) {
              preferences.keepUser(this._email);
              yield SignInSuccess();
            } else {
              this._email = '';
              yield SignInFail();
            }
          }
        }
      } catch (error) {
        this._email = '';
        yield error is LoginStateError
            ? LoginStateError(error.message)
            : LoginStateError('Algo fue mal al registrarte!');
      }
    }
  }
}
