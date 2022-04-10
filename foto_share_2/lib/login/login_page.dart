import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foto_share_2/auth/bloc/auth_bloc.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Column(
            children: [
              Text("Sign in", style: TextStyle(
                fontSize: 24, 
                fontWeight: FontWeight.bold),
              ),
              Image.asset("assets/icons/app_icon.png", width: 100, height: 100,),
              MaterialButton(
                onPressed: () {
                  BlocProvider.of<AuthBloc>(context).add(GoogleAuthEvent());
                },
                color: Colors.grey,
                child: Text("Iniciar con Google"),
              ),
              MaterialButton(
                onPressed: () {},
                color: Colors.yellow,
                child: Text("Iniciar como anonimo"),
              ),
            ],
          )
        ],
      ),
    );
  }
}