import 'package:flutter/material.dart';
import 'package:partnership/viewmodel/AViewModelFactory.dart';
import 'package:partnership/viewmodel/ChatPageViewModel.dart';
import 'package:partnership/utils/Routes.dart';
import 'package:partnership/ui/widgets/ThemeContainer.dart';
import 'package:partnership/ui/widgets/EndDrawer.dart';
import 'package:partnership/ui/ContactData.dart';
import 'package:partnership/coordinator/AppCoordinator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tuple/tuple.dart';

// CONTACT_VIEW

class ChatPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ChatPageState();
  }
}

class ChatPageState extends State<ChatPage> {
  IRoutes _routing = Routes();

  ChatPageViewModel get viewModel =>
      AViewModelFactory.register[_routing.chatPage];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      // appBar: PreferredSize(child: ThemeContainer(context, pageHeader(context, "")), preferredSize: Size(100,100)),
      endDrawer: Theme(
          data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
          child: buildEndDrawer(context: context, viewModel: viewModel, chat: false)),
      body: Builder(builder: (BuildContext context) {
        viewModel.setPageContext(Tuple2<BuildContext, String>(context, _routing.chatPage));
        return SafeArea(
          top: false,
          child: ThemeContainer(
              context,
              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  //  pageHeader(context, 'Messages'),
                  //Other Widgets Here*/
                  Container(
                      child: new Contacts(viewModel),
                      height: MediaQuery.of(context).size.height - 158,
                      width: MediaQuery.of(context).size.width),
                ],
              )),
        );
      }),
    );
  }
}

class Contacts extends StatefulWidget {
  ChatPageViewModel _viewModel;

  Contacts(ChatPageViewModel viewmodel) : _viewModel = viewmodel;

  @override
  State<StatefulWidget> createState() {
    return ContactsPageState(_viewModel);
  }
}

class ContactsPageState extends State<Contacts> {
  IRoutes _routing = Routes();
  ChatPageViewModel get viewModel =>
      AViewModelFactory.register[_routing.chatPage];
  ContactsPageState(ChatPageViewModel viewModel);

  @override
  void initState() {
    Coordinator user = new Coordinator();
  }

  Widget conversationList(QuerySnapshot contacts){
    IRoutes _routing = Routes();
    return new Scrollbar (
        child: ListView.builder(
            itemCount: contacts.documents.length,
            itemBuilder: (context, index){
              List list = contacts.documents.elementAt(index).data["messages"];
              return Card(
                child: ListTile(
                  title: Text(contacts.documents.elementAt(index).data["contactName"] ?? ''),
                  subtitle: Text(list.last["message"] ?? ''),
                  leading: CircleAvatar(child: Text(list.last["name"][0] ?? '')),
                  onTap: () {
                    new Coordinator().setContactId(contacts.documents.elementAt(index).documentID);
                    print(new Coordinator().getContactId());
                    viewModel.changeView(
                        route: _routing.chatScreenPage, widgetContext: context);
                  },
                  trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.indigo,),
                      onPressed: () {
                        Firestore.instance.collection("chat/" +  new Coordinator().getLoggedInUser().uid + "/conversations").document(contacts.documents.elementAt(index).documentID).delete();
                        Firestore.instance.collection("chat/" + contacts.documents.elementAt(index).documentID + "/conversations").document(new Coordinator().getLoggedInUser().uid).delete();
                      }),
                ),
              );
            }
        )
    );
  }

  @override
  Widget build(BuildContext ctextontext) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection("chat/" + new Coordinator().getLoggedInUser().uid + "/conversations").snapshots(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator(backgroundColor: Colors.deepPurple));
            break;
          case ConnectionState.active:
            //snapshot.data.documents.elementAt(0);
          //snapshot.data.documents.elementAt(0).data.
            /*List messages = f.document.data["messages"];
            kContacts[kContacts.indexWhere((contacts) =>
            contacts.documentID == f.document.documentID)]
                .message = messages.last["message"];*/
            if (snapshot.data.documents.length != 0)
              return conversationList(snapshot.data);
            else
              return Center(child: Text("Aucune conversation"));
            break;
          case ConnectionState.done:
            return Text("DONE");
            break;
          default:
            return Text('Erreur');
        }
      },
    );
  }
}
