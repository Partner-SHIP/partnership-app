import 'package:flutter/material.dart';
import 'package:partnership/coordinator/AppCoordinator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:partnership/utils/Routes.dart';
import 'package:partnership/viewmodel/AViewModelFactory.dart';
import 'package:partnership/viewmodel/GroupsPageViewModel.dart';
import 'package:tuple/tuple.dart';

class ContactsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ContactsPageStateful(),
    );
  }
}


class ContactsPageStateful extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ContactsPageState();
}

class ContactsPageState extends State<ContactsPageStateful> {
  static Coordinator coordinator = new Coordinator();
  String myUid = coordinator.getLoggedInUser().uid;

  void  removeContact(DocumentSnapshot contact){
    /*Firestore.instance.collection("profiles").document(myUid).snapshots().map((convert){
      List list = convert.data[];
    });*/
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
    IRoutes _routing = Routes();
    GroupsPageViewModel viewModel = AViewModelFactory.register[_routing.groupsPage];
    viewModel.setPageContext(Tuple2<BuildContext, String>(context, _routing.groupsPage));
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
                    trailing: new Wrap(
                      children: <Widget>[
                        IconButton(
                            icon: Icon(Icons.message, color: Colors.indigo),
                            onPressed: () {
                              new Coordinator().setContactId(contacts.documents.elementAt(index).documentID);
                              print(new Coordinator().getContactId());
                              viewModel.changeView(
                                  route: _routing.chatScreenPage, widgetContext: context);
                            }),
                        IconButton(
                            icon: Icon(Icons.more_vert, color: Colors.indigo,),
                            onPressed: () => removeContactAlertDialog(contacts.documents.elementAt(index)))
                      ],
                    )

                ),
              );
            }
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return new StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection("profiles").where("contacts", arrayContains: myUid).snapshots(),
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
