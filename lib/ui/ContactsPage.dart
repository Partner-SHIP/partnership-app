import 'package:flutter/material.dart';
import 'package:partnership/coordinator/AppCoordinator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ContactsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ContactsPageState();
}

class ContactsPageState extends State<ContactsPage>{
  static Coordinator coordinator = new Coordinator();
  String myUid = coordinator.getLoggedInUser().uid;

  void  removeContact(DocumentSnapshot contact){
    Firestore.instance.collection("profiles").document(myUid).updateData({"contacts": FieldValue.arrayRemove([contact["uid"]])});
    Firestore.instance.collection("profiles").document(contact["uid"]).updateData({"contacts": FieldValue.arrayRemove([myUid])});
  }

  Future<void> removeContactAlertDialog(DocumentSnapshot contact) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Suppression de contact'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Voulez vous supprimer ' + contact["firstName"] + " " + contact["lastName"] + " de vos contacts ?"),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Oui'),
              onPressed: () {
                removeContact(contact);
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('Non'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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
              trailing: IconButton(
                  icon: Icon(Icons.more_vert, color: Colors.indigo,),
                  onPressed: () => removeContactAlertDialog(contact)),
            ),
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection("profiles").where(
            "contacts", arrayContains: myUid).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError || snapshot.data == null)
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
            default:
              return Text('');
          }
        }
    );
  }
}
