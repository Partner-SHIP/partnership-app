import 'package:flutter/material.dart';
import 'package:partnership/coordinator/AppCoordinator.dart';
import 'package:partnership/ui/ContactData.dart';
import 'package:partnership/ui/ChatConv.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'ChatPage.dart';
import 'package:partnership/utils/Routes.dart';
import 'package:partnership/viewmodel/AddContactViewModel.dart';
import 'package:partnership/viewmodel/AViewModelFactory.dart';
import 'package:partnership/ui/ChatScreen.dart';

class AddContact extends StatelessWidget {
  IRoutes      _routing = Routes();
  AddContactViewModel get viewModel => AViewModelFactory.register[_routing.addContactPage];
  static const routeName = '/addContact_page';
  @override
  Widget build(BuildContext context) {
    print(viewModel);
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
  static IRoutes      _routing = Routes();
  static AddContactViewModel viewModel = AViewModelFactory.register[_routing.addContactPage];
  static Coordinator user = new Coordinator();
   ContactListN();

  @override
  void initState() {
    // TODO: implement initState
    Firestore.instance.collection('profiles').getDocuments().then((onValue) {
      onValue.documents.forEach((f) {
        setState(() {
          viewModel.addMember(f);
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
        return new _ContactListItemN(viewModel.getListMember()[index],context);
      },
      itemCount: viewModel.getListMember().length,
    );
  }
}

class _ContactListItemN extends ListTile {
  static IRoutes      _routing = Routes();
  static AddContactViewModel viewModel = AViewModelFactory.register[_routing.addContactPage];
  static Coordinator user = new Coordinator();
  _ContactListItemN(var member, BuildContext context)
      : super(
      title: new Text(member.fullName),
      subtitle: new Text(member.email),
      onTap: () {
        user.setContactId(member.uid);
        print(new Coordinator().getContactId());
        viewModel.changeView(route: _routing.chatScreenPage, widgetContext: context);
      },
      leading: new CircleAvatar(child: new Text(member .fullName[0])));
}


