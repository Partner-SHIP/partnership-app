import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/rendering.dart';

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;


class NotificationsPage extends StatefulWidget {
  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  //final List<Message> notificationsList = [];

  @override
  void initState() {
    //pour les test seulement
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    _firebaseAuth.signInWithEmailAndPassword(
        email: 'jeff@jeff.fr', password: 'coucou');
    //-------------------------------------------------------
    super.initState();
    /*_firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> firebaseNotificationMap) async {
       // mySetState(firebaseNotificationMap);
      },
      onLaunch: (Map<String, dynamic> firebaseNotificationMap) async {
      //  mySetState(firebaseNotificationMap);
      },
      onResume: (Map<String, dynamic> firebaseNotificationMap) async {
      //  mySetState(firebaseNotificationMap);
      },
    );*/
  }

  // void mySetState(Map<String, dynamic> firebaseNotificationMap) {
  //   final notification = firebaseNotificationMap['notification'];
  //   setState(() {
  //     notificationsList.add(
  //     Message(title: notification['title'], body: notification['body']));
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotificationsList(),
    // return SizedBox(
    //   child: ListView(
    //     children: notificationsList.map(buildNotificationTile).toList(),
    //   ),
    // );,
    ); 
  }

  // Widget buildNotificationTile(Message message) {
  //   Firestore.instance
  //       .collection('notifications')
  //       .document()
  //       .setData({'body': 'body'});
  //   return ListTile(
  //     leading: Icon(
  //       Icons.notifications_active,
  //       color: Colors.lightBlue,
  //     ),
  //     title: Text(message.title),
  //     subtitle: Text(message.body),
  //     dense: false,
  //   );
  // }
}

class NotificationsList extends StatelessWidget {
  //il faut récupérer l'id de l'user connecté avec firebase
  String userId = 'e2COxsRabKaD64DIhEp84l5qFNm2';
  @override
  Widget build(BuildContext context) {
    //il faut récupérer l'id de l'user avec firebase
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

  // Future<String> _refreshNotificationsList() async {
  //   //call to getNotif pour refresh la list de notif
  //   print('refreshing listview...');
  // }

  // Future<String> _refreshNotificationsList() async {
  //   //call to getNotif pour refresh la list de notif
  //   print('refreshing listview...');
  //   http.Response response = await http.post(
  //       //Uri.encodeFull removes all the dashes or extra characters present in our Uri
  //       Uri.encodeFull(
  //           "https://us-central1-partnership-app-e8d99.cloudfunctions.net/getNotif"),
  //       headers: {
  //         //if your api require key then pass your key here as well e.g "key": "my-long-key"
  //         "userId": "e2COxsRabKaD64DIhEp84l5qFNm2"
  //       });
  //   if (response != null) {
  //     var toto = jsonDecode(response.statusCode.toString());

  //     // List data = jsonDecode(response.statusCode.toString());
  //     // print(data[1]["title"]);

  //     Map<String, dynamic> data = jsonDecode(response.body);
  //     print(data);

  //     print(('statusCode = ' + toto.toString()));
  //   }
  // }
}
