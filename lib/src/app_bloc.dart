import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';

class AppBloc extends BlocBase {

  bool isAuthenticated = false;

  BehaviorSubject<bool> _isAuthenticatedController;

  AppBloc() {
    _isAuthenticatedController = BehaviorSubject.seeded(isAuthenticated);
  }

  login() {
    _isAuthenticatedController.add(true);
  }

  logout() {
    _isAuthenticatedController.add(false);
  }

  isAuth() {
    return _isAuthenticatedController.value;
  }

  //dispose will be called automatically by closing its streams
  @override
  void dispose() {
    _isAuthenticatedController.close();
    super.dispose();
  }
}
