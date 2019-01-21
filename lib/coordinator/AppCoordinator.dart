import 'package:flutter/material.dart';
import 'package:partnership/coordinator/RoutingModule.dart';
import 'package:partnership/coordinator/ConnectivityModule.dart';
import 'package:partnership/coordinator/AuthenticationModule.dart';
import 'package:partnership/utils/Routes.dart';
import 'package:partnership/viewmodel/AViewModel.dart';
import 'package:partnership/viewmodel/AViewModelFactory.dart';
import 'package:partnership/ui/LoginPage.dart';
import 'package:partnership/ui/SignInPage.dart';
import 'package:partnership/ui/SignUpPage.dart';
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
  //BuildContext                  _buildContext;

  Coordinator._internal(){
    _connectivity.initialize();
  }

   factory Coordinator(){
      return instance;
   }

  @override
  Widget build(BuildContext _context) {
    MaterialApp app = MaterialApp(
      onGenerateTitle: (context) {
      return 'PartnerSHIP';
      },
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        Routes.root: (context) => null, // NOtFoundView
        Routes.loginPage: (context) => LoginPage(),
        Routes.signInPage: (context) => SignInPage(),
        Routes.signUpPage: (context) => SignUpPage()
      },
      //onGenerateRoute: this._router.generator(),
      //home: LoginPage(),
      initialRoute: this._setUpInitialRoute(),
    );
    return app;
  }

  String _setUpInitialRoute(){
    if (this.fetchRegistersToNavigate(route: Routes.loginPage, context: null, navigate: false))
      return Routes.loginPage;
    return Routes.root;
  }

  bool fetchRegistersToNavigate({@required String route, @required BuildContext context, bool navigate = true, bool popStack = true}) {
    try {
      AViewModelFactory(route);
      if (!this._viewModels.containsKey(route) || !(this._viewModels[route] != null))
        throw Exception("Missing ViewModel for "+route);
      if (navigate)
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