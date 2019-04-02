import 'package:flutter/material.dart';
import 'dart:async';
import 'package:partnership/ui/widgets/LabeledIconButton.dart';
import 'package:partnership/ui/widgets/LabeledIconButtonList.dart';
import 'package:partnership/ui/widgets/LargeButton.dart';
import 'package:partnership/utils/Routes.dart';
import 'package:partnership/viewmodel/AViewModelFactory.dart';
import 'package:partnership/viewmodel/HomePageViewModel.dart';
import 'package:partnership/ui/widgets/StoryList.dart';
import 'package:flushbar/flushbar.dart';
import 'package:partnership/ui/widgets/ConnectivityAlert.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  StoryList     _stories = StoryList();
  IRoutes      _routing = Routes();
  StreamSubscription _connectivitySub;
  Flushbar _connectivityAlert;
  HomePageViewModel get viewModel =>
      AViewModelFactory.register[_routing.homePage];
  bool isOffline = false;
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  StreamSubscription<dynamic> sub;
  //StreamSubscription<QuerySnapshot> user_sub;
  void listencb() {}
  void pausecb() {}
  void resumecb() {}
  void cancelcb() {}

  @override
  void initState(){
    super.initState();
    this._connectivityAlert = connectivityAlertWidget();
    this._connectivitySub = viewModel.subscribeToConnectivity(this.connectivityHandler);
  }

  @override
  void dispose(){
    this._connectivitySub.cancel();
    super.dispose();
  }

  Widget _buildDisconnectButton() {
    return (LargeButton(
      text: "Se déconnecter",
      onPressed: () => this
          .viewModel
          .changeView(route: _routing.loginPage, widgetContext: context, popStack: true),
    ));
  }
  List<Widget> _buildRightDrawerButtons(BuildContext context) {

    LabeledIconButton testButton = LabeledIconButton(
      icon: Icon(Icons.account_circle),
      toolTip: 'Accéder à mon profil',
      onPressed: () => this.viewModel.goToProfile(context),
      text: "Accéder à mon profil",
      fullWidth: true,
    );
    LabeledIconButton disconnectButton = LabeledIconButton(
      icon: Icon(Icons.power_settings_new),
      toolTip: 'Me déconnecter',
      onPressed: () => this.viewModel.disconnect(context),
      text: "Me déconnecter",
      fullWidth: true,
    );
    List<LabeledIconButton> result = new List<LabeledIconButton>();
    result.addAll([
      testButton,
      disconnectButton,
    ]);
    return (result);
  }

  Widget _buildRightDrawer(BuildContext context) {
    BoxDecoration drawerDecoration =
        new BoxDecoration();
    List<LabeledIconButton> buttons = _buildRightDrawerButtons(context);

    LabeledIconButtonList drawerContent = LabeledIconButtonList(childs: buttons, forceFullWidth: true,);
    Widget drawerContentPositioning = Padding(
      child: drawerContent,
      padding: EdgeInsets.only(top: 24.0),
    );
    
    return (Drawer(
      child: Container(
        child: drawerContentPositioning,
        decoration: drawerDecoration,
      ),
    ));
  }
  List<StoryListItem> _debugMockupList() {
    List<StoryListItem> result = List<StoryListItem>();
    result.add(StoryListItem(imgPath: "assets/img/login_logo.png", title: "Titre1", description: "description1",));
    result.add(StoryListItem(imgPath: "assets/img/logo_partnership.png", title: "Titre2", description: "description2 description2 description2 description2 description2 description2 description2 description2 description2",));
    result.add(StoryListItem(imgPath: "assets/blue_texture.jpg", title: "Titre3 Titre3 Titre3 Titre3 Titre3 Titre3", description: "description3",));
    result.add(StoryListItem(imgPath: "", title: "Titre4", description: "description4",));
    result.add(StoryListItem(imgPath: "", title: "Titre5", description: "description5",));
    result.add(StoryListItem(imgPath: "", title: "Titre6", description: "description6",));
    result.add(StoryListItem(imgPath: "", title: "Titre7", description: "description7",));
    result.add(StoryListItem(imgPath: "", title: "Titre8", description: "description8",));
    return (result);
  }
  Container _buildActions(double height) {
    FloatingActionButton createProjectAction = FloatingActionButton(child:Icon(Icons.add), onPressed: () {}, backgroundColor: Colors.grey[700],);
    FloatingActionButton joinProjectAction = FloatingActionButton(child:Icon(Icons.file_download), onPressed: () {}, backgroundColor: Colors.grey[700]);
    Row actionsRow = Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Padding(child: createProjectAction, padding:EdgeInsets.symmetric(horizontal: 5)),
          Padding(child: joinProjectAction, padding: EdgeInsets.only(left: 5)),
        ],
    );
    Container actions = Container(child:actionsRow);
    return (actions);
  }
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double paddedHeight = screenSize.height - 24;
    _stories.updateList(list:_debugMockupList(), height: paddedHeight - 14);
    Widget actions = _buildActions(paddedHeight / 8);
    Widget rightDrawer = _buildRightDrawer(context);
    Widget view = Scaffold(
      floatingActionButton: actions,
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.grey[300],
      endDrawer: rightDrawer,
      body: Container(
          height: screenSize.height,
          padding: EdgeInsets.only(top:24.0, bottom: 0, left: 14, right: 14),
          width: screenSize.width,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[_stories],
          )),
    );
    return (WillPopScope(onWillPop: null, child: view));
  }
  void connectivityHandler(bool value) {
    if (!value)
      this._connectivityAlert.show(context);
    else
    {
      if (this._connectivityAlert.isShowing() && !this._connectivityAlert.isDismissed())
        this._connectivityAlert.dismiss();
    }
  }
}
