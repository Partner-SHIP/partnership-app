import 'package:partnership/model/ProjectManagementTabsModel.dart';
import 'package:partnership/viewmodel/AViewModel.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class ProjectManagementTabsViewModel extends AViewModel {
  ProjectManagementTabsViewModel(String route) {
    super.initModel(route);
    _projectModel = super.abstractModel;
  }
  ProjectManagementTabsModel _projectModel;
}