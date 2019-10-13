import 'package:flutter/material.dart';
import 'package:partnership/viewmodel/AViewModelFactory.dart';
import 'package:partnership/viewmodel/ChatPageViewModel.dart';
import 'package:partnership/utils/Routes.dart';
import 'package:partnership/ui/widgets/ThemeContainer.dart';
import 'package:partnership/ui/widgets/PageHeader.dart';
import 'package:partnership/ui/widgets/EndDrawer.dart';
import 'package:partnership/ui/ContactData.dart';
import 'package:partnership/coordinator/AppCoordinator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

/*class ScreenArguments {
  String title;
  String message;
  String conversation;

  ScreenArguments(this.title, this.message, this.conversation);
}*/

class _ContactListItem extends StatelessWidget {
  String title, subtitle, documentID;
  IRoutes _routing = Routes();

  ChatPageViewModel get viewModel =>
      AViewModelFactory.register[_routing.chatPage];

  _ContactListItem(
      this.title, this.subtitle, this.documentID);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(this.title ?? ''),
        subtitle: Text(subtitle ?? ''),
        leading: CircleAvatar(child: Text(this.title ?? '')),
        onTap: () {
          new Coordinator().setContactId(this.documentID);
          print(new Coordinator().getContactId());
          viewModel.changeView(
              route: _routing.chatScreenPage, widgetContext: context);
        });
  }
}

class ContactList extends StatelessWidget {
  IRoutes _routing = Routes();
  ChatPageViewModel get viewModel =>
      AViewModelFactory.register[_routing.chatPage];
  final List<Contact> _contacts;

  ContactList(this._contacts);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: new EdgeInsets.symmetric(vertical: 8.0),
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
              title: Text( _contacts[index].fullName ?? ''),
              subtitle: Text( _contacts[index].message ?? ''),
              leading: CircleAvatar(child: Text( _contacts[index].fullName ?? '')),
              onTap: () {
                new Coordinator().setContactId( _contacts[index].documentID);
                print(new Coordinator().getContactId());
                viewModel.changeView(
                    route: _routing.chatScreenPage, widgetContext: context);
              }),
        );
        return _ContactListItem(
            _contacts[index].fullName,
            _contacts[index].message,
            _contacts[index].documentID);
      },
      itemCount: _contacts.length   ,
    );
  }

/*  List<_ContactListItem> _buildContactList() {
    return _contacts
        .map((contact) => _ContactListItem(contact.fullName, contact.message,
        contact.documentID))
        .toList();
  }*/
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
  ChatPageViewModel _viewModel;

  ContactsPageState(ChatPageViewModel viewModel) : _viewModel = viewModel;

  @override
  void initState() {
    Coordinator user = new Coordinator();
  }

  void setConversationsList(List<DocumentChange> conversations) {
    conversations.forEach((conversation) {
      Firestore.instance
          .collection("profiles")
          .document(conversation.document.documentID)
          .snapshots()
          .listen((onData) {
        if (mounted){
          setState(() {
            if (mounted) {
              kContacts.add(Contact(
                  fullName: onData.data["firstName"],
                  message: "",
                  documentID: conversation.document.documentID));
            }
          });
        }

      });
    });
  }

  @override
  Widget build(BuildContext ctextontext) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection("chat/" + new Coordinator().getLoggedInUser().uid + "/conversations").snapshots(),
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
          body: ContactList(kContacts),
        );
      },
    );
  }
}
