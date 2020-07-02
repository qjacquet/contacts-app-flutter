import 'package:contactsapp/src/auth/auth_module.dart';
import 'package:contactsapp/src/home/home_module.dart';
import 'package:contactsapp/src/shared/repository/contact_repository.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:contactsapp/src/shared/repository/settings_repository.dart';
import 'package:flutter/material.dart';
import 'package:contactsapp/src/app_widget.dart';
import 'package:contactsapp/src/app_bloc.dart';

class AppModule extends ModuleWidget {

  @override
  List<Bloc> get blocs => [
        Bloc((i) => AppBloc()),
      ];

  @override
  List<Dependency> get dependencies => [
        Dependency((i) => ContactRepository()),
        Dependency((i) => SettingsRepository()),
      ];

  @override
  Widget get view => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}
