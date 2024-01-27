part of 'create_map_bloc.dart';

sealed class CreatePostEvent extends Equatable {
  const CreatePostEvent();

  @override
  List<Object?> get props => [];
}

class CreatePost extends CreatePostEvent {
  final String title;
  final String description;
  final double lat;
  final double lot;

  const CreatePost(
    this.title,
    this.description,
    this.lat,
    this.lot,
  );
}
