import 'package:flutter/material.dart';
import 'package:partnership/viewmodel/ChatMessageViewModel.dart';
import 'package:partnership/viewmodel/AViewModelFactory.dart';
import 'package:partnership/utils/Routes.dart';
import 'package:auto_size_text/auto_size_text.dart';

class ChatMessage extends StatelessWidget {
  final String text;
  final String name;
  final String date;

  ChatMessage({this.name, this.text, this.date});

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new Container(
            margin: const EdgeInsets.only(right: 16.0),
            child: new CircleAvatar(
              child: new Text(name,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          new Wrap(
            children: <Widget>[
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new AutoSizeText(name, style: TextStyle(color: Colors.white),),
                    new Container(
                      margin: const EdgeInsets.only(top: 5.0),
                      child: new AutoSizeText(text, style: TextStyle(color: Colors.white),),
                    ),
                    new Container(
                      margin: const EdgeInsets.only(top: 5.0),
                      child: new AutoSizeText(date, style: TextStyle(color: Colors.white),),
                    )
                  ],
                ),
                width: MediaQuery.of(context).size.width / 1.3,
              )
            ],
          ),

        ],
      ),
    );
  }
}
