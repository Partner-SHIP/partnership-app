import 'package:flutter/material.dart';
import 'package:partnership/utils/Routes.dart';
/*
*   RoutingModule:
*     Singleton, responsible for routing in the Application and accessible from the Coordinator.
*/
abstract class IRouting {
  void navigateTo({@required String route, @required BuildContext context, bool popStack = false});
  void pushDynamicPage({@required String route, @required BuildContext context, Map<String, dynamic> args});
  dynamic  routeMap();
  String get initialRoute;
}

class RoutingModule implements IRouting {
  static final RoutingModule _instance = RoutingModule._internal();
  factory RoutingModule() {
    return _instance;
  }
  RoutingModule._internal();
  IRoutes _routes = Routes();
  void _navigateTo({@required String route, @required BuildContext context, bool popStack = false}) {
    try {
      if (!this._routes.routeList().contains(route))
        throw Exception("Routing error: trying to reach an unknown route: "+route);
      if (popStack)
        Navigator.pushNamedAndRemoveUntil(context, route, ModalRoute.withName(_routes.loginPage));
      else
        Navigator.pushNamed(context, route);
    }
    catch(error){
      rethrow;
    }
  }

  void _pushDynamicPage({@required String route, @required BuildContext context, Map<String, dynamic> args}){
    try {
      if (!this._routes.dynamicRouteList().contains(route))
        throw Exception("Routing error: trying to reach an unknown dynamic route: "+route);
      MaterialPageRoute page = MaterialPageRoute(builder: null);
      Navigator.push(context, page);
    }
    catch(error){
      rethrow;
    }
  }

  @override
  void navigateTo({String route, BuildContext context, bool popStack = false}) {
    this._navigateTo(route: route, context: context, popStack: popStack);
  }

  @override
  void pushDynamicPage({String route, BuildContext context, Map<String, dynamic> args}) {
    this._pushDynamicPage(route: null, context: null, args: args);
  }

  @override
  dynamic routeMap() {
    return this._routes.routeMap();
  }

  @override
  String get initialRoute => this._routes.homePage;
}
