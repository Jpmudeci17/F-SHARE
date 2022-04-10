part of 'espera_bloc.dart';

abstract class EsperaEvent extends Equatable{
  const EsperaEvent();

  @override
  List<Object> get props => [];
}

class GetAllMyDisabledFotosEvent extends EsperaEvent{}



