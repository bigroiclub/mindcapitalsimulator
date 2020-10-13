abstract class LoginState {}

class LoginInitState extends LoginState {
  final bool isUserLogin;

  LoginInitState(this.isUserLogin);
  @override
  String toString() => 'LoginStateEmpty';
}

class SignInSuccess extends LoginState {
  @override
  String toString() => 'SignInSuccess';
}

class SignInFail extends LoginState {
  @override
  String toString() => 'SignInFail';
}

class LoginStateError extends LoginState {
  final String message;

  LoginStateError(this.message);

  @override
  String toString() => 'LoginStateError';
}