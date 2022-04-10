part of 'create_bloc.dart';

abstract class CreateEvent extends Equatable {
  const CreateEvent();

  @override
  List<Object> get props => [];
}

class OnCreateTakePictureEvent extends CreateEvent{}
class OnCreateSaveDataEvent extends CreateEvent{
  final Map<String, dynamic> dataToSave;

  OnCreateSaveDataEvent({required this.dataToSave});

  @override
  List<Object> get props => [dataToSave];
}
