import 'package:flutter/material.dart';
import 'package:partnership/coordinator/AppCoordinator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RecContactsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RecContactsPageStateful(),
    );
  }
}


class RecContactsPageStateful extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => RecContactsPageState();
}

class RecContactsPageState extends State<RecContactsPageStateful> {
  static Coordinator coordinator = new Coordinator();
  String myUid = coordinator.getLoggedInUser().uid;
  int lenght_a = -1;

  void  acceptContact(DocumentSnapshot contact){
    Firestore.instance.collection("profiles").document(myUid).updateData({"rec_contacts": FieldValue.arrayRemove([contact["uid"]])}).then((onValue){
      Firestore.instance.collection("profiles").document(myUid).updateData({"contacts": FieldValue.arrayUnion([contact["uid"]])});
    });
    Firestore.instance.collection("profiles").document(contact["uid"]).updateData({"send_contacts": FieldValue.arrayRemove([myUid])}).then((onValue){
      Firestore.instance.collection("profiles").document(contact["uid"]).updateData({"contacts": FieldValue.arrayUnion([myUid])});
    });
  }

  void  removeContact(DocumentSnapshot contact){
    Firestore.instance.collection("profiles").document(myUid).updateData({"rec_contacts": FieldValue.arrayRemove([contact["uid"]])});
    Firestore.instance.collection("profiles").document(contact["uid"]).updateData({"send_contacts": FieldValue.arrayRemove([myUid])});
  }

  Future<void> removeContactAlertDialog(DocumentSnapshot contact) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Ajout de contact'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Voulez vous ajouter ' + contact["firstName"] + " " + contact["lastName"] + " à vos contacts ?"),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Accepter'),
              onPressed: () {
                acceptContact(contact);
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('Refuser'),
              onPressed: () {
                removeContact(contact);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _contactsList(QuerySnapshot contacts) {
    return new Scrollbar (
        child: ListView.builder(
            itemCount: contacts.documents.length,
            itemBuilder: (context, index){
                return Card(
                  borderOnForeground: false,
                  child: ListTile(
                    leading: Icon(Icons.album, size: 50),
                    title: new Text(contacts.documents.elementAt(index)["firstName"]),
                    subtitle: new Text(contacts.documents.elementAt(index)["lastName"]),
                    trailing: IconButton(
                        icon: Icon(Icons.more_vert, color: Colors.indigo,),
                        onPressed: () =>
                            removeContactAlertDialog(
                                contacts.documents.elementAt(index))),
                  ),
                );
            }
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return new StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection("profiles").where("send_contacts", arrayContains: myUid).snapshots(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator(backgroundColor: Colors.deepPurple));
              break;
            case ConnectionState.active:
              return _contactsList(snapshot.data);
              break;
            case ConnectionState.done:
              return Text("DONE");
              break;
            default:
              return Text('Erreur');
          }
        }
    );
  }
}
