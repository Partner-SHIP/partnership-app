import 'package:partnership/viewmodel/AViewModel.dart';
import 'package:partnership/viewmodel/LoginPageViewModel.dart';
import 'package:partnership/viewmodel/ProfilePageViewModel.dart';
import 'package:partnership/coordinator/Routes.dart';
/*
    Responsible for creating/managing all the ViewModel, accessible from the Coordinator.
*/
abstract class AViewModelFactory
{
  // Register to store and reuse (without changes in state) instanciated ViewModels
  static final Map<String, AViewModel> register = <String, AViewModel>{};

  // Factory to instanciate ViewModels from routes
  factory AViewModelFactory(String route){
    if  (register.containsKey(route))
      return register[route];
    else {
      AViewModel viewModel;
      switch (route){
        case Routes.loginPage:
          viewModel = LoginPageViewModel();
          register[Routes.loginPage] = viewModel;
          break;
        case Routes.profilePage:
          viewModel = ProfilePageViewModel();
          register[Routes.profilePage] = viewModel;
          break;
        default:
          viewModel = null;
          break;
      }
      return viewModel;
    }
  }
}