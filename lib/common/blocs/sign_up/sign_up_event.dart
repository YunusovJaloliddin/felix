part of 'sign_up_bloc.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object?> get props => [];
}

class SignUpRequired extends SignUpEvent {
  final String firstName;
  final String lastName;
  final String phone;
  final String password;

  const SignUpRequired(this.firstName, this.lastName, this.phone, this.password);
}
