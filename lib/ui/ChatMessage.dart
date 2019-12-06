import 'package:flutter/material.dart';
import 'package:partnership/viewmodel/ChatMessageViewModel.dart';
import 'package:partnership/viewmodel/AViewModelFactory.dart';
import 'package:partnership/utils/Routes.dart';
import 'package:auto_size_text/auto_size_text.dart';

class ChatMessage extends StatelessWidget {
  final String text;
  String name;
  final String date;
  final String uid;
  final String myUid;

  ChatMessage({this.name, this.text, this.date, this.uid, this.myUid});

  Color color1;
  Color colorName;

  @override
  Widget build(BuildContext context) {

    if (this.myUid == this.uid) {
      this.name = "Moi";
      colorName = Colors.indigo;
      color1 = Colors.blueGrey;
    }
    else {
      colorName = Colors.black;
      color1 = Colors.white;
    }

    return new Scrollbar(
      child: Card(
        color: color1,
        child: new Wrap(
          // crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ListTile(
                title: new AutoSizeText(name, style: TextStyle(color: colorName),),
                trailing: new AutoSizeText(date, style: TextStyle(color: Colors.indigo, fontSize: 14,),),
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
