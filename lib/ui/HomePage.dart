import 'package:flutter/material.dart';
import 'dart:async';
import 'package:partnership/ui/widgets/LabeledIconButton.dart';
import 'package:partnership/ui/widgets/LabeledIconButtonList.dart';
import 'package:partnership/ui/widgets/LargeButton.dart';
import 'package:partnership/utils/Routes.dart';
import 'package:partnership/viewmodel/AViewModelFactory.dart';
import 'package:partnership/viewmodel/HomePageViewModel.dart';
import 'package:partnership/ui/widgets/StoryList.dart';

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
    this._connectivitySub = viewModel.subscribeToConnectivity(this._connectivityHandler);
  }

  @override
  void dispose(){
    this._connectivitySub.cancel();
    super.dispose();
  }

  Widget buildDisconnectButton() {
    return (LargeButton(
      text: "Se déconnecter",
      onPressed: () => this
          .viewModel
          .changeView(route: _routing.loginPage, widgetContext: context, popStack: true),
    ));
  }
  List<Widget> buildRightDrawerButtons(BuildContext context) {

    LabeledIconButton testButton = LabeledIconButton(
      icon: Icon(Icons.account_circle),
      toolTip: 'Accéder à mon profil',
      onPressed: () => this.viewModel.goToProfile(context),
      text:"Accéder à mon profil",
      fullWidth: true,
    );
    LabeledIconButton disconnectButton = LabeledIconButton(
      icon: Icon(Icons.power_settings_new),
      toolTip: 'Me déconnecter',
      onPressed: () => this.viewModel.disconnect(context),
      text:"Me déconnecter",
      fullWidth: true,
    );
    List<LabeledIconButton> result = new List<LabeledIconButton>();
    result.addAll([
      testButton,
      disconnectButton,
    ]);
    return (result);
  }

  Widget buildRightDrawer(BuildContext context) {
    BoxDecoration drawerDecoration =
        new BoxDecoration();
    List<LabeledIconButton> buttons = buildRightDrawerButtons(context);

    /*
    Widget drawerContent = Container(
        decoration: new BoxDecoration(),
        child: Column(
          children: buttons,
        ));
    */
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
    result.add(StoryListItem(imgPath: "", title: "Titre1", description: "description1",));
    result.add(StoryListItem(imgPath: "", title: "Titre2", description: "description2",));
    result.add(StoryListItem(imgPath: "", title: "Titre3", description: "description3",));
    result.add(StoryListItem(imgPath: "", title: "Titre4", description: "description4",));
    result.add(StoryListItem(imgPath: "", title: "Titre5", description: "description5",));
    result.add(StoryListItem(imgPath: "", title: "Titre6", description: "description6",));
    result.add(StoryListItem(imgPath: "", title: "Titre7", description: "description7",));
    result.add(StoryListItem(imgPath: "", title: "Titre8", description: "description8",));
    return (result);
  } 
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    _stories.updateList(list:_debugMockupList());
    Widget rightDrawer = buildRightDrawer(context);
    Widget view = Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.grey[300],
      endDrawer: rightDrawer,
      body: Container(
          padding: EdgeInsets.all(25.0),
          width: screenSize.width,
          child: Column(
            children: <Widget>[Padding(padding:EdgeInsets.only(top:40), child:_stories)],
          )),
    );
    return (WillPopScope(onWillPop: null, child: view));
  }
  void _connectivityHandler(bool value) {
    if (!value){
      viewModel.showConnectivityAlert(context);
    }
  }
}
