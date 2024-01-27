import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:felix/common/controller/storage/storage.dart';
import 'package:felix/common/models/user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'sign_up_event.dart';

part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final RestUser _service;

  SignUpBloc({
    required RestUser service,
  })  : _service = service,
        super(SignUpInitial()) {
    on<SignUpRequired>((event, emit) async {
      emit(SignUpProcess());
      Response<dynamic> login= await _service.signUp(
        event.firstName,
        event.lastName,
        event.phone,
        event.password,
      );
      if(login.statusCode!>=200 && login.statusCode!<300) {
        UserModel userModel = UserModel(
          firstName: event.firstName,
          lastName: event.lastName,
          phone: event.phone,
        );
        $currentUser.setUser(userModel);
        emit(SignUpSuccess());
      } else{
        emit(SignUpFailure());
      }
    });
  }
}
