import 'package:flutter/material.dart';
import 'package:partnership/viewmodel/AViewModelFactory.dart';
import 'package:partnership/viewmodel/SearchMemberPageViewModel.dart';
import 'package:partnership/utils/Routes.dart';
import 'package:partnership/ui/widgets/ThemeContainer.dart';
import 'package:partnership/ui/widgets/PageHeader.dart';
import 'package:partnership/ui/widgets/EndDrawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SearchMemberPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SearchMemberPageState();
  }
}


class SearchMemberPageState extends State<SearchMemberPage> {
  IRoutes      _routing = Routes();
  SearchMemberPageViewModel get viewModel => AViewModelFactory.register[_routing.searchMemberPage];

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
          child: ThemeContainer(context, 
              Container(
                padding: const EdgeInsets.all(10.0),
                child: StreamBuilder<QuerySnapshot>(
                  stream: Firestore.instance.collection('profiles').snapshots(),
                  builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError)
                      return new Text('Error: ${snapshot.error}');
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return new Text('Loading...');
                      default:
                        return new ListView(
                          children: snapshot.data.documents.map((DocumentSnapshot document) {
                          return new CustomCard(
                            title: document['nickname'],
                            test: document['uid'],
                          );
                      }).toList(),
                    );
                }
              },
            )),
          ),
        );
      })
    );
  }

  

}

class SecondPage extends StatelessWidget {
  SecondPage({@required this.title, this.test});

  final title;
  final test;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(test),
                RaisedButton(
                    child: Text('Retour'),
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    onPressed: () => Navigator.pop(context)),
              ]),
        ));
  }
}

class CustomCard extends StatelessWidget {
  CustomCard({@required this.title, this.test});

  final title;
  final test;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Container(
            padding: const EdgeInsets.only(top: 5.0),
            child: Column(
              children: <Widget>[
                Text(title),
                FlatButton(
                    child: Text("Plus d'info"),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SecondPage(
                                  title: title, test: test)));
                    }),
              ],
            )));
  }
}