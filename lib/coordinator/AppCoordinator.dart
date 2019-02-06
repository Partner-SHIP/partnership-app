import 'package:flutter/material.dart';
import 'package:partnership/coordinator/RoutingModule.dart';
import 'package:partnership/coordinator/ConnectivityModule.dart';
import 'package:partnership/coordinator/AuthenticationModule.dart';
import 'package:partnership/coordinator/notification_module.dart';
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
  final NotificationModule      _notification = NotificationModule();
  final AuthenticationModule    _authentication = AuthenticationModule();
  final Map<String, AViewModel> _viewModels = AViewModelFactory.register;

  Coordinator._internal(){
    _connectivity.initialize();
  }

   factory Coordinator(){
      return instance;
   }

    AuthenticationModule get authentication => this._authentication;
    ConnectivityModule get connectivity => this._connectivity;

  @override
  Widget build(BuildContext _context) {
    MaterialApp app = MaterialApp(
      onGenerateTitle: (context) {
      return 'PartnerSHIP';
      },
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: Routes.routeMap,
      //onGenerateRoute: this._router.generator(),
      //home: LoginPage(),
      initialRoute: this._setUpInitialRoute(),
    );
    return app;
  }

  String _setUpInitialRoute(){
    if (this.fetchRegisterToNavigate(route: Routes.profilePage, context: null, navigate: false))
      return Routes.profilePage;
  }

  bool fetchRegisterToNavigate({@required String route, @required BuildContext context, bool navigate = true, bool popStack = false}) {
    try {
      AViewModelFactory(route);
      if (!this._viewModels.containsKey(route) || !(this._viewModels[route] != null))
        throw Exception("Missing ViewModel for route \"$route\"");
      if (navigate)
        this._router.navigateTo(route: route, context: context, popStack: popStack);
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