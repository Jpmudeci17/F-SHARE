import 'dart:io';
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

part 'create_event.dart';
part 'create_state.dart';

class CreateBloc extends Bloc<CreateEvent, CreateState> {
  File? _selectedPicture;

  CreateBloc() : super(CreateInitial()) {
    on<OnCreateTakePictureEvent>(_takePicture);
    on<OnCreateSaveDataEvent>(_saveData);
  }

  FutureOr<void> _saveData(OnCreateSaveDataEvent event, Emitter emit) async {
    emit(CreateLoadingState());
    bool _saved = await _saveFshare(event.dataToSave);

    if(_saved){
      emit(CreateSuccessState());
    } else {
      emit(CreateFshareErrorState());
    }
  }
  Future<bool> _saveFshare(Map<String, dynamic> dataToSave) async {
    try{
      //Subir imagen al bucket de firebase storage
      String _imageUrl = await _uploadPictureToStorage();
      print(_imageUrl);
      if(_imageUrl != ""){
        dataToSave["picture"] = _imageUrl;
        dataToSave["publishedAt"] = Timestamp.fromDate(DateTime.now());
        dataToSave["stars"] = 0;
        dataToSave["username"] = FirebaseAuth.instance.currentUser!.displayName;
      }else {
        return false;
      }

      print(dataToSave);

      var docRef = await FirebaseFirestore.instance
        .collection("fshare")
        .add(dataToSave);

      return await _updateUserDocumentReference(docRef.id);
    }catch(e){
      print("Error: $e");
      return false;
    }
  }

  Future<String> _uploadPictureToStorage() async {
    try{
      var stamp = DateTime.now();
      if(_selectedPicture == null){
        return "";
      }
      UploadTask task = FirebaseStorage.instance
      .ref("fshare/imagen_${stamp}.png")
      .putFile(_selectedPicture!);

      await task;

      String resultTask = await task.storage.ref("fshare/imagen_${stamp}.png").getDownloadURL();

      return resultTask;


    }catch(e){
      return "";
    }
  }

  
  Future<bool> _updateUserDocumentReference(String fsharedId) async {
    try{
      var queryUser = await FirebaseFirestore.instance
        .collection("users")
        .doc("${FirebaseAuth.instance.currentUser!.uid}");

      var docsRef = await queryUser.get();
      List<dynamic> listIds = docsRef.data()?["fotosListId"];

      listIds.add(fsharedId);

      await queryUser.update({"fotosListId": listIds});
      return  true;
    }catch(e){
      print("Error en actualizar doc: $e");
      return false;
    }
  }

  FutureOr<void> _takePicture(OnCreateTakePictureEvent event, emit) async {
    emit(CreateLoadingState());
    await _getImage();
    if(_selectedPicture != null){
      emit(CreatePictureChangedState(picture: _selectedPicture!));
    } else {
      emit(CreatePictureErrorState());
    }
  }

  Future<void>_getImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxHeight: 720,
      maxWidth: 720,
      imageQuality: 85,
    );
    if (pickedFile != null) {
      _selectedPicture = File(pickedFile.path);
    } else {
      print('No image selected.');
      _selectedPicture = null;
    }
  }


}
