import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:partnership/coordinator/RoutingModule.dart';
import 'package:partnership/coordinator/ConnectivityModule.dart';
import 'package:partnership/coordinator/AuthenticationModule.dart';
import 'package:partnership/coordinator/NotificationModule.dart';
import 'package:partnership/viewmodel/AViewModel.dart';
import 'package:partnership/viewmodel/AViewModelFactory.dart';
/*
    Head of the App, brings severals utility modules like Routing, internet connectivity etc...
    Responsible of ViewModels's management.
*/

abstract class ICoordinator{
  bool fetchRegisterToNavigate({@required String route, @required BuildContext context, bool navigate = true, bool popStack = false});
  Future<FirebaseUser> loginByEmail({@required String userEmail, @required String userPassword});
  Future<FirebaseUser> signUpByEmail({@required String newEmail, @required String newPassword});
  FirebaseUser         getLoggedInUser();
  AssetBundle          getAssetBundle();
}

class Coordinator extends State<PartnershipApp> implements ICoordinator {
  static final Coordinator      _instance = Coordinator._internal();
  final IRouting                _router = RoutingModule();
  final IConnectivity           _connectivity = ConnectivityModule();
  final INotification           _notification = NotificationModule();
  final IAuthentication         _authentication = AuthenticationModule();
  final Map<String, AViewModel> _viewModels = AViewModelFactory.register;
  AssetBundle                   _assetBundle;

  Coordinator._internal(){
    _connectivity.initializeConnectivityModule();
    _notification.initializeNotificationModule();
  }

   factory Coordinator(){
      return _instance;
   }

    IAuthentication get authentication => this._authentication;
    IConnectivity   get connectivity => this._connectivity;
    INotification   get notification => this._notification;

  @override
  Widget build(BuildContext _context) {
    MaterialApp app = MaterialApp(
      onGenerateTitle: (context) {
      return 'PartnerSHIP';
      },
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: this._router.routeMap(),
      //onGenerateRoute: this._router.generator(),
      //home: LoginPage(),
      initialRoute: this._setUpInitialRoute(),
    );
    this._assetBundle = DefaultAssetBundle.of(_context);
    return app;
  }

  String _setUpInitialRoute(){
    if (this.fetchRegisterToNavigate(route: this._router.initialRoute, context: null, navigate: false))
      return this._router.initialRoute;
    return null;
  }

  bool _fetchRegisterToNavigate({@required String route, @required BuildContext context, bool navigate = true, bool popStack = false}) {
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

  @override
  bool fetchRegisterToNavigate({String route, BuildContext context, bool navigate = true, bool popStack = false}) {
    return this._fetchRegisterToNavigate(route: route, context: context, navigate: navigate, popStack: popStack);
  }

  @override
  Future<FirebaseUser> loginByEmail({@required String userEmail, @required String userPassword}) {
    return this._authentication.loginByEmail(userEmail: userEmail, userPassword: userPassword);
  }

  @override
  Future<FirebaseUser> signUpByEmail({@required String newEmail, @required String newPassword}) {
    return this._authentication.signUpByEmail(newEmail: newEmail, newPassword: newPassword);
  }

  @override
  FirebaseUser getLoggedInUser() {
    return this.authentication.getLoggedInUser();
  }

  @override
  AssetBundle getAssetBundle() {
    return this._assetBundle;
  }
}

// Main entry of the Application
class PartnershipApp extends StatefulWidget {
  @override
  State<PartnershipApp> createState() {
    return Coordinator();
  }
}