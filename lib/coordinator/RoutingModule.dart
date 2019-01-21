import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:partnership/ui/LoginPage.dart';
import 'package:partnership/ui/SignInPage.dart';
import 'package:partnership/ui/SignUpPage.dart';
import 'package:partnership/ui/testing_page.dart';
import 'package:partnership/utils/Routes.dart';
/*
    Handlers:
      Singleton, sum of the Handlers needed by Fluro to map and define the routes of the Application.
*/
abstract class Handlers {
  static final Handler _loginPageHandler = new Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return new LoginPage();
  });
  static final Handler _signInPageHandler = new Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return new SignInPage();
  });
  static final Handler _signUpPageHandler = new Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return new SignUpPage();
  });
  static final Handler _testingPageHandler = new Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return new TestingPage();
  });
  static void configureRoute(Map<String, Handler> handlersMap, Router router) {
    handlersMap.forEach((route, handler) => router.define(route, handler: handler));
  }
}
/*
*   RoutingModule:
*     Singleton, responsible for routing (using library Fluro) in the Application and accessible from the Coordinator.
*/
class RoutingModule {
  final _router = Router();
  final Map<String, Handler> _handlersMap = <String, Handler>{};

  static final RoutingModule instance = RoutingModule._internal();

  factory RoutingModule() {
    return instance;
  }

  RoutingModule._internal() {
    _router.notFoundHandler = new Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
          print("ROUTE WAS NOT FOUND !!!");
        });
    List<String> routes = Routes.routesList;
    routes.forEach((route) {
      switch (route) {
        case Routes.root:
          _handlersMap[route] = _router.notFoundHandler;
          break;
        case Routes.loginPage:
          _handlersMap[route] = Handlers._loginPageHandler;
          break;
        case Routes.signInPage:
          _handlersMap[route] = Handlers._signInPageHandler;
          break;
        case Routes.signUpPage:
          _handlersMap[route] = Handlers._signUpPageHandler;
          break;
        case Routes.testingPage:
          _handlersMap[route] = Handlers._testingPageHandler;
          break;
        default:
          break;
      }
    });
    Handlers.configureRoute(this._handlersMap, this._router);
  }
//  Navigation method expected to be called by the Coordinator after being notified by ViewModels.
  void navigateTo(String route, BuildContext context, [bool popStack = true]) {
    try {
      print("=============[context = $context]=============");
      _router.navigateTo(context, route, clearStack: popStack);
    }
    catch(error){
      rethrow;
    }
  }

  Function generator() {
    return _router.generator;
  }
}
