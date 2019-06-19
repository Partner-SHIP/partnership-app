import 'package:flutter/material.dart';
import 'package:partnership/ui/ContactData.dart';
import 'package:partnership/ui/ChatConv.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'ChatPage.dart';
import 'package:partnership/utils/Routes.dart';
import 'package:partnership/viewmodel/AddContactViewModel.dart';
import 'package:partnership/viewmodel/AViewModelFactory.dart';
import 'package:partnership/ui/ChatConv.dart';
import 'package:partnership/ui/ChatScreen.dart';

class NewContactsPage extends StatelessWidget {
  IRoutes      _routing = Routes();
  AddContactViewModel get viewModel => AViewModelFactory.register[_routing.addContactPage];
  static const routeName = '/addContact_page';
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Contacts"),
        ),
        body: new Contact2());
  }
}

class Contact2 extends StatefulWidget {
  @override
  State createState() => new ContactListN(/*kContacts*/);
}

class ContactListN extends State<Contact2> {
  List<Member> members = new List();
  int i = 0;

  // ContactListN();

  @override
  void initState() {
    // TODO: implement initState
    Firestore.instance.collection('profiles').getDocuments().then((onValue) {
      onValue.documents.forEach((f) {
        setState(() {
          if (f.data['nickname'] != null) {
            members.add(Member(
                fullName: f.data['nickname'], email: '', uid: f.data['uid']));
          }
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      padding: new EdgeInsets.symmetric(vertical: 8.0),
      itemBuilder: (context, index) {
        return new _ContactListItemN(members[index], context);
      },
      itemCount: members.length,
    );
  }
}

class _ContactListItemN extends ListTile {
  _ContactListItemN(Member member, BuildContext context)
      : super(
      title: new Text(member.fullName),
      subtitle: new Text(member.email),
      onTap: () {
        convMembers.dest = authID;
        convMembers.send = member.uid;
        conversations_path =
            "chat/" + authID + "/conversations/" + member.uid;
        dest_path = "chat/" + member.uid + "/conversations/" + authID;
        print("TEST    " + conversations_path);
        Navigator.pushNamed(
            context, ChatConv.routeName,
            arguments:
            ScreenArguments(member.fullName, "", conversations_path)
        );
      },
      leading: new CircleAvatar(child: new Text(member.fullName[0])));
}

class Member {
  final String fullName;
  final String email;
  final String uid;

  const Member({this.fullName, this.email, this.uid});
}
