
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:felix/common/controller/storage/storage.dart';
import 'package:felix/common/models/user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'sign_in_event.dart';

part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final RestUser _service;

  SignInBloc({
    required RestUser service,
  })  : _service = service,
        super(SignInInitial()) {
    on<SignInRequired>((event, emit) async {
      emit(SignInProcess());
      Response<dynamic> login= await _service.signIn(event.firstName, event.password);
      if(login.statusCode!>=200 && login.statusCode!<300) {
        UserModel userModel=UserModel.fromJson(login.data["user"]);
        $currentUser.setUser(userModel);
        emit(SignInSuccess());
      } else{
        emit(SignInFailure());
      }
    });
  }
}
