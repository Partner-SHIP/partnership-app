import 'package:partnership/model/ProjectModel.dart';
import 'package:partnership/viewmodel/AViewModel.dart';
import 'package:partnership/utils/Routes.dart';
import 'package:flutter/material.dart';

class HomePageViewModel extends AViewModel {
  HomePageViewModel() : super(Routes.homePage) {
    _projectModel = super.abstractModel;
  }
  GlobalKey<FormState> _formKey;
  GlobalKey<FormState> get formKey => _formKey;
  String _projectName;
  ProjectModel _projectModel;
  
  String validateName(String value) {
    _projectName = null;
    print("=================validating name================");
    if (value.isEmpty) {
      return ('Veuillez saisir un nom de groupe');
    }
    _projectName = value;
  }

  void attemptCreateProject({@required BuildContext context}) {
    if (_formKey.currentState.validate()) {
      // If the form is valid, we want to show a Snackbar
      //Scaffold.of(context)
      //   .showSnackBar(SnackBar(content: Text('Processing Data')));
      _formKey.currentState.save();
      _attemptCreateProject(context:context, name:_projectName);
    }
  }
  void _onCreateProjectResult(BuildContext context, bool value, String errorMessage) {
    if (value == true) {
      print("Group Creation Success");
    }
    else {
      final String tmp = (errorMessage == null) ? "???" : errorMessage;
      print("Group Creation failure : $tmp");
    }
  }
  void _attemptCreateProject({@required BuildContext context, @required String name}) {
    _projectModel.createProject(name: _projectName, onResult: (value, message) => this._onCreateProjectResult(context, value, message));
  }
  void feedGlobalKey({@required GlobalKey<FormState> key}) {
    this._formKey = key;
  }
}