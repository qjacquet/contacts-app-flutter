import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:contactsapp/src/shared/repository/settings_repository.dart';
import 'package:rxdart/rxdart.dart';

import '../app_module.dart';

class AuthBloc extends BlocBase {

  final settingsRepository =
    AppModule.to.getDependency<SettingsRepository>();

  Map settings;

  BehaviorSubject<Map> _settingsController;

  AuthBloc() {
    _settingsController = BehaviorSubject.seeded(settings);
  }
  Observable<Map> get settingsOut => _settingsController.stream;

  getSettings() async {
    _settingsController.add(await settingsRepository.getItem(1));
  }

  setSettings(Map settings) {
    _settingsController.add(settings);
  }

  //dispose will be called automatically by closing its streams
  @override
  void dispose() {
    _settingsController.close();
    super.dispose();
  }
}
