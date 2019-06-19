import 'package:flutter/material.dart';
import 'package:partnership/viewmodel/AViewModelFactory.dart';
import 'package:partnership/viewmodel/ChatPageViewModel.dart';
import 'package:partnership/utils/Routes.dart';
import 'package:partnership/ui/widgets/ThemeContainer.dart';
import 'package:partnership/ui/widgets/PageHeader.dart';
import 'package:partnership/ui/widgets/EndDrawer.dart';
import 'package:partnership/ui/ContactData.dart';
import 'package:partnership/ui/ChatConv.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:partnership/viewmodel/AViewModel.dart';
import 'package:partnership/ui/ChatConv.dart';

// CONTACT_VIEW

class ChatPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ChatPageState();
  }
}

class ChatPageState extends State<ChatPage>{
  IRoutes _routing = Routes();
ChatPageViewModel get viewModel => AViewModelFactory.register[_routing.chatPage];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      endDrawer: Theme(
          data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
          child: buildEndDrawer(context: null, viewModel: viewModel)
      ),
      body: Builder(builder: (BuildContext context){
        return SafeArea(
          top: false,
          child: ThemeContainer(context,
          Column(
            children: <Widget>[
              pageHeader(context, 'Messages'),
              /*Other Widgets Here*/
              Container(child: new ContactsPage(),
              height: MediaQuery.of(context).size.height - 110,
              width: MediaQuery.of(context).size.width),
            ],
          )
          ),
        );
      }),
    );
  }

}

class ScreenArguments {
  String title;
  String message;
  String conversation;

  ScreenArguments(this.title, this.message, this.conversation);
}

class _ContactListItem extends StatelessWidget {
  String title, subtitle, conversation, documentID;

  _ContactListItem(
      this.title, this.subtitle, this.conversation, this.documentID);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(this.title ?? ''),
      subtitle: Text(subtitle ?? ''),
      leading: CircleAvatar(child: Text(this.title ?? '')),
      onTap: () {
        convMembers.dest = this.documentID;
        print(convMembers.dest);
        conversations_path =
            "chat/" + authID + "/conversations/" + this.documentID;
        dest_path = "chat/" + this.documentID + "/conversations/" + authID;
        this.conversation = conversations_path;
        Navigator.pushNamed(context, ChatConv.routeName,
            arguments:
            ScreenArguments(this.title ?? '', this.subtitle ?? '', conversations_path));
      },
    );
  }
}

class ContactList extends StatelessWidget {
  final List<Contact> _contacts;
  final String conversation;

  ContactList(this._contacts, this.conversation);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: new EdgeInsets.symmetric(vertical: 8.0),
      itemBuilder: (context, index) {
        return _ContactListItem(
            _contacts[index].fullName,
            _contacts[index].message,
            this.conversation,
            _contacts[index].documentID);
      },
      itemCount: _contacts.length,
    );
  }

  List<_ContactListItem> _buildContactList() {
    return _contacts
        .map((contact) => _ContactListItem(contact.fullName, contact.message,
        this.conversation, contact.documentID))
        .toList();
  }
}

class ContactsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ContactsPageState();
  }
}

class ContactsPageState extends State<ContactsPage> {
  String conversations_path_db;
  String userID;

  @override
  void initState() {
    authID = "OyhAXtFzv0W9w8049NDRaAaYXFT2";
    convMembers.send = authID;
    //userID = FirebaseAuth.instance.currentUser();
    conversations_path = "chat/" + authID + "/conversations";
    conversations_path_db = conversations_path;
  }

  void setConversationsList(List<DocumentChange> conversations) {
    conversations.forEach((conversation) {
      Firestore.instance
          .collection("profiles")
          .document(conversation.document.documentID)
          .snapshots()
          .listen((onData) {
        setState(() {
          kContacts.add(Contact(
              fullName: onData.data["nickname"],
              message: "",
              documentID: conversation.document.documentID));
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection(conversations_path_db).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasError &&
            snapshot.connectionState == ConnectionState.active &&
            snapshot.hasData) {
          if (snapshot.data.documents.length > kContacts.length)
            setConversationsList(snapshot.data.documentChanges);
          snapshot.data.documentChanges.forEach((f) {
            if (f.type != DocumentChangeType.removed && kContacts.length > 0) {
              List messages = f.document.data["messages"];
              kContacts[kContacts.indexWhere((contacts) =>
              contacts.documentID == f.document.documentID)]
                  .message = messages.last["message"];
            }
          });
        }
        return Scaffold(
          body: ContactList(kContacts, conversations_path_db),
          floatingActionButton: FloatingActionButton(
              child: Text('New'),
              onPressed: () => Navigator.of(context).pushNamed('/addContact_page')),
        );
      },
    );
  }
}
