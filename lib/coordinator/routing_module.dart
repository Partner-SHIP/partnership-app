import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:partnership/ui/login_page.dart';
import 'package:partnership/profile/profile_page.dart';

class Handlers {

  final Handler _loginPageHandler = new Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params){
    return new LoginPage();
  });
  final Handler _ProfilePageHandler = new Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params){
    return new ProfilePage();
  });
  static final List<String> routes = [
    "/",
    "/login_page",
    "/profile_page"
  ];
  final Map<String, Handler> _handlersMap = <String, Handler>{};
  Router _router;
  Handlers(Router router) {
    _router = router;
    _router.notFoundHandler = new Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      print("ROUTE WAS NOT FOUND !!!");
    });
    routes.forEach((route) {
      switch (route) {
        case "/":
          _handlersMap[route] = _router.notFoundHandler;
          break;
        case "/login_page":
          _handlersMap[route] = _loginPageHandler;
          break;
        case "/profile_page":
          _handlersMap[route] = _ProfilePageHandler;
          break;
        default:
          break;
      }
    });
  }

  void configureRoute() {
    this._handlersMap.forEach((route, handler) => _router.define(route, handler:handler));
  }
}

class RoutingModule {
  final _router = Router();
  Handlers _handlers;
  RoutingModule() {
    _handlers = Handlers(_router);
    _handlers.configureRoute();
  }
  void navigateTo(String route, BuildContext context){
    _router.navigateTo(context, route);
  }
  Function generator(){
    return _router.generator;
  }
}