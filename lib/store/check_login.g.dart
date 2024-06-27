// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_login.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CheckLogin on _CheckLogin, Store {
  late final _$isLoggedInAtom =
      Atom(name: '_CheckLogin.isLoggedIn', context: context);

  @override
  bool get isLoggedIn {
    _$isLoggedInAtom.reportRead();
    return super.isLoggedIn;
  }

  @override
  set isLoggedIn(bool value) {
    _$isLoggedInAtom.reportWrite(value, super.isLoggedIn, () {
      super.isLoggedIn = value;
    });
  }

  late final _$_CheckLoginActionController =
      ActionController(name: '_CheckLogin', context: context);

  @override
  void logined() {
    final _$actionInfo =
        _$_CheckLoginActionController.startAction(name: '_CheckLogin.logined');
    try {
      return super.logined();
    } finally {
      _$_CheckLoginActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoggedIn: ${isLoggedIn}
    ''';
  }
}
