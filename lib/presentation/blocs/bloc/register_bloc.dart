import 'package:bloc/bloc.dart';
import 'package:email_validator/email_validator.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:timed_feeder/domain/repositories/user_repo.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final UserRepo userRepo;
  final RegisterState currentState = const RegisterState(
      isEmailValid: false,
      isPasswordValid: false,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false);

  RegisterBloc({required this.userRepo}) : super(RegisterState.empty()) {
    on<RegisterEvent>((event, emit) async {
      if (event is EmailChanged) {
        emit(currentState.update(
          isEmailValid: EmailValidator.validate(event.email),
        ));
      }
      if (event is PasswordChanged) {
        emit(currentState.update(
            isPasswordValid: event.password.length > 6 ? true : false));
      }
      if (event is Submitted) {
        try {
          print('we are here trying to add user');
          emit(RegisterState.loading());
          await userRepo.signUp(
              emailAddress: event.email.trim(),
              password: event.password.trim());
          emit(
            RegisterState.success(),
          );
          print('the user has been added');
        } catch (_) {
          emit(
            RegisterState.failure(),
          );
        }
      }
    });
  }
}
