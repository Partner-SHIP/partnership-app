import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:partnership/utils/Routes.dart';
import 'package:partnership/viewmodel/AViewModelFactory.dart';
import 'package:partnership/viewmodel/ProjectBrowsingPageViewModel.dart';
import 'package:partnership/ui/widgets/ProjectScrollList.dart';
import 'package:partnership/ui/widgets/SearchBar.dart';
import 'package:partnership/ui/widgets/ThemeContainer.dart';
import 'package:partnership/ui/widgets/EndDrawer.dart';
import 'package:partnership/ui/widgets/PageHeader.dart';

class ProjectBrowsingPage extends StatefulWidget {
  @override
  ProjectBrowsingPageState createState() => ProjectBrowsingPageState();
}

class ProjectBrowsingPageState extends State<ProjectBrowsingPage> {
  IRoutes _routing = Routes();
  List<ProjectScrollListItemData> _projectList = List();
  ProjectBrowsingPageViewModel get viewModel =>
      AViewModelFactory.register[_routing.projectBrowsingPage];
  @override
  void initState() {
    super.initState();
    this.viewModel.getProjectList(
        query: "", onUpdate: (value) => this._updateProjectList(value));
  }

  void _updateProjectList(List<ProjectScrollListItemData> list) {
    this.setState(() {
      if (!mounted) return;
      this._projectList = list;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double listHeight = screenHeight * 9 / 10;
    double searchBarHeight = screenHeight * 1 / 10;

    SearchBar searchBar = SearchBar(
      onQuery: this.viewModel.searchTag,
    );
    ProjectScrollList list =
        ProjectScrollList.fromDataList(this._projectList, height: listHeight);

    return Scaffold(
      resizeToAvoidBottomPadding: true,
      endDrawer: Theme(
        data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
        child: buildEndDrawer(context: context, viewModel: viewModel),
      ),
      body: Builder(builder: (BuildContext context) {
        return SafeArea(
            top: false,
            child: ThemeContainer(
              context,
              // Column(
              //   children: <Widget>[
              //     pageHeader(context, 'Recherche de projets'),
              //     searchBar,
              //     // SingleChildScrollView(
              //     //   child: Container(
              //     //     color: Colors.blue, child: Text('liste de projet'),
              //     //   )
              //     // )
              //     Container(
              //       child: StreamBuilder<QuerySnapshot>(
              StreamBuilder<QuerySnapshot>(
                  stream: Firestore.instance
                      .collection('projects')
                      .orderBy('dateOfCreation', descending: true)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError)
                      return new Text('Error: ${snapshot.error}');
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return new Text('Loading...');
                      default:
                        return new ListView(
                          children: snapshot.data.documents
                              .map((DocumentSnapshot document) {
                            return new CustomCard(
                              title: document['name'],
                              bannerPath: document['bannerPath'],
                              description: document['description'],
                              dateOfCreation: document['dateOfCreation'],
                            );
                          }).toList(),
                        );
                    }
                  }),
            )
            //],
            // )),
            );
      }),
    );
  }
}

class CustomCard extends StatelessWidget {
  CustomCard({
    @required this.title,
    this.bannerPath,
    this.description,
    this.dateOfCreation,
  });

  final title;
  final bannerPath;
  final description;
  final dateOfCreation;

  @override
  Widget build(BuildContext context) {
    // return Card(
    //     child: Container(
    //         padding: const EdgeInsets.only(top: 5.0),
    //         child: Column(
    //           children: <Widget>[
    //             Image.network(
    //               bannerPath,
    //             ),
    //             Text(title),
    //             FlatButton(
    //                 child: Text("Plus d'info"),
    //                 onPressed: () {
    //                   Navigator.push(
    //                       context,
    //                       MaterialPageRoute(
    //                           builder: (context) => SecondPage(
    //                               title: title,
    //                               bannerPath: bannerPath,
    //                               description: description,
    //                               dateOfCreation: dateOfCreation)));
    //                 }),
    //           ],
    //         )));
    return (_buildContainer(width: MediaQuery.of(context).size.width));
  }

  Text _buildTitle() {
    return (Text(
      title,
      textAlign: TextAlign.left,
      //style: storyHeaderTextStyle,
      maxLines: 1,
      overflow: TextOverflow.fade,
    ));
  }

  Text _buildDescription() {
    return (Text(description,
        textAlign: TextAlign.right,
        //style: storyDescriptionTextStyle,
        maxLines: 2,
        overflow: TextOverflow.fade));
  }

  Container _buildContainer({double width}) {
    DecorationImage image = DecorationImage(
        image: NetworkImage(bannerPath),
        fit: BoxFit.cover,
        alignment: Alignment.topCenter);
    BoxDecoration decoration = BoxDecoration(
        color: Colors.lightBlue[200],
        borderRadius: BorderRadius.all(Radius.circular(5)),
        image: image);
    final double sidePadding = 10;
    Container result = Container(
      decoration: decoration,
      height: 120,
      width: width,
      padding: EdgeInsets.only(
          bottom: 10, top: 10, left: sidePadding, right: sidePadding),
      child: Column(
        children: <Widget>[
          Container(width: width - sidePadding * 2, child: _buildTitle()),
          Container(width: width - 10, child: _buildDescription())
        ],
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      ),
    );
    return (result);
  }
}

class SecondPage extends StatelessWidget {
  SecondPage(
      {@required this.title,
      this.bannerPath,
      this.description,
      this.dateOfCreation});

  final title;
  final bannerPath;
  final description;
  final dateOfCreation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ThemeContainer(
            context,
            Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image.network(
                      bannerPath,
                    ),
                    Text(title),
                    Text(description),
                    RaisedButton(
                        child: Text('Retour'),
                        color: Theme.of(context).primaryColor,
                        textColor: Colors.white,
                        onPressed: () => Navigator.pop(context)),
                  ]),
            )));
  }
}
