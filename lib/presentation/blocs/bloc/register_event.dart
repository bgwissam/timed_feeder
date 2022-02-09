part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent(List props) : super();

  @override
  List<Object> get props => [];
}

class EmailChanged extends RegisterEvent {
  final String email;
  EmailChanged({required this.email}) : super([email]);

  @override
  String toString() => 'Email Changed to: $email';
}

class PasswordChanged extends RegisterEvent {
  final String password;
  PasswordChanged({required this.password}) : super([password]);

  @override
  String toString() => 'Password changed to: $password';
}

class Submitted extends RegisterEvent {
  final String email;
  final String password;

  Submitted({required this.email, required this.password})
      : super([email, password]);

  @override
  String toString() => 'Submitted: { email: $email - password: $password }';
}
