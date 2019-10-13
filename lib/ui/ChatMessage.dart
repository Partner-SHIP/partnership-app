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

    return new Scrollbar(
      child: Card(
        child: new Wrap(
          // crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ListTile(
                title: new AutoSizeText(name, style: TextStyle(color: Colors.black),),
                trailing: new AutoSizeText(date, style: TextStyle(color: Colors.indigoAccent, fontSize: 12,),),
              ),
              Container(
                padding: EdgeInsets.all(15),
                child: Text(text, style: TextStyle(color: Colors.black)),
              ),
            ]),
      ),
    );

    return new Card(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new Wrap(
            children: <Widget>[
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new AutoSizeText(name, style: TextStyle(color: Colors.black),),
                    new Container(
                      margin: const EdgeInsets.only(top: 5.0),
                      child: new AutoSizeText(text, style: TextStyle(color: Colors.black),),
                    ),
                    new Container(
                      margin: const EdgeInsets.only(top: 5.0),
                      child: new AutoSizeText(date, style: TextStyle(color: Colors.black),),
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
