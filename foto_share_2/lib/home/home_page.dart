import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foto_share_2/auth/bloc/auth_bloc.dart';
import 'package:foto_share_2/content/agregar/add_form.dart';
import 'package:foto_share_2/content/espera/en_espera.dart';
import 'package:foto_share_2/content/foru/fotosu.dart';
import 'package:foto_share_2/content/mis_fotos/mis_fotos.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _currentPageIndex = 0;
  final _pageList = [
    FotosU(),
    EnEspera(),
    AddForm(),
    MisFotos(),
  ];
  final _namePageList = [
    "Fotos para ti",
    "En espera",
    "Agregar",
    "Mi contenido",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_namePageList[_currentPageIndex]),
        actions: [
          IconButton(
            onPressed: () {
              BlocProvider.of<AuthBloc>(context).add(SignOutEvent());
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: IndexedStack(
        index: _currentPageIndex,
        children: _pageList,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentPageIndex,
        onTap: (index) {
          setState(() {
            _currentPageIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            label: _namePageList[0],
            icon: Icon(Icons.view_carousel),
          ),
          BottomNavigationBarItem(
            label: _namePageList[1],
            icon: Icon(Icons.query_builder),
          ),
          BottomNavigationBarItem(
            label: _namePageList[2],
            icon: Icon(Icons.photo_camera),
          ),
          BottomNavigationBarItem(
            label: _namePageList[3],
            icon: Icon(Icons.mobile_friendly),
          ),
        ],
      ),
    );
  }
}