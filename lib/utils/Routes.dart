import 'package:flutter/material.dart';
import 'package:partnership/ui/LoginPage.dart';
import 'package:partnership/ui/SignInPage.dart';
import 'package:partnership/ui/SignUpPage.dart';

abstract class Routes {
  static const String root = "/";
  static const String loginPage = "/login_page";
  static const String signInPage = "/signin_page";
  static const String signUpPage = "/signup_page";
  static const String profilePage = "/profile_page";
  static const String testingPage = "/testing_page";
  static final routeMap = {
    Routes.root:        (BuildContext context) => null, // NOtFoundView
    Routes.loginPage:   (BuildContext context) => LoginPage(),
    Routes.signInPage:  (BuildContext context) => SignInPage(),
    Routes.signUpPage:  (BuildContext context) => SignUpPage()
  };
  static List<String> get routesList => const <String>[root, loginPage, signInPage, signUpPage, profilePage, testingPage];
  /*
   static get routeMap {
    return {
      Routes.root: (context) => null, // NOtFoundView
      Routes.loginPage: (context) => LoginPage(),
      Routes.signInPage: (context) => SignInPage(),
      Routes.signUpPage: (context) => SignUpPage()
    };
  }*/
}