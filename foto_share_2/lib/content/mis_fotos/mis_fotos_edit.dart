import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foto_share_2/content/mis_fotos/bloc/misfotos_bloc.dart';

class MisFotosEdit extends StatefulWidget {
  const MisFotosEdit(
      {Key? key,
      required this.docIdString,
      required this.switchCurrentValue,
      required this.currentImage,
      required this.currentName})
      : super(key: key);

  //String con el id del doc que quiero editar
  final String docIdString;
  final bool switchCurrentValue;
  final String currentImage;
  final String currentName;

  @override
  State<MisFotosEdit> createState() => _MisFotosEditState();
}

class _MisFotosEditState extends State<MisFotosEdit> {
  var _newTitleC = TextEditingController();
  bool _defaultSwitchValue = false;
  File? image;

  @override
  void initState() {
    _defaultSwitchValue = widget.switchCurrentValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MisfotosBloc, MisfotosState>(
      listener: (context, state) {

        // TODO: implement listener
        if(state is EditFotosEditState){
          image = state.picture;
        } else if(state is EditFotoErrorState){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Error al elegir imagen valida..."))
          );
        } else if(state is EditErrorState){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Error al editar la fshare"))
          );
        }else if(state is EditSuccessState){
          _newTitleC.clear();
          _defaultSwitchValue = false;
          image = null;
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Editar"),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
                Container(
                  child: Text("Imagen",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 24)),
                ),
                SizedBox(
                  height: 20,
                ),
                image == null?
                  Image.network(
                    widget.currentImage,
                    height: 240,
                    width: 240,
                  ):
                  Image.file(
                    image!,
                    height: 240,
                    width: 240,
                  ),
                MaterialButton(
                    child: Text("Foto"),
                    onPressed: () {
                      BlocProvider.of<MisfotosBloc>(context)
                          .add(OnEditTakePictureEvent());
                    }),
                TextField(
                  controller: _newTitleC,
                  decoration: InputDecoration(
                    label: Text("${widget.currentName}"),
                    border: OutlineInputBorder(),
                  ),
                ),
                SwitchListTile.adaptive(
                    title: Text("Publicar"),
                    value: _defaultSwitchValue,
                    onChanged: (newValue) {
                      _defaultSwitchValue = newValue;
                      setState(() {});
                    }),
                MaterialButton(
                  child: Text("Editar"),
                  onPressed: () {
                    Map<String, dynamic> fshareEditData = {
                      "newtitle": _newTitleC.value.text,
                      "newPublic": _defaultSwitchValue,
                      "newFotoShare": image == null? widget.currentImage : image!.path,
                      "docIdEdit": widget.docIdString,
                    };
                    BlocProvider.of<MisfotosBloc>(context).add(OnEditSaveDataEvent(dataToSaveEdit: fshareEditData));

                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
