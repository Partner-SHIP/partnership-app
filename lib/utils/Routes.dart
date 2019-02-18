import 'package:flutter/material.dart';
import 'package:partnership/ui/HomePage.dart';
import 'package:partnership/ui/LoginPage.dart';
import 'package:partnership/ui/SignInPage.dart';
import 'package:partnership/ui/SignUpPage.dart';
import 'package:partnership/ui/ProfilePage.dart';
import 'package:partnership/ui/ProjectDescriptionPage.dart';
import 'package:partnership/ui/testing_page.dart';


enum RoutesEnum {
  root, loginPage, signInPage, signUpPage, profilePage, testingPage, homePage, projectDescriptionPage
}

abstract class  IRoutes {
  String        get root;
  String        get loginPage;
  String        get signInPage;
  String        get signUpPage;
  String        get profilePage;
  String        get testingPage;
  String        get homePage;
  String        get projectDescriptionPage;

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
  static const String _homePage = "/home_page";
  static const String _projectDescriptionPage = "/project_description_page";
  dynamic _routeMap() {
    return {
      _root:                      (BuildContext context) => LoginPage(), // FallBack
      _loginPage:                 (BuildContext context) => LoginPage(),
      _signInPage:                (BuildContext context) => SignInPage(),
      _signUpPage:                (BuildContext context) => SignUpPage(),
      _profilePage:               (BuildContext context) => ProfilePage(),
      _homePage:                  (BuildContext context) => HomePage(),
      _projectDescriptionPage:    (BuildContext context) => ProjectDescriptionPage(),
    };  
  }
  Map<String, RoutesEnum> _routeEnumMap() {
    return <String, RoutesEnum>{
      _root:                    RoutesEnum.root,
      _loginPage:               RoutesEnum.loginPage,
      _signInPage:              RoutesEnum.signInPage,
      _signUpPage:              RoutesEnum.signUpPage,
      _profilePage:             RoutesEnum.profilePage,
      _homePage:                RoutesEnum.homePage,
      _projectDescriptionPage:  RoutesEnum.projectDescriptionPage,
    };
  }
   List<String> _routesList() => <String>[_root, _loginPage, _signInPage, _signUpPage, _profilePage, _homePage, _projectDescriptionPage];

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
  String get testingPage => _testingPage;

  @override
  String get homePage => _homePage;

  @override
  String get projectDescriptionPage => _projectDescriptionPage;

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