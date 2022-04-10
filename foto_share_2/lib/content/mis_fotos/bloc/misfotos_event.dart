part of 'misfotos_bloc.dart';

abstract class MisfotosEvent extends Equatable {
  const MisfotosEvent();

  @override
  List<Object> get props => [];
}

class GetAllMyDataEvent extends MisfotosEvent{}

class OnClickEditarButtonEvent extends MisfotosEvent{
  final String dataToEdit;

  OnClickEditarButtonEvent({required this.dataToEdit});

  @override
  List<Object> get props => [dataToEdit];
}

class OnEditTakePictureEvent extends MisfotosEvent{}

class OnEditSaveDataEvent extends MisfotosEvent{
  final Map<String, dynamic> dataToSaveEdit;

  OnEditSaveDataEvent({required this.dataToSaveEdit});

  @override
  List<Object> get props => [dataToSaveEdit];
}