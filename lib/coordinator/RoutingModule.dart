import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:partnership/ui/LoginPage.dart';
import 'package:partnership/ui/SignInPage.dart';
import 'package:partnership/ui/SignUpPage.dart';
import 'package:partnership/ui/testing_page.dart';
import 'package:partnership/coordinator/Routes.dart';
/*
    Handlers:
      Singleton, sum of the Handlers needed by Fluro to map and define the routes of the Application.
*/
class Handlers {
  static Handlers instance;

  final Handler _loginPageHandler = new Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return new LogInPage();
  });
  final Handler _signInPageHandler = new Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return new LogInPage();
  });
  final Handler _signUpPageHandler = new Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return new LogInPage();
  });
  final Handler _testingPageHandler = new Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return new TestingPage();
  });
  final List<String> routes = Routes.routesList;

  final Map<String, Handler> _handlersMap = <String, Handler>{};
  Router _router;

  factory Handlers(Router router) {
    if (instance == null) instance = Handlers._internal(router);
    return instance;
  }
  Handlers._internal(Router router) {
    _router = router;
    _router.notFoundHandler = new Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      print("ROUTE WAS NOT FOUND !!!");
    });
    routes.forEach((route) {
      switch (route) {
        case Routes.root:
          _handlersMap[route] = _router.notFoundHandler;
          break;
        case Routes.loginPage:
          _handlersMap[route] = _loginPageHandler;
          break;
        case Routes.signInPage:
          _handlersMap[route] = _signInPageHandler;
          break;
        case Routes.signUpPage:
          _handlersMap[route] = _signUpPageHandler;
          break;
        case Routes.testingPage:
          _handlersMap[route] = _testingPageHandler;
          break;
        default:
          break;
      }
    });
  }

  void configureRoute() {
    this._handlersMap.forEach((route, handler) => _router.define(route, handler: handler));
  }
}

/*
*   RoutingModule:
*     Singleton, responsible for routing (using library Fluro) in the Application and accessible from the Coordinator.
*/
class RoutingModule {
  final _router = Router();
  Handlers _handlers;
  static final RoutingModule instance = RoutingModule._internal();

  factory RoutingModule() {
    return instance;
  }

  RoutingModule._internal() {
    _handlers = Handlers(_router);
    _handlers.configureRoute();
  }

//  Navigation method expected to be called by the Coordinator after being notified by ViewModels.
  void navigateTo(String route, BuildContext context, [bool popStack = true]) {
    _router.navigateTo(context, route, clearStack: popStack);
  }

  Function generator() {
    return _router.generator;
  }
}
