import 'dart:io';
import 'package:partnership/viewmodel/AViewModel.dart';
import 'package:partnership/model/CreationPageModel.dart';
import 'package:flutter/material.dart';

class CreationPageViewModel extends AViewModel {
  CreationPageModel                 _model;
  CreationPageViewModel(String route) {
    super.initModel(route);
    this._model = super.abstractModel;
  }

  NetworkImage    image = NetworkImage('https://marineprofessionals.com/wp-content/uploads/2018/12/anonymous.png');

  void postProject(BuildContext context, TextEditingController nameProject, TextEditingController descriptionProject, File image, ) {
    String name = nameProject.text;
    String description = descriptionProject.text;
    this._model.postProject(name, description, image, this.loggedInUser().uid);
    this.changeView(route:"/home_page", widgetContext: context);
  }
  CreationPageModel get model => this._model;
}