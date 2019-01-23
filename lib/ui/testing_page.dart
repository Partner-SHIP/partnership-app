import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:partnership/style/theme.dart' as Theme;
import 'package:partnership/utils/bubble_indication_painter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:partnership/model/FBStreamWrapper.dart';
import 'package:partnership/coordinator/AppCoordinator.dart';
import 'package:partnership/utils/FBCollections.dart';

class TestingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TestingPageState();
  }
}

class _TestingPageState extends State<TestingPage> {
  bool isOffline = false;
  StreamSubscription<dynamic> sub;
  //StreamSubscription<QuerySnapshot> user_sub;
  void listencb(){}
  void pausecb(){}
  void resumecb(){}
  void cancelcb(){}

  @override
  Widget build(BuildContext context) {
    FBStreamWrapper wrapper = FBStreamWrapper(
        collection: FBCollections.users,
        listenCallback: this.listencb,
        pauseCallback: this.pausecb,
        resumeCallback: this.resumecb,
        cancelCallback: this.cancelcb);
    //sub = Coordinator.connectivity.connectionChange.listen(connectionChanged);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Testing Page'),
        ),
        body: StreamBuilder(
            stream: this.isOffline ? null : wrapper.getStream(),
            builder: (context, snapshot) {
              if (!snapshot.hasData)
                return Text('Loading...');
              return ListView.builder(
                itemExtent: 100.0,
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) => _buildListUser(context, snapshot.data.documents[index]),
              );
            }),
      )
    );
  }
  void connectionChanged(dynamic hasConnection) {
    setState(() {
      this.isOffline = !hasConnection;
      print("[Offline = "+this.isOffline.toString()+"]");
    });
  }
  Widget _buildListUser(BuildContext context, DocumentSnapshot document){
    return ListTile(
      title: Row(
        children: <Widget>[
          Expanded(
            child: Text(document['firstname']+' '+document['lastname']),
          ),
          Container(
            decoration: const BoxDecoration(
              color: Color(0xffddddff)
            ),
            padding: const EdgeInsets.all(10.0),
            child: Text(document['email_adress']),
          ),
          Container(
            decoration: const BoxDecoration(
                color: Color(0xffddddff)
            ),
            padding: const EdgeInsets.all(10.0),
            child: Text(document['password']),
          ),
        ],
      ),
    );
  }
}
