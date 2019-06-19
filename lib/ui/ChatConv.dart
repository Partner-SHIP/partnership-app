import 'package:flutter/material.dart';
import 'package:partnership/ui/ChatScreen.dart';
import 'package:partnership/ui/ChatPage.dart';
import 'package:partnership/utils/Routes.dart';
import 'package:partnership/viewmodel/ChatConvViewModel.dart';
import 'package:partnership/viewmodel/AViewModelFactory.dart';

class ChatConv extends StatelessWidget {
  IRoutes      _routing = Routes();
  ChatConvViewModel get viewModel => AViewModelFactory.register[_routing.chatConvPage];
  static const routeName = '/chatConv_page';
  @override
  Widget build(BuildContext context) {
    final ScreenArguments args = ModalRoute.of(context).settings.arguments;
    return new Scaffold(
        appBar: new AppBar(
          title: new Text(args.title),
        ),
        body: new ChatScreen(args.title, args.conversation));
  }
}
