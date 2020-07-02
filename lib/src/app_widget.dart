import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:contactsapp/src/home/home_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'auth/auth_bloc.dart';
import 'auth/auth_module.dart';
import 'auth/login_page.dart';
import 'home/home_bloc.dart';
import 'home/home_page.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final routes = <String, WidgetBuilder>{
      HomePage.tag: (context) => HomePage(),
      LoginPage.tag: (context) => LoginPage(),
    };
    return BlocProvider(
      child: MaterialApp(
        title: 'Contact App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.indigo,
        ),
        home: HomeModule(),
        routes: routes,
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('fr', 'FR'),
        ],
      ),
    );
  }
}
