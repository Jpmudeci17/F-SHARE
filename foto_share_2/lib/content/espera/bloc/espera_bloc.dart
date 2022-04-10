import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';


part 'espera_event.dart';
part 'espera_state.dart';

class EsperaBloc extends Bloc<EsperaEvent, EsperaState> {
  EsperaBloc() : super(EsperaInitial()) {
    on<GetAllMyDisabledFotosEvent>(_getMyDisabledContent);
  }

  FutureOr<void> _getMyDisabledContent(event, emit) async {
    emit(EsperaFotosLoadingState());
    try{
      var queryUser = await FirebaseFirestore.instance
        .collection('users')
        .doc("${FirebaseAuth.instance.currentUser!.uid}");

      var docsRef = await queryUser.get();
      List<dynamic> listIds = docsRef.data()?["fotosListId"] ?? [];

      print(listIds);

      var queryFotos = await FirebaseFirestore.instance.collection("fshare").get();

      print(queryFotos);

      var myDisabledContentList = queryFotos.docs
      .where((element) => listIds.contains(element.id) && element.data()["public"] == false)
      .map((e) => e.data().cast<String, dynamic>())
      .toList();

      emit(EsperaFotoSuccessState(myDisabledData: myDisabledContentList));

    }catch(e){
      print("Error al obtener items en espera");
      emit(EsperaFotosErrorState());
    }
  }
}
