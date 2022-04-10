import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foto_share_2/content/agregar/bloc/create_bloc.dart';

class AddForm extends StatefulWidget {
  AddForm({Key? key}) : super(key: key);

  @override
  State<AddForm> createState() => _AddFormState();
}

class _AddFormState extends State<AddForm> {
  var _titleC = TextEditingController();
  bool _defaultSwitchValue = false;
  File? image;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateBloc, CreateState>(
      listener: (context, state) {
        // TODO: implement listener
        if(state is CreatePictureErrorState){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Error al elegir imagen valida..."))
          );
        } else if(state is CreateFshareErrorState){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Error al guardar la fshare"))
          );
        }else if(state is CreateSuccessState){
          _titleC.clear();
          _defaultSwitchValue = false;
          image = null;
        } else if(state is CreatePictureChangedState){
          image = state.picture;
        }
      },
      builder: (context, state) {

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              image != null
                  ? Image.file(
                      image!,
                      height: 120,
                    )
                  : Container(),
              SizedBox(
                height: 24,
              ),
              MaterialButton(
                child: Text("Foto"), 
                onPressed: () {
                  BlocProvider.of<CreateBloc>(context).add(OnCreateTakePictureEvent());
                }),
              TextField(
                controller: _titleC,
                decoration: InputDecoration(
                  label: Text("Title"),
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
                child: Text("Guardar"),
                onPressed: () {
                  //Llamar al Bloc para que guarde datos a firebase
                  Map<String, dynamic> fshareData = {
                    "title" : _titleC.value.text,
                    "public":_defaultSwitchValue,
                  };

                  BlocProvider.of<CreateBloc>(context).add(OnCreateSaveDataEvent(dataToSave: fshareData));
                },
              )
            ],
          ),
        );
      },
    );
  }
}
