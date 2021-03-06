import 'package:bloc/bloc.dart';
import 'package:email_validator/email_validator.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:timed_feeder/domain/repositories/user_repo.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  UserRepo userRepo;
  LoginState currentState = LoginState(
      isEmailValid: false,
      isPasswordValid: false,
      isFailure: false,
      isSuccess: false,
      isSubmitting: false);
  LoginBloc({required this.userRepo}) : super(LoginState.emmpty()) {
    on<LoginEvent>((event, emit) async {
      if (event is EmailChanged) {
        emit(
          currentState.update(
            isEmailValid: EmailValidator.validate(event.email),
          ),
        );
      }
      if (event is PasswordChanged) {
        emit(
          currentState.update(
            isPasswordValid: event.password.length > 6 ? true : false,
          ),
        );
      }
      if (event is LoginWithGooglePressed) {
        try {
          emit(LoginState.loading());
          await userRepo.signInWithGoogle();
          emit(LoginState.success());
        } catch (_) {
          emit(LoginState.failure());
        }
      }
      if (event is LoginWithCredentialsPressed) {
        try {
          emit(LoginState.loading());
          await userRepo
              .signInWithCredentials(
                  emailAddress: event.email, password: event.password)
              .catchError((err) {
            print('error login in: $err');
            return err;
          });
          emit(LoginState.success());
        } catch (_) {
          emit(LoginState.failure());
        }
      }
    });
  }
}
