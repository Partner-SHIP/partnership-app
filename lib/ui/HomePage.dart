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
  StreamSubscription<dynamic> sub;
  //StreamSubscription<QuerySnapshot> user_sub;
  void listencb() {}
  void pausecb() {}
  void resumecb() {}
  void cancelcb() {}

  Widget buildDisconnectButton() {
    return LargeButton(text:"Se déconnecter", onPressed: () => this._viewModel.changeView(route: Routes.loginPage, widgetContext: context),);
/*
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        borderRadius: BorderRadius.circular(30.0),
        shadowColor: Colors.lightBlueAccent.shade100,
        elevation: 5.0,
        child: MaterialButton(
          minWidth: 200.0,
          height: 42.0,
          color: Colors.lightBlueAccent,
          child: Text('Se déconnecter', style: TextStyle(color: Colors.white)),
          onPressed: () => this._viewModel.changeView(route: Routes.loginPage, widgetContext: context),
        ),
      ),
    );
    */
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    Widget disconnectButton = this.buildDisconnectButton();
    Widget buttonContainer = Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.grey[300],
      body: Column(
        children: <Widget>[disconnectButton],
      ),
    );
    Widget page = Container(
      padding: EdgeInsets.all(20.0),
      width: screenSize.width,
      child: buttonContainer
    );
    return (page);
    /*
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
            body: Container(
                child: Column(children: <Widget>[
          Image.asset(
            'assets/img/logoPartnerSHIP.png',
            height: 150,
          ),
          disconnectButton,
        ]))));
        */
  }

  void connectionChanged(dynamic hasConnection) {
    setState(() {
      this.isOffline = !hasConnection;
      print("[Offline = " + this.isOffline.toString() + "]");
    });
  }

  Widget _buildListUser(BuildContext context, DocumentSnapshot document) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Expanded(
            child: Text(document['firstname'] + ' ' + document['lastname']),
          ),
          Container(
            decoration: const BoxDecoration(color: Color(0xffddddff)),
            padding: const EdgeInsets.all(10.0),
            child: Text(document['email_adress']),
          ),
          Container(
            decoration: const BoxDecoration(color: Color(0xffddddff)),
            padding: const EdgeInsets.all(10.0),
            child: Text(document['password']),
          ),
        ],
      ),
    );
  }
}
