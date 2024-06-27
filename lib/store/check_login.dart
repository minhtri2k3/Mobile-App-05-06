import 'package:mobx/mobx.dart';

part 'check_login.g.dart';

class CheckLogin = _CheckLogin with _$CheckLogin;

abstract class _CheckLogin with Store {
  @observable
  bool isLoggedIn = false;

  @action
  void logined() {
    isLoggedIn = true;
  }
}
