import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

Container commentaryList(context, pid) {
  return Container(
      child: Column(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 3,
          child: StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance
                  .collection('projects')
                  .where('pid', isEqualTo: pid)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError)
                  return new Text('Error: ${snapshot.error}');
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return new Text('Loading...');
                  default:
                    final int messageCount =
                        snapshot.data.documents[0].data['commentaire'].length;
                    return new ListView.builder(
                        itemCount: messageCount,
                        itemBuilder: (_, int index) {
                          final DocumentSnapshot document =
                              snapshot.data.documents[0];
                          return new ListTile(
                            leading: CircleAvatar(
                              radius: 30.0,
                              backgroundImage:
                              NetworkImage("${Uri.decodeComponent(document['commentaire'][index]['picture'])}"),
                              backgroundColor: Colors.transparent,
                            ),
                            subtitle: Text(
                                document['commentaire'][index]['firstName'] +
                                        ' ' +
                                        document['commentaire'][index]
                                            ['lastName'] ??
                                    'user not found',
                                style: new TextStyle(
                                  color: Colors.white54,
                                  fontSize: 15.0,
                                  fontFamily: "Orkney",
                                )),
                            title: Text(
                              document['commentaire'][index]['message'] ??
                                  'title not found',
                              style: new TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                                fontFamily: "Orkney",
                              ),
                            ),
                          );
                        });
                }
              }))
    ],
  ));
}
