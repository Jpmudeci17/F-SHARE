import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:foto_share_2/auth/bloc/auth_bloc.dart';
import 'package:foto_share_2/content/agregar/bloc/create_bloc.dart';
import 'package:foto_share_2/content/espera/bloc/espera_bloc.dart';
import 'package:foto_share_2/content/mis_fotos/bloc/misfotos_bloc.dart';
import 'package:foto_share_2/home/home_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc()..add(VerifyAuthEvent()),
        ),
        BlocProvider(
          create: (context) => EsperaBloc()..add(GetAllMyDisabledFotosEvent()),
        ),
        BlocProvider(
          create: ((context) => MisfotosBloc()..add(GetAllMyDataEvent())),
        ),
        BlocProvider(
          create: ((context) => CreateBloc()),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.purple,
        ),
      ),
      home: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Favor de autenticarse"),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is AuthSuccessState) {
            return HomePage();
          } else if (state is UnAuthState || state is AuthErrorState) {
            return LoginPage();
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
