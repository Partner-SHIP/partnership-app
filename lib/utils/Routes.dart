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
  static List<String> get routesList => const <String>[root, loginPage, profilePage, testingPage, signInPage, signUpPage];
}