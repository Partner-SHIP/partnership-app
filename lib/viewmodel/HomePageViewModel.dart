import 'package:partnership/model/ProjectModel.dart';
import 'package:partnership/viewmodel/AViewModel.dart';
import 'package:flutter/material.dart';

class HomePageViewModel extends AViewModel {
  HomePageViewModel(String route) {
    super.initModel(route);
    _projectModel = super.abstractModel;
  }
  ProjectModel _projectModel;
  void disconnect(BuildContext context) {
    this.changeView(widgetContext: context, route: "/login_page", popStack: true);
  }
  void goToProfile(BuildContext context) {
    this.changeView(widgetContext: context, route: "/profile_page");
  }
}