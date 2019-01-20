import 'package:flutter/material.dart';
import 'package:partnership/coordinator/RoutingModule.dart';
import 'package:partnership/coordinator/ConnectivityModule.dart';
import 'package:partnership/coordinator/AuthenticationModule.dart';
import 'package:partnership/coordinator/Routes.dart';
import 'package:partnership/viewmodel/AViewModel.dart';
import 'package:partnership/viewmodel/AViewModelFactory.dart';
import 'package:partnership/model/AModel.dart';
import 'package:partnership/model/AModelFactory.dart';
/*
    Head of the App, brings severals utility modules like Routing, internet connectivity etc...
    Responsible of ViewModels's management.
*/
class Coordinator extends State<PartnershipApp>{

  final RoutingModule _router = RoutingModule();
  final ConnectivityModule _connectivity = ConnectivityModule();
  final AuthenticationModule _authentication = AuthenticationModule();
  final Map<String, AViewModel> _viewModels = AViewModelFactory.register;
  final Map<String, AModel> _models = AModelFactory.register;

  Coordinator(){
    _connectivity.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'PartnerSHIP',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: this._router.generator(),
      initialRoute: Routes.loginPage,
    );
  }

  bool fetchRegistersToNavigate({@required String route, bool popStack = true}){
    try {
      AViewModelFactory(route);
      AModelFactory(route);
      if (!this._viewModels.containsKey(route) || !(this._viewModels[route] != null))
        throw Exception("Missing viewModel for "+route);
      this._router.navigateTo(route, context, popStack);
      return true;
    }
    catch (error) {
      print(error);
      return false;
    }
  }

}

// Main entry of the Application
class PartnershipApp extends StatefulWidget {
  @override
  State<PartnershipApp> createState() {
    return Coordinator();
  }
}