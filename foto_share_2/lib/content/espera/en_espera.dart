import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foto_share_2/content/espera/bloc/espera_bloc.dart';
import 'package:foto_share_2/content/espera/item_espera.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';

class EnEspera extends StatelessWidget {
  const EnEspera({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EsperaBloc, EsperaState>(
      listener: (context, state) {
        //Show snackbar
      },
      builder: (context, state) {
        if(state is EsperaFotosLoadingState){
          return ListView.builder(
            itemCount: 25,
            itemBuilder: (BuildContext context, int index){
              return YoutubeShimmer();
            },
          );
        } else if(state is EsperaFotosEmptyState){
          return Center(
            child: Text("No hay datos por mostrar"),
          );
        } else if (state is EsperaFotoSuccessState){
          return ListView.builder(
            itemCount: state.myDisabledData.length,
            itemBuilder: (BuildContext context, int index){
              return ItemEspera(nonPublicData: state.myDisabledData[index]);
            });
        }else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}