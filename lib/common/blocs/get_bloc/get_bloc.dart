
import 'package:bloc/bloc.dart';
import 'package:felix/common/controller/storage/storage.dart';
import 'package:meta/meta.dart';

part 'get_event.dart';
part 'get_state.dart';

class GetBloc extends Bloc<GetEvent, GetState> {
  GetBloc() : super(GetInitial()) {
    on<GetEvent>((event, emit) async {
      await $currentUser.getUser();
      if($currentUser.userModel != null){
        emit(GetSuccess());
      }
    });
  }
}
