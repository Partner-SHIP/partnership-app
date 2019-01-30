import 'package:partnership/model/AModel.dart';
import 'package:partnership/model/LoginPageModel.dart';
import 'package:partnership/model/ProjectModel.dart';
import 'package:partnership/model/UserModel.dart';
import 'package:partnership/model/SignUpPageModel.dart';
import 'package:partnership/model/ProfilePageModel.dart';
import 'package:partnership/utils/Routes.dart';

abstract class AModelFactory{
  static final Map<String, AModel> register = <String, AModel>{};
  factory AModelFactory(String route){
    if (register.containsKey(route))
      return register[route];
    else {
      AModel model;
      switch (route){
        case Routes.loginPage:
          model = LoginPageModel();
          register[Routes.loginPage] = model;
          break;
        case Routes.signInPage:
          model = UserModel();
          register[Routes.signInPage] = model;
          break;
        case Routes.signUpPage:
          model = SignUpPageModel();
          register[Routes.signUpPage] = model;
          break;
        case Routes.profilePage:
          model = ProfilePageModel();
          register[Routes.profilePage] = model;
          break;
        case Routes.homePage:
          model = ProjectModel();
          register[Routes.homePage] = model;
          break;
        default:
          model = null;
          break;
      }
      return model;
    }
  }
}