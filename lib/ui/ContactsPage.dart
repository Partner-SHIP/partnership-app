import 'package:flutter/material.dart';
import 'package:partnership/coordinator/AppCoordinator.dart';
import 'package:partnership/style/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ContactsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ContactsPageState();
}

class ContactsPageState extends State<ContactsPage>{
  static Coordinator coordinator = new Coordinator();
  String myUid = coordinator.getLoggedInUser().uid;

  @override
  void initState(){
    super.initState();
  }

  Widget _contactsList(QuerySnapshot contacts){
    return new Scrollbar(
      child: new ListView(
        children: contacts.documents.map((contact) {
          return new Card(
            borderOnForeground: false,
            child: ListTile(
              leading: Icon(Icons.album, size: 50),
              title: new Text(contact["lastName"]),
              subtitle: new Text(contact["firstName"]),
              trailing: IconButton(icon: Icon(Icons.more_vert, color: Colors.indigo,), onPressed: () => print("OK")),
            ),
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection("profiles").where("contacts", arrayContains: myUid).snapshots(),
        initialData: null,
        builder: (context, snapshot){
          if (snapshot.hasError)
            return Text("Nous avont pas trouvé vos contacts :(");
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Text("Pas de connexion");
              break;
            case ConnectionState.waiting:
              return CircularProgressIndicator();
              break;
            case ConnectionState.active:
              return new Scaffold(
                body: _contactsList(snapshot.data),
              );
              break;
            case ConnectionState.done:
              return Text("DONE");
              break;
          }
        }
    );
  }
}
