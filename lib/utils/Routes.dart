import 'package:flutter/material.dart';
import 'package:partnership/ui/HomePage.dart';
import 'package:partnership/ui/LoginPage.dart';
import 'package:partnership/ui/SignInPage.dart';
import 'package:partnership/ui/SignUpPage.dart';
import 'package:partnership/ui/ProfilePage.dart';
import 'package:partnership/ui/ProjectDescriptionPage.dart';
import 'package:partnership/ui/ProjectBrowsingPage.dart';
import 'package:partnership/ui/CreationPage.dart';
import 'package:partnership/ui/IdeaPage.dart';
import 'package:partnership/ui/ChatPage.dart';
import 'package:partnership/ui/SearchMemberPage.dart';
import 'package:partnership/ui/widgets/NotificationsPage.dart';
import 'package:path/path.dart';
import 'package:partnership/ui/ChatConv.dart';
import 'package:partnership/ui/ChatPage.dart';
import 'package:partnership/ui/AddContact.dart';
import 'package:partnership/ui/NavigPage.dart';

enum DynamicRoutesEnum {
  projectDescriptionPage,
  chatConvPage,
}

enum RoutesEnum {
  loginPage,
  signInPage,
  signUpPage,
  profilePage,
  testingPage,
  homePage,
  projectDescriptionPage,
  projectBrowsingPage,
  creationPage,
  ideaPage,
  chatPage,
  addContactPage,
  chatConvPage,
  searchMemberPage,
  notificationsPage,
  navigPage,
}

abstract class  IRoutes {
  String        get loginPage;
  String        get signInPage;
  String        get signUpPage;
  String        get profilePage;
  String        get testingPage;
  String        get creationPage;
  String        get ideaPage;
  String        get homePage;
  String        get projectDescriptionPage;
  String        get projectBrowsingPage;
  String        get chatPage;
  String        get searchMemberPage;
  String        get notificationsPage;
  String        get addContactPage;
  String        get chatConvPage;
  String        get navigPage;

  dynamic            routeMap();
  Map<String, Widget> materialPagesMap();
  List<String>   routeList();
  Map<String, RoutesEnum> routeEnumMap();
  List<String> dynamicRouteList();
  Map<String, DynamicRoutesEnum> dynamicRouteEnumMap();
  dynamic getDynamicPage({@required String route, @required Map<String, dynamic> args});
}

class Routes implements IRoutes {
  static final Routes _instance = Routes._internal();
  factory Routes() {
    return _instance;
  }
  Routes._internal();

  /*
  *  Static Routes
  */
  static const String _loginPage = "/login_page";
  static const String _signInPage = "/signin_page";
  static const String _signUpPage = "/signup_page";
  static const String _profilePage = "/profile_page";
  static const String _testingPage = "/testing_page";
  static const String _homePage = "/home_page";
  static const String _projectBrowsingPage = "/project_browsing_page";
  static const String _creationPage = "/creation_page";
  static const String _ideaPage = "/idea_page";
  static const String _chatPage = "/chat_page";
  static const String _searchMemberPage = "/search_member_page";
  static const String _notificationsPage = "/notifications_page";
  static const String _addContactPage = "/addContact_page";
  static const String _navigPage = "/navig_page";

  /*
  * Dynamic Routes
  */
  static const String _projectDescriptionPage = "/project_description_page";
  static const String _chatConvPage = "/chatConv_page";

  Map<String, Widget> _materialPagesMap() {
    return {
      _loginPage:                 LoginPage(),
      _signInPage:                SignInPage(),
      _signUpPage:                SignUpPage(),
      _profilePage:               ProfilePage(),
      _homePage:                  HomePage(),
      _projectBrowsingPage:       ProjectBrowsingPage(),
      _creationPage:              CreationPage(),
      _ideaPage:                  IdeaPage(),
      _chatPage:                  ChatPage(),
      _navigPage:                  NavigPage(),
      _searchMemberPage:          SearchMemberPage(),
      _notificationsPage:         NotificationsPage(),
    };
  }

