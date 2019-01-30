import 'package:flutter/material.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
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

  @override
  Widget build(BuildContext context) {
    this._viewModel.feedGlobalKey(key:_formkey);
    final Size screenSize = MediaQuery.of(context).size;
    Widget form = this.buildForm(context);
    Widget disconnectButton = this.buildDisconnectButton();
    Widget buttonContainer = Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.grey[300],
      body: Container(
          padding: EdgeInsets.all(20.0),
          width: screenSize.width,
          child: Column(
            children: <Widget>[disconnectButton, form],
          )),
    );
    return (buttonContainer);
  }
}
