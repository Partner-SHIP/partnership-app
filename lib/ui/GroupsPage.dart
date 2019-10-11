import 'package:flutter/material.dart';
import 'package:partnership/viewmodel/ChatMessageViewModel.dart';
import 'package:partnership/viewmodel/AViewModelFactory.dart';
import 'package:partnership/utils/Routes.dart';

import 'package:partnership/viewmodel/ChatPageViewModel.dart';
import 'package:partnership/utils/Routes.dart';
import 'package:partnership/ui/widgets/ThemeContainer.dart';
import 'package:partnership/ui/widgets/PageHeader.dart';
import 'package:partnership/ui/widgets/EndDrawer.dart';
import 'package:partnership/ui/ContactData.dart';
import 'package:partnership/coordinator/AppCoordinator.dart';
import 'package:partnership/ui/GroupsChat.dart';
import 'package:partnership/viewmodel/GroupsPageViewModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GroupsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GroupsPageStateful(),
    );
  }
}

class GroupsPageStateful extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => GroupsPageState();
}

class GroupsPageState extends State<GroupsPageStateful> {
  IRoutes _routing = Routes();
  GroupsPageViewModel get viewModel => AViewModelFactory.register[_routing.groupsPage];
  static Coordinator coordinator = new Coordinator();
  String myUid = coordinator.getLoggedInUser().uid;

  Widget _contactsList(QuerySnapshot contacts){
    return new Scrollbar (
        child: ListView.builder(
            itemCount: contacts.documents.length,
            itemBuilder: (context, index){
              return Card(
                borderOnForeground: false,
                child: ListTile(
                  leading: Icon(Icons.album, size: 50),
                  title: new Text(contacts.documents.elementAt(index)["name"]),
                  subtitle: new Text(contacts.documents.elementAt(index)["name"]),
                  trailing: IconButton(
                      icon: Icon(Icons.message, color: Colors.indigo,),
                      onPressed: () {
                        new Coordinator().setContactId(contacts.documents.elementAt(index).documentID);
                        print(new Coordinator().getContactId());
                        viewModel.changeView(
                            route: _routing.groupsChat, widgetContext: context);
                      }),
                ),
              );
            }
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return new StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection("projects/").where("joined_uid", arrayContains: myUid).snapshots(),
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
