part of 'auth_bloc_bloc.dart';

@immutable
abstract class AuthBlocEvent extends Equatable {
  const AuthBlocEvent([List props = const []]) : super();
}

class AppStarted extends AuthBlocEvent {
  @override
  String toString() => 'AppStarted';

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class LoggedIn extends AuthBlocEvent {
  @override
  String toString() => 'LoggedIn';

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class LoggedOut extends AuthBlocEvent {
  @override
  String toString() => 'LoggedOut';

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
