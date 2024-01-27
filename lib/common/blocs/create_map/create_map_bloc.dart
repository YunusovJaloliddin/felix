import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/map_model.dart';

part 'create_map_event.dart';

part 'create_map_state.dart';

class CreatePostBloc extends Bloc<CreatePostEvent, CreatePostState> {
  final RestMap _service;

  CreatePostBloc({
    required RestMap service,
  })  : _service = service,
        super(CreatePostInitial()) {
    on<CreatePost>((event, emit) async {
      emit(CreatePostLoading());
      final map = await _service.saveMap(
        event.title,
        event.description,
        event.lat,
        event.lot,
      );
      if (map.statusCode! >= 200 && map.statusCode! < 300) {
        emit(CreatePostSuccess());
      } else {
        emit(CreatePostFailure());
      }
    });
  }
}
