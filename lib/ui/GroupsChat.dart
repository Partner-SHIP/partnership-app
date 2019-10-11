import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:partnership/coordinator/AppCoordinator.dart';
import 'package:partnership/ui/widgets/ThemeContainer.dart';
import 'package:partnership/utils/Routes.dart';
import 'package:partnership/viewmodel/ChatScreenViewModel.dart';
import 'package:partnership/viewmodel/AViewModelFactory.dart';
import 'package:partnership/viewmodel/GroupsChatViewModel.dart';

class GroupsChat extends StatefulWidget {
  GroupsChat();

  @override
  State createState() => new GroupsChatState();
}

class GroupsChatState extends State<GroupsChat> {
  IRoutes _routing = Routes();

  GroupsChatViewModel get viewModel =>
      AViewModelFactory.register[_routing.groupsChat];

  final TextEditingController _textController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    viewModel.init();
    setState(() {
      this.viewModel.initNames();
    });
  }

  void sendMessage(String message) {
    Firestore.instance.document("projects/" + viewModel.getContactId()).setData(
        {
          'messages': FieldValue.arrayUnion([
            {
              'name': viewModel.getMyName(),
              'message': message,
              'timestamp': DateTime.now(),
              'hasSeen': false
            }
          ])
        }, merge: true);
  }

  Widget _textComposerWidget() {
    return new IconTheme(
      data: new IconThemeData(color: Colors.green),
      child: new Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: new Row(
          children: <Widget>[
            new Flexible(
              child: new TextField(
                decoration:
                new InputDecoration.collapsed(hintText: "Envoyer un message",
                    fillColor: Colors.transparent
                ),
                controller: _textController,
               // onSubmitted: viewModel.sendingMessages,
              ),
            ),
            new Container(
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              child: new IconButton(
                icon: new Icon(Icons.send,
                    color: Colors.deepPurple),
                onPressed: () {
                  sendMessage(_textController.text);
                  _textController.clear();
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print(viewModel.getMyConvPath());
    return StreamBuilder<DocumentSnapshot>(
      stream:
      Firestore.instance.document("projects/" + viewModel.getContactId())
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasError &&
            snapshot.connectionState == ConnectionState.active &&
            snapshot.hasData &&
            snapshot.data.data != null) {
          viewModel.messagesChanges(snapshot);
        }
        return new Scaffold(
            appBar: new AppBar(
              backgroundColor: Colors.indigo,
              title: new Text(
                viewModel.getContactName() != null
                    ? viewModel.getContactName()
                    : '',
                style: TextStyle(color: Colors.white),
              ),
            ),
            body: ThemeContainer(
                context,
                new Column(
                  children: <Widget>[
                    new Flexible(
                      child: new ListView.builder(
                        padding: new EdgeInsets.all(8.0),
                        reverse: true,
                        itemBuilder: (_, int index) =>
                        viewModel.getMessages()[index],
                        itemCount: viewModel
                            .getMessages()
                            .length,
                      ),
                    ),
                    new Divider(
                      height: 1.0,
                    ),
                    new Container(
                      decoration: new BoxDecoration(
                        color: Theme
                            .of(context)
                            .cardColor,
                      ),
                      child: _textComposerWidget(),
                    ),
                  ],
                )
            )
        );
      },
    );
  }
}
