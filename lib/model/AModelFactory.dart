import 'package:partnership/model/AModel.dart';
import 'package:partnership/model/LoginPageModel.dart';
import 'package:partnership/model/SignInPageModel.dart';
import 'package:partnership/model/SignUpPageModel.dart';
import 'package:partnership/model/ProfilePageModel.dart';
import 'package:partnership/utils/Routes.dart';

abstract class AModelFactory{
  static final Map<String, AModel> register = <String, AModel>{};

  static RoutesEnum fetchRoutes(String route, IRoutes routing){
    RoutesEnum target;
    routing.routeList().forEach((value){
      if (value == route){
        target = routing.routeEnumMap()[value];
        return target;
      }
    });
    return target;
  }

  factory AModelFactory(String route){
    if (register.containsKey(route))
      return register[route];
    else {
      AModel model;
      IRoutes _routing = Routes();
      RoutesEnum targetedRoute = fetchRoutes(route, _routing);
      switch (targetedRoute){
        case RoutesEnum.loginPage:
          model = LoginPageModel();
          register[_routing.loginPage] = model;
          break;
        case RoutesEnum.signInPage:
          model = SignInPageModel();
          register[_routing.signInPage] = model;
          break;
        case RoutesEnum.signUpPage:
          model = SignUpPageModel();
          register[_routing.signUpPage] = model;
          break;
        case RoutesEnum.profilePage:
          model = ProfilePageModel();
          register[_routing.profilePage] = model;
          break;
        default:
          model = null;
          break;
      }
      return model;
    }
  }
}