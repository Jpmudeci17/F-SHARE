part of 'espera_bloc.dart';

abstract class EsperaState extends Equatable{
    const EsperaState();

  @override
  List<Object> get props => [];

}

class EsperaInitial extends EsperaState {}


class EsperaFotoSuccessState extends EsperaState{
  final List<Map<String,dynamic>> myDisabledData;

  EsperaFotoSuccessState({required this.myDisabledData});

  @override
  List<Object> get props => [myDisabledData];

}
class EsperaFotosErrorState extends EsperaState {}
class EsperaFotosEmptyState extends EsperaState {}
class EsperaFotosLoadingState extends EsperaState {}