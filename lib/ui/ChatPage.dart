import 'package:flutter/material.dart';
import 'package:partnership/viewmodel/AViewModelFactory.dart';
import 'package:partnership/viewmodel/ChatPageViewModel.dart';
import 'package:partnership/utils/Routes.dart';
import 'package:partnership/ui/widgets/ThemeContainer.dart';
import 'package:partnership/ui/widgets/PageHeader.dart';
import 'package:partnership/ui/widgets/EndDrawer.dart';

class ChatPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ChatPageState();
  }
}

class ChatPageState extends State<ChatPage> {
  
  IRoutes      _routing = Routes();
  ChatPageViewModel get viewModel => AViewModelFactory.register[_routing.chatPage];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      endDrawer: Theme(
        data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
        child: buildEndDrawer(context: context, viewModel: viewModel),
      ),
      body: Builder(builder: (BuildContext context){
        return SafeArea(
          top: false,
          child: ThemeContainer(
              context,
              Column(
                children: <Widget>[
                  pageHeader(context, 'Messages'),
                  /*Other Widgets Here*/
                ],
              )
          ),
        );
      }),
    );
  }

}