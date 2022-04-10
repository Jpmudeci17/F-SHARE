import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:foto_share_2/content/mis_fotos/bloc/misfotos_bloc.dart';
import 'package:foto_share_2/content/mis_fotos/item_misFotos.dart';

class MisFotos extends StatelessWidget {
  const MisFotos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MisfotosBloc, MisfotosState>(
      listener: (context, state) {

      },
      builder: (context, state) {
        if(state is MisFotosLoadingState){
          return ListView.builder(
            itemCount: 25,
            itemBuilder: (BuildContext context, int index){
              return YoutubeShimmer();
            }
          );
        } else if (state is MisFotosEmptyState){
          return Center(
            child: Text("No hay datos por mostrar"),
          );
        } else if (state is MisFotosSuccessState){
          return Container(
            height: MediaQuery.of(context).size.height * 0.40,
            // width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              itemCount: state.allMyData.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, index) {
                return ItemMisFotos(allMyData: state.allMyData[index]);
              }),
          );
        } else if (state is EditSuccessState){
          return Container(child: Text("Si funciona, mas o menos"));
        } else {
          print("Estamos aqui");
          return Center(child: CircularProgressIndicator());
        }
      }
    );
  }
}