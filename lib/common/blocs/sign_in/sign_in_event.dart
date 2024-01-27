part of 'sign_in_bloc.dart';

abstract class SignInEvent extends Equatable {
  const SignInEvent();

  @override
  List<Object?> get props => [];
}

class SignInRequired extends SignInEvent {
  final String firstName;
  final String password;

  const SignInRequired({
    required this.firstName,
    required this.password,
  });
}

