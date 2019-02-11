import 'package:flutter/material.dart';
import 'dart:async';
import 'package:partnership/ui/widgets/LabeledIconButton.dart';
import 'package:partnership/ui/widgets/LargeButton.dart';
import 'package:partnership/utils/Routes.dart';
import 'package:partnership/viewmodel/AViewModelFactory.dart';
import 'package:partnership/viewmodel/HomePageViewModel.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  HomePageViewModel _viewModel = AViewModelFactory.register[Routes.homePage];
  bool isOffline = false;
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  StreamSubscription<dynamic> sub;
  //StreamSubscription<QuerySnapshot> user_sub;
  void listencb() {}
  void pausecb() {}
  void resumecb() {}
  void cancelcb() {}

  Widget buildDisconnectButton() {
    return (LargeButton(
      text: "Se déconnecter",
      onPressed: () => this
          ._viewModel
          .changeView(route: Routes.loginPage, widgetContext: context),
    ));
  }

  Widget buildCreateProjectButton() {
    return (LargeButton(
        text: 'Je créé un projet',
        onPressed: () => _viewModel.attemptCreateProject(context: context)));
  }

  Widget buildForm(BuildContext context) {
    Widget signInButton = buildCreateProjectButton();
    final Size screenSize = MediaQuery.of(context).size;

    return (Container(
        padding: EdgeInsets.all(20.0),
        width: screenSize.width,
        child: Form(
          key: this._viewModel.formKey,
          child: ListView(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: <Widget>[
              TextFormField(
                  validator: (value) => _viewModel.validateName(value),
                  keyboardType: TextInputType
                      .emailAddress, // Use email input type for emails.
                  decoration: InputDecoration(
                    icon: Icon(Icons.email, color: Colors.grey),
                    hintText: 'Nom du groupe à créer',
                  )),
              Container(
                width: screenSize.width,
                child: signInButton,
              )
            ],
          ),
        )));
  }

  List<Widget> buildRightDrawerButtons(BuildContext context) {

    Widget testButton = LabeledIconButton(
      icon: Icon(Icons.account_circle),
      toolTip: 'Accéder à mon profil',
      onPressed: () {},
      text:"Accéder à mon profil",
    );
    Widget disconnectButton = LabeledIconButton(
      icon: Icon(Icons.power_settings_new),
      toolTip: 'Me déconnecter',
      onPressed: () {},
      text:"Me déconnecter",
    );
    List<Widget> result = new List<Widget>();
    result.addAll([
      testButton,
      disconnectButton
    ]);
    return (result);
  }

  Widget buildRightDrawer(BuildContext context) {
    BoxDecoration drawerDecoration =
        new BoxDecoration(color: Colors.lightBlueAccent.shade50);
    List<Widget> buttons = buildRightDrawerButtons(context);

    Widget drawerContent = Container(
        decoration: new BoxDecoration(),
        child: Column(
          children: buttons,
        ));

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

  @override
  Widget build(BuildContext context) {
    this._viewModel.feedGlobalKey(key: _formkey);
    final Size screenSize = MediaQuery.of(context).size;
    Widget form = this.buildForm(context);
    Widget disconnectButton = this.buildDisconnectButton();
    Widget rightDrawer = buildRightDrawer(context);
    Widget view = Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.grey[300],
      endDrawer: rightDrawer,
      body: Container(
          padding: EdgeInsets.all(20.0),
          width: screenSize.width,
          child: Column(
            children: <Widget>[disconnectButton, form],
          )),
    );
    return (WillPopScope(onWillPop: null, child: view));
  }
}