  dynamic _routeMap() {
    return {
      _loginPage:                 (BuildContext context) => LoginPage(),
      _signInPage:                (BuildContext context) => SignInPage(),
      _signUpPage:                (BuildContext context) => SignUpPage(),
      _profilePage:               (BuildContext context) => ProfilePage(),
      _homePage:                  (BuildContext context) => HomePage(),
      _projectBrowsingPage:       (BuildContext context) => ProjectBrowsingPage(),
      _creationPage:              (BuildContext context) => CreationPage(),
      _ideaPage:                  (BuildContext context) => IdeaPage(),
      _chatPage:                  (BuildContext context) => ChatPage(),
      _searchMemberPage:          (BuildContext context) => SearchMemberPage(),
      _notificationsPage:         (BuildContext context) => NotificationsPage(),
      _addContactPage:            (BuildContext context) => AddContact(),
      _navigPage:                 (BuildContext context) => NavigPage(),
    };  
  }
  Map<String, RoutesEnum> _routeEnumMap() {
    return <String, RoutesEnum>{
      _loginPage:               RoutesEnum.loginPage,
      _signInPage:              RoutesEnum.signInPage,
      _signUpPage:              RoutesEnum.signUpPage,
      _profilePage:             RoutesEnum.profilePage,
      _homePage:                RoutesEnum.homePage,
      _projectBrowsingPage:     RoutesEnum.projectBrowsingPage,
      _creationPage:            RoutesEnum.creationPage,
      _ideaPage:                RoutesEnum.ideaPage,
      _chatPage:                RoutesEnum.chatPage,
      _searchMemberPage:        RoutesEnum.searchMemberPage,
      _notificationsPage:       RoutesEnum.notificationsPage,
      _addContactPage:          RoutesEnum.addContactPage,
      _navigPage:               RoutesEnum.navigPage,
    };
  }

   List<String> _routesList() => <String>[
     _loginPage,
     _signInPage,
     _signUpPage,
     _profilePage,
     _homePage,
     _projectBrowsingPage,
     _creationPage,
     _ideaPage,
     _chatPage,
     _searchMemberPage,
     _notificationsPage,
     _addContactPage,
     _navigPage,
   ];

  dynamic _getDynamicPage({@required String route, @required Map<String, dynamic> args}){
    var view;
    switch (route){
      case _projectDescriptionPage:
        view = ProjectDescriptionPage(args);
        break;
      case _chatConvPage:
        view = ChatConv(args);
        break;
      default:
        throw Exception('Dynamic Page not found');
        break;
    }
    return view;
  }

  Map<String, DynamicRoutesEnum> _dynamicRoutesEnumMap(){
    return <String, DynamicRoutesEnum>{
      _projectDescriptionPage: DynamicRoutesEnum.projectDescriptionPage,
      _chatConvPage: DynamicRoutesEnum.chatConvPage,
    };
  }

  List<String> _dynamicRoutesList() => <String>[
    _projectDescriptionPage,
    _chatConvPage,
  ];

  @override
  String get loginPage => _loginPage;

  @override
  String get profilePage => _profilePage;

  @override
  String get signInPage => _signInPage;

  @override
  String get signUpPage => _signUpPage;

  @override
  String get testingPage => _testingPage;

  @override
  String get homePage => _homePage;

  @override
  String get projectDescriptionPage => _projectDescriptionPage;

  @override
  String get projectBrowsingPage => _projectBrowsingPage;

  @override
  String get creationPage => _creationPage;

  @override
  String get ideaPage => _ideaPage;

  @override
  String get chatPage => _chatPage;

  @override
  String get searchMemberPage => _searchMemberPage;

  @override
  String get notificationsPage => _notificationsPage;

  @override
  String get addContactPage => _addContactPage;

  @override
  String get chatConvPage => _chatConvPage;

  @override
  String get navigPage => _navigPage;


  @override
  List<String> routeList() {
    return this._routesList();
  }

  @override
  dynamic routeMap() {
    return this._routeMap();
  }

  @override
  Map<String, RoutesEnum> routeEnumMap() {
    return this._routeEnumMap();
  }

  @override
  Map<String, DynamicRoutesEnum> dynamicRouteEnumMap() {
    return this._dynamicRoutesEnumMap();
  }

  @override
  List<String> dynamicRouteList() {
    return this._dynamicRoutesList();
  }

  @override
  dynamic getDynamicPage({String route, Map<String, dynamic> args}) {
    return this._getDynamicPage(route: route, args: args);
  }

  @override
  Map<String, Widget> materialPagesMap() {
    return this._materialPagesMap();
  }
}