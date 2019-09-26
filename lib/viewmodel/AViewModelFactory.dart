import 'package:flutter/foundation.dart';
import 'package:partnership/viewmodel/AViewModel.dart';
import 'package:partnership/viewmodel/HomePageViewModel.dart';
import 'package:partnership/viewmodel/LoginPageViewModel.dart';
import 'package:partnership/viewmodel/NotificationsPageViewModel.dart';
import 'package:partnership/viewmodel/SignInPageViewModel.dart';
import 'package:partnership/viewmodel/SignUpPageViewModel.dart';
import 'package:partnership/viewmodel/ProfilePageViewModel.dart';
import 'package:partnership/viewmodel/CreationPageViewModel.dart';
import 'package:partnership/viewmodel/IdeaPageViewModel.dart';
import 'package:partnership/viewmodel/ProjectDescriptionPageViewModel.dart';
import 'package:partnership/viewmodel/ProjectBrowsingPageViewModel.dart';
import 'package:partnership/viewmodel/ChatPageViewModel.dart';
import 'package:partnership/viewmodel/GroupsPageViewModel.dart';
import 'package:partnership/viewmodel/AddContactViewModel.dart';
import 'package:partnership/viewmodel/ChatConvViewModel.dart';
import 'package:partnership/viewmodel/NavigPageViewModel.dart';
import 'package:partnership/viewmodel/SearchMemberPageViewModel.dart';
import 'package:partnership/utils/Routes.dart';

import 'ChatScreenViewModel.dart';
/*
    Responsible for creating/managing all the ViewModel, accessible from the Coordinator.
*/

abstract class AViewModelFactory
{
  // Register to store and reuse (without changes in state) instanciated ViewModels
  static final Map<String, AViewModel>  register = <String, AViewModel>{};
  static final IRoutes                  _routes = Routes();

  static RoutesEnum fetchRoutes(String route){
    _routes.dynamicRouteList();
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

  // Factory to instanciate ViewModels from routes
  factory AViewModelFactory(String route){
    if  (register.containsKey(route))
      return register[route];
    else {
      AViewModel  viewModel;
      RoutesEnum  targetedRoute = fetchRoutes(route);
      switch (targetedRoute){
        case RoutesEnum.loginPage:
          viewModel = LoginPageViewModel(_routes.loginPage);
          register[_routes.loginPage] = viewModel;
          break;
        case RoutesEnum.signInPage:
          viewModel = SignInPageViewModel(_routes.signInPage);
          register[_routes.signInPage] = viewModel;
          break;
        case RoutesEnum.signUpPage:
          viewModel = SignUpPageViewModel(_routes.signUpPage);
          register[_routes.signUpPage] = viewModel;
          break;
        case RoutesEnum.profilePage:
          viewModel = ProfilePageViewModel(_routes.profilePage);
          register[_routes.profilePage] = viewModel;
          break;
        case RoutesEnum.creationPage:
          viewModel = CreationPageViewModel(_routes.creationPage);
          register[_routes.creationPage] = viewModel;
          break;
        case RoutesEnum.homePage:
          viewModel = HomePageViewModel(_routes.homePage);
          register[_routes.homePage] = viewModel;
          break;
        case RoutesEnum.projectBrowsingPage:
          viewModel = ProjectBrowsingPageViewModel(_routes.projectBrowsingPage);
          register[_routes.projectBrowsingPage] = viewModel;
          break;
        case RoutesEnum.ideaPage:
          viewModel = IdeaPageViewModel(_routes.ideaPage);
          register[_routes.ideaPage] = viewModel;
          break;
        case RoutesEnum.chatPage:
          viewModel = ChatPageViewModel(_routes.chatPage);
          register[_routes.chatPage] = viewModel;
          print(viewModel);
          break;
        case RoutesEnum.chatScreenPage:
          viewModel = ChatScreenViewModel(_routes.chatScreenPage);
          register[_routes.chatScreenPage] = viewModel;
          break;
        case RoutesEnum.searchMemberPage:
          viewModel = SearchMemberPageViewModel(_routes.searchMemberPage);
          register[_routes.searchMemberPage] = viewModel;
          break;
        case RoutesEnum.notificationsPage:
          viewModel = NotificationsPageViewModel(_routes.notificationsPage);
          register[_routes.notificationsPage] = viewModel;
          break;
        case RoutesEnum.groupsPage:
          viewModel = GroupsPageViewModel(_routes.groupsPage);
          register[_routes.groupsPage] = viewModel;
          break;
        case RoutesEnum.navigPage:
          viewModel = NavigPageViewModel(_routes.navigPage);
          register[_routes.navigPage] = viewModel;
          print(viewModel);
          register[_routes.chatPage] = ChatPageViewModel(_routes.chatPage);
          register[_routes.groupsPage] = GroupsPageViewModel(_routes.groupsPage);
          break;
        default:
          throw Exception("Error while constructing ViewModel: the route \"$route\" provided is unknown !");
          break;
      }
      return viewModel;
    }
  }

  factory AViewModelFactory.createDynamicViewModel({@required String route}){
    AViewModel viewModel;
    DynamicRoutesEnum target = fetchDynamicRoutes(route);
    switch (target){
      case DynamicRoutesEnum.projectDescriptionPage:
        viewModel = ProjectDescriptionPageViewModel(_routes.projectDescriptionPage);
        break;
      case DynamicRoutesEnum.chatConvPage:
        viewModel = ChatConvViewModel(_routes.chatConvPage);
        break;
      default:
        throw Exception("Error while constructing dynamic ViewModel: the dynamic route \"$route\" provided is unknown !");
        break;
    }
    return viewModel;
  }
}