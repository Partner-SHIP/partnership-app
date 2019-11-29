import 'package:flutter/material.dart';
import 'package:partnership/ui/ChatScreen.dart';
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
import 'package:partnership/ui/GroupsPage.dart';
import 'package:partnership/ui/SearchMemberPage.dart';
import 'package:partnership/ui/widgets/NotificationsPage.dart';
import 'package:partnership/ui/ProjectManagementPage.dart';
import 'package:partnership/ui/ProjectManagementTabs/ProjectManagementTabs.dart';
import 'package:partnership/ui/NavigPage.dart';
import 'package:partnership/ui/GroupsChat.dart';

enum DynamicRoutesEnum {
  projectDescriptionPage,
  chatConvPage,
  projectManagementTabs
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
  chatScreenPage,
  chatConvPage,
  searchMemberPage,
  notificationsPage,
  groupsPage,
  navigPage,
  groupsChat,
  projectManagement,
  projectManagementTabs
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
  String        get chatScreenPage;
  String        get searchMemberPage;
  String        get notificationsPage;
  String        get chatConvPage;
  String        get navigPage;
  String        get groupsPage;
  String        get groupsChat;
  String        get projectManagement;
  String        get projectManagementTabs;

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
  static const String _chatScreenPage = "/chatScreen_page";
  static const String _searchMemberPage = "/search_member_page";
  static const String _notificationsPage = "/notifications_page";
  static const String _navigPage = "/navig_page";
  static const String _groupsPage = "/groups_page";
  static const String _groupsChat = "/groups_chat";
  static const String _projectManagement = "/project_management";

  /*
  * Dynamic Routes
  */
  static const String _projectDescriptionPage = "/project_description_page";
  static const String _chatConvPage = "/chatConv_page";
  static const String _projectManagementTabs = "/project_management_tabs";

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
      _groupsPage:                GroupsPage(),
      _navigPage:                 NavigPage(),
      _groupsChat:                GroupsPage(),
      _searchMemberPage:          SearchMemberPage(),
      _notificationsPage:         NotificationsPage(),
      _projectManagement:         ProjectManagementPage()
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
      _chatScreenPage:            (BuildContext context) => ChatScreen(),
      _searchMemberPage:          (BuildContext context) => SearchMemberPage(),
      _notificationsPage:         (BuildContext context) => NotificationsPage(),
      _navigPage:                 (BuildContext context) => NavigPage(),
      _groupsPage:                (BuildContext context) => GroupsPage(),
      _groupsChat:                (BuildContext context) => GroupsChat(),
      _projectManagement:         (BuildContext context) => ProjectManagementPage(),
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
      _chatScreenPage:          RoutesEnum.chatScreenPage,
      _searchMemberPage:        RoutesEnum.searchMemberPage,
      _notificationsPage:       RoutesEnum.notificationsPage,
      _navigPage:               RoutesEnum.navigPage,
      _groupsPage:              RoutesEnum.groupsPage,
      _groupsChat:              RoutesEnum.groupsChat,
      _projectManagement:       RoutesEnum.projectManagement
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
     _chatScreenPage,
     _searchMemberPage,
     _notificationsPage,
     _navigPage,
     _groupsPage,
     _groupsChat,
     _projectManagement,
   ];

  dynamic _getDynamicPage({@required String route, @required Map<String, dynamic> args}){
    var view;
    switch (route){
      case _projectDescriptionPage:
        view = ProjectDescriptionPage(args);
        break;
      case _chatPage:
        view = ChatPage();
        break;
      case _projectManagementTabs:
        view = ProjectManagementTabs(args);
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
      _projectManagementTabs: DynamicRoutesEnum.projectManagementTabs,
    };
  }

  List<String> _dynamicRoutesList() => <String>[
    _projectDescriptionPage,
    _chatConvPage,
    _projectManagementTabs,
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

  String get projectManagementTabs => _projectManagementTabs;

  @override
  String get projectBrowsingPage => _projectBrowsingPage;

  @override
  String get creationPage => _creationPage;

  @override
  String get ideaPage => _ideaPage;

  @override
  String get chatPage => _chatPage;

  @override
  String get chatScreenPage => _chatScreenPage;

  @override
  String get searchMemberPage => _searchMemberPage;

  @override
  String get notificationsPage => _notificationsPage;

  @override
  String get chatConvPage => _chatConvPage;

  @override
  String get navigPage => _navigPage;

  @override
  String get groupsPage => _groupsPage;

  @override
  String get groupsChat => _groupsChat;

  @override
  String get projectManagement => _projectManagement;

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