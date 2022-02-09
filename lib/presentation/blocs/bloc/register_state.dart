part of 'register_bloc.dart';

@immutable
class RegisterState {
  final bool? isEmailValid;
  final bool? isPasswordValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  bool get isFormValid => isEmailValid! && isPasswordValid!;

  const RegisterState(
      {this.isEmailValid,
      this.isPasswordValid,
      required this.isSubmitting,
      required this.isSuccess,
      required this.isFailure});

  @override
  List<Object> get props => [];

  factory RegisterState.empty() {
    return const RegisterState(
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory RegisterState.loading() {
    return const RegisterState(
        isEmailValid: true,
        isPasswordValid: true,
        isSubmitting: true,
        isSuccess: false,
        isFailure: false);
  }

  factory RegisterState.failure() {
    return const RegisterState(
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: true,
    );
  }

  factory RegisterState.success() {
    return const RegisterState(
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
    );
  }

  RegisterState update({
    bool? isEmailValid,
    bool? isPasswordValid,
  }) {
    return copyWith(
      isEmailValid: isEmailValid,
      isPasswordValid: isPasswordValid,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  RegisterState copyWith({
    bool? isEmailValid,
    bool? isPasswordValid,
    required bool isSubmitting,
    required bool isSuccess,
    required bool isFailure,
  }) {
    return RegisterState(
        isEmailValid: isEmailValid,
        isPasswordValid: isPasswordValid,
        isSubmitting: isSubmitting,
        isSuccess: isSuccess,
        isFailure: isFailure);
  }

  @override
  String toString() => '''
  RegisterState {
    isEmailValid: $isEmailValid,
    isPasswordValid: $isPasswordValid,
    isSubmitting: $isSubmitting,
    isSuccess: $isSuccess,
    isFailure: $isFailure,
  }
''';
}
