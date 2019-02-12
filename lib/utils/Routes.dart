import 'package:flutter/material.dart';
import 'package:partnership/ui/LoginPage.dart';
import 'package:partnership/ui/SignInPage.dart';
import 'package:partnership/ui/SignUpPage.dart';
import 'package:partnership/ui/ProfilePage.dart';
import 'package:partnership/ui/testing_page.dart';

enum RoutesEnum {
  root, loginPage, signInPage, signUpPage, profilePage, testingPage
}

abstract class  IRoutes {
  String        get root;
  String        get loginPage;
  String        get signInPage;
  String        get signUpPage;
  String        get profilePage;
  String        get testingPage;
  dynamic            routeMap();
  List<String>   routeList();
  Map<String, RoutesEnum> routeEnumMap();
}

class Routes implements IRoutes {
  static final Routes _instance = Routes._internal();
  factory Routes() {
    return _instance;
  }
  Routes._internal();
  static const String _root = "/";
  static const String _loginPage = "/login_page";
  static const String _signInPage = "/signin_page";
  static const String _signUpPage = "/signup_page";
  static const String _profilePage = "/profile_page";
  static const String _testingPage = "/testing_page";
  dynamic _routeMap() {
    return {
      _root:        (BuildContext context) => LoginPage(), // FallBack
      _loginPage:   (BuildContext context) => LoginPage(),
      _signInPage:  (BuildContext context) => SignInPage(),
      _signUpPage:  (BuildContext context) => SignUpPage(),
      _profilePage: (BuildContext context) => ProfilePage()
    };
  }
  Map<String, RoutesEnum> _routeEnumMap() {
    return <String, RoutesEnum>{
      _root:        RoutesEnum.root,
      _loginPage:   RoutesEnum.loginPage,
      _signInPage:  RoutesEnum.signInPage,
      _signUpPage:  RoutesEnum.signUpPage,
      _profilePage: RoutesEnum.profilePage
    };
  }
   List<String> _routesList() => <String>[_root, _loginPage, _signInPage, _signUpPage, _profilePage];

  @override
  String get loginPage => _loginPage;

  @override
  String get profilePage => _profilePage;

  @override
  String get root => _root;

  @override
  String get signInPage => _signInPage;

  @override
  String get signUpPage => _signUpPage;

  @override
  String get testingPage => this.testingPage;

  @override
  List<String> routeList() {
    return this._routesList();
  }

  @override
  dynamic routeMap() {
    return this._routeMap();
  }

  @override
  Map<String, RoutesEnum> routeEnumMap() {
    return this._routeEnumMap();
  }
}