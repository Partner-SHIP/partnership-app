import 'package:flutter/material.dart';
import 'package:partnership/utils/Routes.dart';
/*
*   RoutingModule:
*     Singleton, responsible for routing in the Application and accessible from the Coordinator.
*/
class RoutingModule {
  static final RoutingModule instance = RoutingModule._internal();
  factory RoutingModule() {
    return instance;
  }
  RoutingModule._internal();
  void navigateTo({@required String route, @required BuildContext context, bool popStack = false}) {
    try {
      if (!Routes.routesList.contains(route))
        throw Exception("Routing error: trying to reach an unknown route: "+route);
      if (popStack)
        Navigator.pushNamedAndRemoveUntil(context, route, (Route<dynamic> route) => false);
      else
        Navigator.pushNamed(context, route);
    }
    catch(error){
      rethrow;
    }
  }
}
