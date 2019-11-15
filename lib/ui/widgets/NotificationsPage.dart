import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/rendering.dart';
import 'package:partnership/ui/widgets/PageHeader.dart';
import 'package:partnership/viewmodel/AViewModelFactory.dart';
import 'package:tuple/tuple.dart';

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:partnership/coordinator/AppCoordinator.dart';
import 'package:partnership/viewmodel/AViewModel.dart';
import 'package:partnership/ui/widgets/EndDrawer.dart';
import 'package:partnership/ui/widgets/ThemeContainer.dart';
import 'package:partnership/viewmodel/NotificationsPageViewModel.dart';
import 'package:partnership/utils/Routes.dart';

class NotificationsPage extends StatefulWidget {
  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  IRoutes _routing = Routes();
  NotificationsPageViewModel get viewModel => AViewModelFactory.register[_routing.notificationsPage];
  //final List<Message> notificationsList = [];

  @override
  void initState() {
    //pour les test seulement
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    /*
    _firebaseAuth.signInWithEmailAndPassword(
        email: 'jeff@jeff.fr', password: 'coucou');
    //-------------------------------------------------------
    */
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
          builder: (BuildContext context) {
            viewModel.setPageContext(Tuple2<BuildContext, String>(context, _routing.notificationsPage));
            return SafeArea(
                top: false,
                child: ThemeContainer(
                  context,
                  Column(
                    children: <Widget>[
                      pageHeader(context, 'mes notifications'),
                      Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height - 110,
                          child: NotificationsList(viewModel.loggedInUser().uid))
                    ],
                  ),
                )
            );
          }
      ),
      endDrawer: Theme(
        data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
        child: buildEndDrawer(context: context, viewModel: viewModel, notification: false),
      ),
      // return SizedBox(
      //   child: ListView(
      //     children: notificationsList.map(buildNotificationTile).toList(),
      //   ),
      // );,
    );
  }
}

class NotificationsList extends StatelessWidget {

  final String userId;

  NotificationsList(String uid): userId = uid;

  //il faut récupérer l'id de l'user connecté avec firebase
  //String userId = 'e2COxsRabKaD64DIhEp84l5qFNm2';

  @override
  Widget build(BuildContext context) {
    print('onche = ' + userId);
    //il faut récupérer l'id de l'user avec firebase
    //print('onche onche = ' + userId);
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection('notifications')
          .where('userId', isEqualTo: userId)
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(child: Text('Loading...'));
          default:
            return ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children:
                  snapshot.data.documents.map((DocumentSnapshot document) {
                return GestureDetector(
                  child: Container(
                    decoration:
                        BoxDecoration(border: Border(bottom: BorderSide())),
                    child: ListTile(
                      onTap: () {
                        print('onTapped notification ListTile # ' +
                            document.documentID);
                        //click qui navigate sur la page en question
                      },
                      leading: GestureDetector(
                        onTap: () {
                          print('onTapped notification Icon # ' +
                              document.documentID);
                          //click qui doit changer sur firestore le champs isRead de la notification de false à true
                          //document.documentID pour avoir l'id du document à changer sur Firestore
                          _setIsReadToTrue(document);
                        },
                        child: Icon(
                          Icons.notifications_active,
                          color: document['isRead'] == false
                              ? Colors.lightBlue
                              : Colors.grey,
                        ),
                      ),
                      trailing: GestureDetector(
                          child: Icon(
                            Icons.delete,
                            color: Colors.red[400],
                          ),
                          onTap: () {
                            print(
                                'onTapped Trash icon # ' + document.documentID);
                            //click qui fait apparaître une ou deux options (ex: supprimer la notif, l'archiver, etc...)
                            _deleteNotification(document);
                          }),
                      title: Text(
                        document['title'],
                        style: TextStyle(color: Colors.grey, fontStyle: null),
                      ),
                      subtitle: Text(
                        document['body'],
                        style: TextStyle(
                            color: Colors.white70, fontStyle: FontStyle.italic),
                      ),
                    ),
                  ),
                );
              }).toList(),
            );
        }
      },
    );
  }

  void _deleteNotification(DocumentSnapshot document) {
    Firestore.instance
        .collection('notifications')
        .document(document.documentID)
        .delete();
    print('Deleted notification # ' + document.documentID);
  }

  void _setIsReadToTrue(DocumentSnapshot document) {
    if (document.data['isRead'] != true) {
      Firestore.instance
          .collection('notifications')
          .document(document.documentID)
          .updateData({
        'isRead': true,
      });
      print('setIsReadToTrue on #' + document.documentID);
    }
  }

}
