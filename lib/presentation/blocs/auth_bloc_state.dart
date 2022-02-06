part of 'auth_bloc_bloc.dart';

@immutable
abstract class AuthBlocState extends Equatable {
  const AuthBlocState([List props = const []]) : super();
}

class Uninitilized extends AuthBlocState {
  @override
  String toString() => 'Uninitialized';

  @override
  List<Object?> get props => [];
}

class Autheniticated extends AuthBlocState {
  final String displayName;
  Autheniticated({required this.displayName}) : super([displayName]);

  @override
  String toString() => 'Authenticated { Name: $displayName }';

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class UnAuthenticated extends AuthBlocState {
  @override
  String toString() => 'UnAuthenticated';

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
