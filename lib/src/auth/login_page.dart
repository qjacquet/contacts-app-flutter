import 'package:contactsapp/src/auth/auth_bloc.dart';
import 'package:contactsapp/src/auth/auth_module.dart';
import 'package:contactsapp/src/shared/widgets/InitialConfig.dart';
import 'package:contactsapp/src/shared/widgets/Login.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  static String tag = 'login-page';
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  AuthBloc bloc;
  Color color = Colors.indigo;

  @override
  void initState() {
    bloc = AuthModule.to.bloc<AuthBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bloc.getSettings();

    return Scaffold(
        body: StreamBuilder(
            stream: bloc.settingsOut,
            builder: (context, snapshot) {
              if(snapshot.hasData) {
                if(snapshot.data['appAlreadySet'] == 1) {
                  return Login();
                } else {
                  return InitialConfig();
                }
              } else {
                return Scaffold();
              }
            }
        )
    );
  }
}
