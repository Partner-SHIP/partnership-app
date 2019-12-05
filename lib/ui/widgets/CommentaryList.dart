import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

Container commentaryList(context){
  return Container(
    child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height - 110,
                    child: StreamBuilder<QuerySnapshot>(
                        stream: Firestore.instance
                            .collection('projects')
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError)
                            return new Text('Error: ${snapshot.error}');
                          switch (snapshot.connectionState) {
                            case ConnectionState.waiting:
                              return new Text('Loading...');
                            default:
                              return new ListView(
                                children: snapshot.data.documents
                                    .map((DocumentSnapshot document) {
                                     print(document.data['commentaire'][0]['message']);
                                      return new ListTile(
                                        title:  Text(document.data['commentaire'][0]['message'] ?? 'title not found'),
                                        //subtitle: new Text(document['name']),
                                      );
                                    }).toList(),
                              );
                          }
                        }))
      ]
    ,)
  );

}
