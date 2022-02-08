part of 'login_bloc.dart';

@immutable
abstract class LoginEvent extends Equatable {
  const LoginEvent(List props) : super();

  @override
  List<Object> get props => [];
}

class EmailChanged extends LoginEvent {
  final String email;
  EmailChanged({required this.email}) : super([email]);

  @override
  String toString() => 'Email Changed to: $email';
}

class PasswordChanged extends LoginEvent {
  final String password;
  PasswordChanged({required this.password}) : super([password]);

  @override
  String toString() => 'Password changed to: $password';
}

class Submitted extends LoginEvent {
  final String email;
  final String password;

  Submitted({required this.email, required this.password})
      : super([email, password]);

  @override
  String toString() => 'Submitted: { email: $email - password: $password }';
}

class LoginWithGooglePressed extends LoginEvent {
  const LoginWithGooglePressed(List props) : super(props);

  @override
  String toString() => 'LoginWithGoogle';
}

class LoginWithCredentialsPressed extends LoginEvent {
  final String email;
  final String password;

  LoginWithCredentialsPressed({required this.email, required this.password})
      : super([email, password]);

  @override
  String toString() =>
      'LoginWithCredentials { email: $email - password: $password}';
}
