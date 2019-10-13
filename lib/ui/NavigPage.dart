import 'package:flutter/material.dart';
import 'package:partnership/ui/ChatPage.dart';
import 'package:partnership/ui/GroupsPage.dart';
import 'package:partnership/ui/ChatMessage.dart';
import 'package:partnership/ui/ContactsPage.dart';
import 'package:partnership/ui/RecContactsPage.dart';
import 'package:partnership/ui/widgets/EndDrawer.dart';
import 'package:partnership/ui/widgets/PageHeader.dart';
import 'package:partnership/ui/widgets/ThemeContainer.dart';
import 'package:partnership/utils/Routes.dart';
import 'package:partnership/viewmodel/AViewModelFactory.dart';
import 'package:partnership/viewmodel/NavigPageViewModel.dart';


class NavigPage extends StatefulWidget {
  @override
  NavigPageState createState() => new NavigPageState();
}

// SingleTickerProviderStateMixin is used for animation
class NavigPageState extends State<NavigPage> with SingleTickerProviderStateMixin {
  // Create a tab controller
  IRoutes _routing = Routes();
  NavigPageViewModel get viewModel => AViewModelFactory.register[_routing.navigPage];
  GlobalKey<ScaffoldState>  _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  TabController controller;

  @override
  void initState() {
    super.initState();

    // Initialize the Tab Controller
    controller = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    // Dispose of the Tab Controller
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomPadding: true,
      endDrawer: Theme(
          data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
          child: buildEndDrawer(context: null, viewModel: viewModel, chat: false)
      ),
      /*appBar: new AppBar(
       actions: <Widget>[

         ThemeContainer(context, pageHeader(context, ""))
       ],
      ),*/
      // Appbar
      // Set the TabBar view as the body of the Scaffold
      body:  Builder(builder: (BuildContext context) {
        //  _scaffoldKey.currentState.showSnackBar(snackbar)
        // return Center();
        return SafeArea(
          top: false,
          child: ThemeContainer(
              context,
              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                   pageHeader(context, 'Messagerie'),
                  //Other Widgets Here*/
                  Container(
                      child: new TabBarView(
                        // Add tabs as widgets
                        children: <Widget>[ChatPage(), ContactsPage(), RecContactsPage(), GroupsPage()],
                        // set the controller
                        controller: controller,
                      ),
                      height: MediaQuery.of(context).size.height - 158,
                      width: MediaQuery.of(context).size.width),
                ],
              )),
        );
      }),
      // Set the bottom navigation bar
      bottomNavigationBar: Material(
        // set the color of the bottom navigation bar
        color: Colors.blue,
        // set the tab bar as the child of bottom navigation bar
        child: TabBar(
          tabs: <Tab>[
            Tab(
              // set icon to the tab
              icon: Text("Messages"),
            ),
            Tab(
              icon: Text("Contacts"),
            ),
            Tab(
              icon: Text("contacts recu"),
            ),
            Tab(
              icon: Text("Groupes"),
            ),
          ],
          // setup the controller
          controller: controller,
        ),
      ),
    );
  }
}
