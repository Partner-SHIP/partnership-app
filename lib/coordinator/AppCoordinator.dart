import 'package:flutter/material.dart';
import 'package:partnership/coordinator/RoutingModule.dart';
import 'package:partnership/coordinator/ConnectivityModule.dart';
import 'package:partnership/coordinator/AuthenticationModule.dart';
import 'package:partnership/utils/Routes.dart';
import 'package:partnership/viewmodel/AViewModel.dart';
import 'package:partnership/viewmodel/AViewModelFactory.dart';
/*
    Head of the App, brings severals utility modules like Routing, internet connectivity etc...
    Responsible of ViewModels's management.
*/
class Coordinator extends State<PartnershipApp>{
  static final Coordinator      instance = Coordinator._internal();
  final RoutingModule           _router = RoutingModule();
  final ConnectivityModule      _connectivity = ConnectivityModule();
  final AuthenticationModule    _authentication = AuthenticationModule();
  final Map<String, AViewModel> _viewModels = AViewModelFactory.register;
  BuildContext                  _buildContext;

  Coordinator._internal(){
    _connectivity.initialize();
  }

   factory Coordinator(){
      return instance;
   }

  @override
  Widget build(BuildContext context) {
    this._buildContext = context;
    return new MaterialApp(
      title: 'PartnerSHIP',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: this._router.generator(),
      initialRoute: this._setUpInitialRoute(),
    );
  }

  String _setUpInitialRoute(){
    if (this.fetchRegistersToNavigate(route: Routes.loginPage, navigate: false))
      return Routes.loginPage;
    return Routes.root;
  }

  bool fetchRegistersToNavigate({@required String route, bool navigate = true, bool popStack = true}) {
    try {
      AViewModelFactory(route);
      if (!this._viewModels.containsKey(route) || !(this._viewModels[route] != null))
        throw Exception("Missing ViewModel for "+route);
      if (navigate)
        this._router.navigateTo(route, this._buildContext, popStack);
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