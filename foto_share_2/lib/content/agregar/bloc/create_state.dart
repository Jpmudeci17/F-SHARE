part of 'create_bloc.dart';

abstract class CreateState extends Equatable {
  const CreateState();
  
  @override
  List<Object> get props => [];
}

class CreateInitial extends CreateState {}

class CreateSuccessState extends CreateState {}

class CreateFshareErrorState extends CreateState {}

class CreateLoadingState extends CreateState {}

class CreatePictureErrorState extends CreateState {}

class CreatePictureChangedState extends CreateState {
  final File picture;

  CreatePictureChangedState({required this.picture});

  @override
  List<Object> get props => [picture];
}
