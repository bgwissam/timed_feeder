import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:timed_feeder/domain/repositories/user_repo.dart';

part 'auth_bloc_event.dart';
part 'auth_bloc_state.dart';

class AuthBlocBloc extends Bloc<AuthBlocEvent, AuthBlocState> {
  final UserRepo userRepo;

  AuthBlocBloc({required this.userRepo}) : super(Uninitilized()) {
    on<AuthBlocEvent>((event, emit) async {
      if (event is AppStarted) {
        emit(Uninitilized());
        try {
          final isSignedIn = await userRepo.isSignedIn();
          if (isSignedIn) {
            final name = await userRepo.getUser();
            emit(Autheniticated(displayName: name!.displayName!));
          } else {
            emit(UnAuthenticated());
          }
        } catch (_) {
          emit(UnAuthenticated());
        }
      }
      if (event is LoggedIn) {
        //var name = await userRepo.getUser();
        emit(Autheniticated(displayName: 'any name now'));
      }
      if (event is LoggedOut) {
        emit(UnAuthenticated());

        userRepo.signOut();
      }
    });
  }
}
