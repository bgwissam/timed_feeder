import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:timed_feeder/domain/repositories/user_repo.dart';

part 'auth_bloc_event.dart';
part 'auth_bloc_state.dart';

class AuthBlocBloc extends Bloc<AuthBlocEvent, AuthBlocState> {
  final UserRepo _userRepo;

  AuthBlocBloc(this._userRepo, {required UserRepo userRepo})
      : super(Uninitilized()) {
    on<AuthBlocEvent>((event, emit) {});
  }
}
