abstract class LoginEvent{
}

class LoginEventEmpty extends LoginEvent{
  @override
  String toString() => 'Empty Event';
}

class EmailChangedEvent extends LoginEvent{
  final String email;

  EmailChangedEvent(this.email);  

  @override
  String toString() => 'Change email Event';
}

class SignInEvent extends LoginEvent{
  @override
  String toString() => 'SignInEvent Event';
}