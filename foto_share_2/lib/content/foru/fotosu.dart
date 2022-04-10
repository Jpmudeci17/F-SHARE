import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foto_share_2/content/foru/item_public.dart';

class FotosU extends StatelessWidget {
  const FotosU({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FirestoreListView(
      query: FirebaseFirestore.instance
        .collection("fshare")
        .where('public', isEqualTo: true),
      itemBuilder: (BuildContext context, QueryDocumentSnapshot<Map<String,dynamic>> document){
        return ItemPublic(publicFData: document.data());
      }
    );
  }
}