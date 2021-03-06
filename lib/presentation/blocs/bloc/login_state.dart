part of 'login_bloc.dart';

class LoginState {
  final bool? isEmailValid;
  final bool? isPasswordValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  bool get isFormValid => isEmailValid! && isPasswordValid!;

  LoginState(
      {this.isEmailValid,
      this.isPasswordValid,
      required this.isSubmitting,
      required this.isSuccess,
      required this.isFailure});

  //initial state
  factory LoginState.emmpty() {
    return LoginState(
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }
  //loading state
  factory LoginState.loading() {
    return LoginState(
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: true,
      isSuccess: false,
      isFailure: false,
    );
  }
  //failure state
  factory LoginState.failure() {
    return LoginState(
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: true,
    );
  }
  //success state
  factory LoginState.success() {
    return LoginState(
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
    );
  }

  LoginState update({bool? isEmailValid, bool? isPasswordValid}) {
    return copyWith(
      isEmailValid: isEmailValid,
      isPasswordValid: isPasswordValid,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  LoginState copyWith({
    bool? isEmailValid,
    bool? isPasswordValid,
    required bool isSubmitting,
    required bool isSuccess,
    required bool isFailure,
  }) {
    return LoginState(
      isEmailValid: isEmailValid,
      isPasswordValid: isPasswordValid,
      isSubmitting: isSubmitting,
      isSuccess: isSuccess,
      isFailure: isFailure,
    );
  }

  @override
  String toString() {
    return '''LoginState {
      isEmailValid: $isEmailValid,
      isPassswordValid: $isPasswordValid,
      isSubmitting: $isSubmitting,
      isSuccess: $isSuccess,
      isFailure: $isFailure
  }''';
  }
}
