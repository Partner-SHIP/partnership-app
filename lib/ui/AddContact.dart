import 'package:flutter/material.dart';
import 'package:partnership/coordinator/AppCoordinator.dart';
import 'package:partnership/ui/ContactData.dart';
import 'package:partnership/ui/ChatConv.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:partnership/ui/widgets/EndDrawer.dart';
import 'package:partnership/ui/widgets/PageHeader.dart';
import 'package:partnership/ui/widgets/ThemeContainer.dart';
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
    return new Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.indigo,
          title: new Text("Nouveau",
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
        endDrawer: Theme(
          data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
          child: buildEndDrawer(context: context, viewModel: viewModel, chat: false)
        ),
        body: ThemeContainer(
          context,
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                //pageHeader(context, 'Nouveau'),
                /*Other Widgets Here*/
                Container(
                    child: new Contact2(),
                    height: MediaQuery.of(context).size.height - 128,
                    width: MediaQuery.of(context).size.width),
              ],
            )
        )
    );
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
    /* Firestore.instance.document('profiles/' + new Coordinator().getLoggedInUser().uid).snapshots().listen((onData){
      List myContacts = onData.data["myContacts"];
      myContacts.forEach((f){
        Firestore.instance.document('profiles/' + f).snapshots().listen((onData){
          var name = onData.data['firstName'];
         // myContacts.forEach((f){
            print(name);
            setState(() {
              viewModel.addMember(onData);
            });
          //});
        });

      });
      print("finish");
    }); */

    // ENLEVER LE COMMENTAIRE
    Firestore.instance.collection('profiles').getDocuments().then((onValue) {
      onValue.documents.forEach((f) {
        setState(() {
          if (onValue.documents.length > viewModel.getListMember().length)
          viewModel.addMember(f);
        });
      });
    });
    super.initState();
  }

  Widget contact(var member, BuildContext context, Coordinator user, AddContactViewModel viewModel, IRoutes _routing, int index) {
    ///IRoutes      _routing = Routes();
    return new Opacity(opacity: 0.50,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Opacity(opacity: 1,
            child: Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child:  CircleAvatar(child: new Text(
                    member.fullName[0],
                    style: TextStyle(color: Colors.white),
                  )),
                ),
                Text(member.fullName),
                Spacer(),
                /*IconButton(
                    icon: Icon(Icons.delete),
                    tooltip: 'Increase volume by 10',
                    onPressed: () {
   //                   supContact(context, member.fullName, viewModel, index);
                    }),*/
                IconButton(
                    icon: Icon(Icons.message),
                    tooltip: 'Increase volume by 10',
                    alignment: Alignment.centerRight,
                    onPressed: () {
                      user.setContactId(member.uid);
                      viewModel.changeView(route: _routing.chatScreenPage, widgetContext: context);
                    }),
              ],
            ),
          ),)
        ,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scrollbar(
        child: ListView.builder(
          padding: new EdgeInsets.symmetric(vertical: 8.0),
          itemBuilder: (context, index) {
            return contact(
                viewModel.getListMember()[index], context, user, viewModel,
                _routing, index);
            //_ContactListItemN(viewModel.getListMember()[index],context);
          },
          itemCount: viewModel.getListMember().length,
        )
    );
  }
}

class _ContactListItemN extends ListTile {
  static IRoutes      _routing = Routes();
  static AddContactViewModel viewModel = AViewModelFactory.register[_routing.addContactPage];
  static Coordinator user = new Coordinator();
  _ContactListItemN(var member, BuildContext context)
      : super(
      title: new Text(
          member.fullName,
        style: TextStyle(color: Colors.white),
      ),
      subtitle: new Text(
          member.email,
        style: TextStyle(color: Colors.white),
      ),
      onTap: () {
        user.setContactId(member.uid);
        print(new Coordinator().getContactId());
        viewModel.changeView(route: _routing.chatScreenPage, widgetContext: context);
      },
      leading: new CircleAvatar(child: new Text(
          member .fullName[0],
        style: TextStyle(color: Colors.white),
      ),
      ));
}


