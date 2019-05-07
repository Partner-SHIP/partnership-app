import 'package:partnership/model/ProjectDescriptionPageModel.dart';
import 'package:partnership/viewmodel/AViewModel.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;

class ProjectDescriptionPageViewModel extends AViewModel {
  ProjectDescriptionPageViewModel(String route) {
    super.initModel(route);
    _projectModel = super.abstractModel;
  }
  ProjectDescriptionPageModel _projectModel;
  File getBannerFile({@required String user, @required String project, @required Function onUpdate}) {
  }
}