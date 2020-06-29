import 'package:flutter/material.dart';
import 'package:contactsapp/src/home/home_module.dart';
import 'home/home_page.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final routes = <String, WidgetBuilder>{
      HomePage.tag: (context) => HomePage(),
    };
    return MaterialApp(
      title: 'Contact App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: HomeModule(),
      routes: routes,
    );
  }
}
