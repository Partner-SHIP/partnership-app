import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:partnership/coordinator/RoutingModule.dart';
import 'package:partnership/coordinator/ConnectivityModule.dart';
import 'package:partnership/coordinator/AuthenticationModule.dart';
import 'package:partnership/coordinator/NotificationModule.dart';
import 'package:partnership/viewmodel/AViewModel.dart';
import 'package:partnership/viewmodel/AViewModelFactory.dart';

import 'package:tuple/tuple.dart';

import 'ChatModule.dart';
/*
    Head of the App, brings severals utility modules like Routing, internet connectivity etc...
    Responsible of ViewModels's management.
*/

abstract class ICoordinator{
  bool fetchRegisterToNavigate({@required String route, @required BuildContext context, bool navigate = true, bool popStack = false});
  bool navigateToDynamicPage({@required String route, @required BuildContext context, @required Map<String, dynamic> args});
  Future<FirebaseUser> loginByEmail({@required String userEmail, @required String userPassword});
  Future<FirebaseUser> signUpByEmail({@required String newEmail, @required String newPassword});
  Future<void>         disconnect();
  StreamSubscription   subscribeToConnectivity(Function handler);
  void                 showConnectivityAlert(BuildContext context);
  FirebaseUser         getLoggedInUser();
  AssetBundle          getAssetBundle();
  String               getContactId();
  void                 setContactId(String contactId);
  void                  setPageContext(Tuple2<BuildContext, String> newPageContext);
  String                getToken();
}

class Coordinator extends State<PartnershipApp> implements ICoordinator {
  static final Coordinator      _instance = Coordinator._internal();
  final IRouting                _router = RoutingModule();
  final IConnectivity           _connectivity = ConnectivityModule();
  final INotification           _notification = NotificationModule();
  final IAuthentication         _authentication = AuthenticationModule();
  final IChat                   _chat = ChatModule();
  final Map<String, AViewModel> _viewModels = AViewModelFactory.register;
  AssetBundle                   _assetBundle;
  StreamSubscription<bool>      _connectivitySub;
  StreamSubscription<Map<String, dynamic>>      _notificationSub;
  BuildContext        _context;
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  Tuple2<BuildContext, String> _pageContext;
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
    IChat           get chat => this._chat;

  @override
  void initState(){
    super.initState();
    this._connectivitySub = this._connectivity.subscribeToConnectivity(this._connectivityHandler);
    this._notificationSub = this._notification.subscribeToNotification(this._notificationHandler);
  }

  @override
  void dispose(){
    this._connectivitySub.cancel();
    this._notificationSub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext _context) {
    this._context = _context;
    MaterialApp app = MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      onGenerateTitle: (context) {
      return 'PartnerSHIP';
      },
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: this._router.routeMap(),
      home: FutureBuilder<FirebaseUser>(
        future: authentication.getCurrentUser(),
        builder: (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot){
          switch (snapshot.connectionState){
            case ConnectionState.none:
            case ConnectionState.waiting:
              return CircularProgressIndicator();
              break;
            default:
              this._setUpInitialRoutes();
              if (snapshot.hasError)
                return _router.materialPageMap()[_router.routes.loginPage];
              else {
                if (snapshot.data == null)
                  return _router.materialPageMap()[_router.routes.loginPage];
                else
                  return _router.materialPageMap()[_router.routes.homePage];
              }
          }
        },
      ),
    );
    this._assetBundle = DefaultAssetBundle.of(_context);
    return app;
  }

  void _setUpInitialRoutes(){
    this.fetchRegisterToNavigate(route: _router.routes.loginPage, context: null, navigate: false);
    this.fetchRegisterToNavigate(route: _router.routes.homePage, context: null, navigate: false);
    this.fetchRegisterToNavigate(route: _router.routes.notificationsPage, context: null, navigate: false);
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

  bool _navigateToDynamicPage({@required String route, @required BuildContext context, @required Map<String, dynamic> args}){
    try {
      _router.pushDynamicPage(route: route, context: context, args: args);
      return true;
    }
    catch (error){
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
    return this._authentication.getLoggedInUser();
  }

  @override
  AssetBundle getAssetBundle() {
    return this._assetBundle;
  }

  @override
  StreamSubscription subscribeToConnectivity(Function handler) {
    return this._connectivity.subscribeToConnectivity(handler);
  }

  void _connectivityHandler(bool value) {
    // Do something involving internet connection's status
  }

  void _notificationHandler(Map<String,dynamic> msg){
    print('NEW NOTIFICATION FROM COORDINATOR');

    switch (EnumNotification.CONTACT_ADD_NOTIFICATION) {
      case EnumNotification.CONTACT_ADD_NOTIFICATION:
        if (this._authentication.getLoggedInUser() != null)
          {
            print("coucou1");
          }
        else
          print('PRB AVEC NOTIF MESSAGE');
        break;
      case EnumNotification.MESSAGE_NOTIFICATION:
        if (this._authentication.getLoggedInUser() != null)
        {
          print("coucou2");
            //this.navigatorKey.currentState.pushNamed(_router.routes.notificationsPage).then((_) => Scaffold.of(this._pageContext.item1).showSnackBar(SnackBar(content: Text('une nouvelle notification est arrivée !'))));
        }
        else
          print('PRB AVEC NOTIF RESUME');
        break;
      case EnumNotification.PROJECT_DELETE_NOTIFICATION:
        if (this._authentication.getLoggedInUser() != null)
        {
          print("coucou3");
        }
        else
          print('PRB AVEC NOTIF LAUNCH');
        break;

      default:
        break;
    }

  }

  @override
  void showConnectivityAlert(BuildContext context) {
    this._connectivity.showAlert(context);
  }

  @override
  bool navigateToDynamicPage({@required String route, @required BuildContext context, @required Map<String, dynamic> args}) {
    return _navigateToDynamicPage(route: route, context: context, args: args);
  }

  @override
  Future<void> disconnect() {
    return this._authentication.logOut();
  }

  @override
  String getContactId() {
    return this._chat.getContactId();
    return null;
  }

  @override
  void setContactId(String contactId) {
    this._chat.setContactId(contactId);
    // TODO: implement setContactId
  }

  @override
  void setPageContext(Tuple2<BuildContext, String> newPageContext) {
    this._pageContext = newPageContext;
  }

  @override
  String getToken() {
    return this._notification.getToken();
  }
}

// Main entry of the Application
class PartnershipApp extends StatefulWidget {
  @override
  State<PartnershipApp> createState() {
    return Coordinator();
  }
}