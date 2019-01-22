import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:partnership/viewmodel/AViewModelFactory.dart';
import 'package:partnership/model/AModelFactory.dart';
import 'package:partnership/model/AModel.dart';
import 'package:partnership/coordinator/AppCoordinator.dart';
import 'package:partnership/utils/Routes.dart';

/*
    Abstract class defining all ViewModels, destined to be instanciated within the Coordinator by AViewModelFactory.
    Implements methods common to all ViewModels (ex: methods to ask Coordinator to change View/ViewModel).
*/
abstract class AViewModel implements AViewModelFactory
{
  final Coordinator _coordinator = Coordinator();
  AModel            _abstractModel;
  String            _route;

  AViewModel(String route){
    this._route = route;
    this._initModel();
  }

  void _initModel(){
    try {
      AModelFactory(this._route);
      if (!AModelFactory.register.containsKey(this._route) || !(AModelFactory.register[this._route] != null))
        throw Exception("Missing Model for "+this._route);
      this._abstractModel = AModelFactory.register[this._route];
    }
    catch (error){
      print(error);
    }
  }

  AModel get abstractModel => this._abstractModel;
  String get route => this._route;

  bool changeView({@required String route,@required BuildContext widgetContext, bool popStack = false}){
      return this._coordinator.fetchRegisterToNavigate(route: route, context: widgetContext, popStack: popStack);
  }
}