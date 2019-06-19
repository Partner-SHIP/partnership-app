import 'package:flutter/foundation.dart';
import 'package:partnership/model/AModel.dart';
import 'package:partnership/model/LoginPageModel.dart';
import 'package:partnership/model/NotificationsPageModel.dart';
import 'package:partnership/model/SignInPageModel.dart';
import 'package:partnership/model/SignUpPageModel.dart';
import 'package:partnership/model/ProfilePageModel.dart';
import 'package:partnership/model/CreationPageModel.dart';
import 'package:partnership/model/IdeaPageModel.dart';
import 'package:partnership/model/ProjectBrowsingPageModel.dart';
import 'package:partnership/model/ProjectDescriptionPageModel.dart';
import 'package:partnership/model/ChatPageModel.dart';
import 'package:partnership/model/ChatConvModel.dart';
import 'package:partnership/model/AddContactModel.dart';
import 'package:partnership/model/HomePageModel.dart';
import 'package:partnership/model/SearchMemberPageModel.dart';
import 'package:partnership/utils/Routes.dart';

abstract class AModelFactory{
  static final Map<String, AModel>  register = <String, AModel>{};
  static final IRoutes              _routes = Routes();

  static RoutesEnum fetchRoutes(String route){
    RoutesEnum target;
    _routes.routeList().forEach((value){
      if (value == route){
        target = _routes.routeEnumMap()[value];
        return target;
      }
    });
    return target;
  }

  static DynamicRoutesEnum fetchDynamicRoutes(String route){
    DynamicRoutesEnum target;
    _routes.dynamicRouteList().forEach((value){
      if (value == route){
        target = _routes.dynamicRouteEnumMap()[value];
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
      RoutesEnum targetedRoute = fetchRoutes(route);
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
        case RoutesEnum.creationPage:
          model = CreationPageModel();
          register[_routing.creationPage] = model;
          break;
        case RoutesEnum.homePage:
          model = HomePageModel();
          register[_routing.homePage] = model;
          break;
        case RoutesEnum.projectBrowsingPage:
          model = ProjectBrowsingPageModel();
          register[_routing.projectBrowsingPage] = model;
          break;
        case RoutesEnum.ideaPage:
          model = IdeaPageModel();
          register[_routing.ideaPage] = model;
          break;
        case RoutesEnum.chatPage:
          model = ChatPageModel();
          register[_routing.chatPage] = model;
          break;
        case RoutesEnum.searchMemberPage:
          model = SearchMemberPageModel();
          register[_routing.searchMemberPage] = model;
          break;
        case RoutesEnum.notificationsPage:
          model = NotificationsPageModel();
          register[_routing.notificationsPage] = model;
          break;
        case RoutesEnum.addContactPage:
          model = AddContactModel();
          register[_routing.addContactPage] = model;
          break;
        case RoutesEnum.chatConvPage:
          model = ChatConvModel();
          register[_routing.chatConvPage] = model;
          break;
        default:
          throw Exception("Error while constructing Model: the route \"$route\" provided is unknown !");
          break;
      }
      return model;
    }
  }

  factory AModelFactory.createDynamicModel({@required String route}){
    AModel model;
    DynamicRoutesEnum targetedRoute = fetchDynamicRoutes(route);
    switch (targetedRoute) {
      case DynamicRoutesEnum.projectDescriptionPage:
        model = ProjectDescriptionPageModel();
        break;
      default:
        throw Exception("Error while constructing dynamic Model: the route \"$route\" provided is unknown !");
        break;
    }
    return model;
  }
}