part of 'misfotos_bloc.dart';

abstract class MisfotosState extends Equatable {
  const MisfotosState();
  
  @override
  List<Object> get props => [];
}

class MisfotosInitial extends MisfotosState {}

class MisFotosSuccessState extends MisfotosState {
  final List<Map<String, dynamic>> allMyData;

  MisFotosSuccessState({required this.allMyData});

  @override
  List<Object> get props => [allMyData];
}

class MisFotosErrorState extends MisfotosState{}

class MisFotosEmptyState extends MisfotosState {}

class MisFotosLoadingState extends MisfotosState{}

class MisFotosClickEditarState extends MisfotosState{}

class MisFotosEditLoadingState extends MisfotosState{}

class EditFotosEditState extends MisfotosState{
  final File picture;

  EditFotosEditState({required this.picture});

  @override
  List<Object> get props => [picture];
}

class EditFotoErrorState extends MisfotosState{}

class EditLoadingState extends MisfotosState{}

class EditSuccessState extends MisfotosState{}

class EditErrorState extends MisfotosState {}