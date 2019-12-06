import 'dart:io';
import 'package:partnership/viewmodel/AViewModel.dart';
import 'package:partnership/model/ProjectManagementPageModel.dart';

class Project {
  Project(String img, String name, int metrics) : imgUrl = img, projectName = name, metrics = metrics;
  String imgUrl;
  String projectName;
  int metrics;
}

class ProjectManagementPageViewModel extends AViewModel {
  ProjectManagementPageModel _model;
  ProjectManagementPageModel get model => this._model;
  Project       dummy;
  List<Project> projectList = [];

  ProjectManagementPageViewModel(String route) {
    super.initModel(route);
    this._model = super.abstractModel;
    this.dummy = Project(this._model.imgUrl, this._model.projectName, this._model.metrics);
    this.projectList.add(this.dummy);
    this.projectList.add(this.dummy);
    this.projectList.add(this.dummy);
    this.projectList.add(this.dummy);

  }
//GETTERS//
//

}
