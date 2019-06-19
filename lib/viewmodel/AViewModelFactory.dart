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
import 'package:partnership/viewmodel/AddContactViewModel.dart';
import 'package:partnership/viewmodel/ChatConvViewModel.dart';
import 'package:partnership/viewmodel/SearchMemberPageViewModel.dart';
import 'package:partnership/utils/Routes.dart';
/*
    Responsible for creating/managing all the ViewModel, accessible from the Coordinator.
*/

abstract class AViewModelFactory
{
  // Register to store and reuse (without changes in state) instanciated ViewModels
  static final Map<String, AViewModel> register = <String, AViewModel>{};

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

  static DynamicRoutesEnum fetchDynamicRoutes(String route, IRoutes routing){
    DynamicRoutesEnum target;
    return target;
  }

  // Factory to instanciate ViewModels from routes
  factory AViewModelFactory(String route){
    if  (register.containsKey(route))
      return register[route];
    else {
      AViewModel  viewModel;
      IRoutes     _routing = Routes();
      RoutesEnum  targetedRoute = fetchRoutes(route, _routing);
      switch (targetedRoute){
        case RoutesEnum.loginPage:
          viewModel = LoginPageViewModel(_routing.loginPage);
          register[_routing.loginPage] = viewModel;
          break;
        case RoutesEnum.signInPage:
          viewModel = SignInPageViewModel(_routing.signInPage);
          register[_routing.signInPage] = viewModel;
          break;
        case RoutesEnum.signUpPage:
          viewModel = SignUpPageViewModel(_routing.signUpPage);
          register[_routing.signUpPage] = viewModel;
          break;
        case RoutesEnum.profilePage:
          viewModel = ProfilePageViewModel(_routing.profilePage);
          register[_routing.profilePage] = viewModel;
          break;
        case RoutesEnum.creationPage:
          viewModel = CreationPageViewModel(_routing.creationPage);
          register[_routing.creationPage] = viewModel;
          break;
        case RoutesEnum.homePage:
          viewModel = HomePageViewModel(_routing.homePage);
          register[_routing.homePage] = viewModel;
          break;
          /*
        case RoutesEnum.projectDescriptionPage:
          viewModel = ProjectDescriptionPageViewModel(_routing.projectDescriptionPage);
          register[_routing.projectDescriptionPage] = viewModel;
          break;
          */
        case RoutesEnum.projectBrowsingPage:
          viewModel = ProjectBrowsingPageViewModel(_routing.projectBrowsingPage);
          register[_routing.projectBrowsingPage] = viewModel;
          break;
        case RoutesEnum.ideaPage:
          viewModel = IdeaPageViewModel(_routing.ideaPage);
          register[_routing.ideaPage] = viewModel;
          break;
        case RoutesEnum.chatPage:
          viewModel = ChatPageViewModel(_routing.chatPage);
          register[_routing.chatPage] = viewModel;
          break;
        case RoutesEnum.searchMemberPage:
          viewModel = SearchMemberPageViewModel(_routing.searchMemberPage);
          register[_routing.searchMemberPage] = viewModel;
          break;
        case RoutesEnum.notificationsPage:
          viewModel = NotificationsPageViewModel(_routing.notificationsPage);
          register[_routing.notificationsPage] = viewModel;
          break;
        case RoutesEnum.addContactPage:
          viewModel = AddContactViewModel(_routing.addContactPage);
          register[_routing.addContactPage] = viewModel;
          break;
        case RoutesEnum.chatConvPage:
          viewModel = ChatConvViewModel(_routing.chatConvPage);
          register[_routing.chatConvPage] = viewModel;
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
    IRoutes     _routing = Routes();
    DynamicRoutesEnum target = fetchDynamicRoutes(route, _routing);
    switch (target){
      case DynamicRoutesEnum.projectDescriptionPage:
        viewModel = ProjectDescriptionPageViewModel(_routing.projectDescriptionPage);
        break;
      default:
        throw Exception("Error while constructing dynamic ViewModel: the dynamic route \"$route\" provided is unknown !");
        break;
    }
    return viewModel;
  }
}