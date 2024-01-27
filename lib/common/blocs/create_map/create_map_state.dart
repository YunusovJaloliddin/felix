part of 'create_map_bloc.dart';

sealed class CreatePostState extends Equatable {
  const CreatePostState();

  @override
  List<Object?> get props => [];
}

class CreatePostInitial extends CreatePostState {}

class CreatePostFailure extends CreatePostState {}

class CreatePostLoading extends CreatePostState {}

class CreatePostSuccess extends CreatePostState {}
