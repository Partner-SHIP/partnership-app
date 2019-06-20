import 'package:flutter/material.dart';
import 'package:partnership/ui/ChatMessage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:partnership/ui/ContactData.dart';
import 'package:partnership/viewmodel/ChatScreenViewModel.dart';
import 'package:partnership/viewmodel/AViewModelFactory.dart';

class Chat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          //       title: new Text("Contacts"),
        ),
        body: new ChatScreen("test", conversations_path));
  }
}

class ChatScreen extends StatefulWidget {
  String name;
  String conversation;
  
  ChatScreen(this.name, this.conversation);

  @override
  State createState() => new ChatScreenState(this.name, this.conversation);
}

class ChatScreenState extends State<ChatScreen> {
  String _name;
  String destName;
  String conversation;

  // String dest_path;

  ChatScreenState(this.destName, this.conversation);

  final TextEditingController _textController = new TextEditingController();
  final List<ChatMessage> _messages = <ChatMessage>[];
  DateFormat dateFormat;

  @override
  void initState() {
    // TODO: implement initState
    Text text;
    dateFormat = new DateFormat("dd/MM/yyyy 'à' HH:mm:ss");
    Firestore.instance.collection('profiles').getDocuments().then((onValue) {
      onValue.documents.forEach((f) {
        if (f.data['firstName'] != null && f.data['uid'] == authID) {
          setState(() {
            _name = f.data['firstName'];
          });
        }
      });
    });
    super.initState();
  }

  void _handleSubmitted(String name, String text, String _date) {
    if (text != null && text.length > 0) {
      _textController.clear();
      ChatMessage message = new ChatMessage(
        name: name,
        text: text,
        date: _date,
      );
      _messages.insert(0, message);
    }
  }

  void _sendMessage(String text) {
    Map<String, dynamic> map = {
      'name': _name,
      'message': text,
      'timestamp': DateTime.now(),
      'hasSeen': false
    };

    Map<String, dynamic> destMap = {
      'name': _name,
      'message': text,
      'timestamp': DateTime.now(),
      'hasSeen': false
    };
    Firestore.instance.document(this.conversation).setData({
      'messages': FieldValue.arrayUnion([map])
    }, merge: true);
    Firestore.instance.document(dest_path).setData({
      'messages': FieldValue.arrayUnion([destMap])
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
                new InputDecoration.collapsed(hintText: "Send a message"),
                controller: _textController,
                onSubmitted: _sendMessage,
              ),
            ),
            new Container(
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              child: new IconButton(
                icon: new Icon(Icons.send),
                onPressed: () => _sendMessage(_textController.text),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: Firestore.instance.document(this.conversation).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasError &&
            snapshot.connectionState == ConnectionState.active &&
            snapshot.hasData &&
            snapshot.data.data != null) {
          if (snapshot.data.data.containsValue("messages") != null) {
            List list = snapshot.data.data["messages"];
            if (list != null) var value = list.last["message"];
            if (list != null &&
                _messages.length < list.length &&
                _name != null) {
              for (int i = _messages.length; i < list.length; i++) {
                DateTime dateTime = list.elementAt(i)["timestamp"].toDate();
                dateTime = dateTime.toUtc().add(new Duration(hours: 2));
                String _date = dateFormat.format(dateTime);
                _handleSubmitted(list.elementAt(i)["name"].toString(),
                    list.elementAt(i)["message"].toString(), _date);
              }
            }
          }
        }
        return new Column(
          children: <Widget>[
            new Flexible(
              child: new ListView.builder(
                padding: new EdgeInsets.all(8.0),
                reverse: true,
                itemBuilder: (_, int index) => _messages[index],
                itemCount: _messages.length,
              ),
            ),
            new Divider(
              height: 1.0,
            ),
            new Container(
              decoration: new BoxDecoration(
                color: Theme.of(context).cardColor,
              ),
              child: _textComposerWidget(),
            ),
          ],
        );
      },
    );
  }
}
