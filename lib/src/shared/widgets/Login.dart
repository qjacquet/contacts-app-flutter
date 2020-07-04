import 'package:contactsapp/src/app_module.dart';
import 'package:contactsapp/src/auth/auth_bloc.dart';
import 'package:contactsapp/src/auth/auth_module.dart';
import 'package:contactsapp/src/home/home_module.dart';
import 'package:contactsapp/src/home/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:contactsapp/src/shared/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../app_bloc.dart';

class Login extends StatefulWidget {
  final List<Map> items;

  Login({this.items}) : super();
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  Offset _tapPosition;
  AuthBloc bloc;
  AppBloc app;

  final _password = TextEditingController();

  @override
  void initState() {
    bloc = AuthModule.to.getBloc<AuthBloc>();
    app = AppModule.to.getBloc<AppBloc>();
    super.initState();
  }

  Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Mot de passe',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: _password,
            obscureText: true,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.white,
              ),
              hintText: 'Saisissez votre mot de passe',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () async => {
          if (await bloc.settingsRepository.isGoodPassword(_password.text)) {
            app.login(),
            Navigator.of(context).pop()
          } else {
            print('ko')
          }
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(
          'CONNEXION',
          style: TextStyle(
            color: Color(0xFF527DAA),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF73AEF5),
                      Color(0xFF61A4F1),
                      Color(0xFF478DE0),
                      Color(0xFF398AE5),
                    ],
                    stops: [0.1, 0.4, 0.7, 0.9],
                  ),
                ),
              ),
              Container(
                height: double.infinity,
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(
                    left: 40.0,
                    right: 40.0,
                    top: 60.0,
                    bottom: 40.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Mot de passe requis',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'OpenSans',
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 30.0),
                      Image(image: AssetImage('lib/assets/login.png')),
                      SizedBox(height: 30.0),
                      _buildPasswordTF(),
                      _buildLoginBtn(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}

