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
import 'package:tuple/tuple.dart';

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
    //this.viewModel.getProjectList(query: "", onUpdate: (value) => this._updateProjectList(value));
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
        child: buildEndDrawer(context: context, viewModel: viewModel, projectSearch: false),
      ),
      body: Builder(builder: (BuildContext context) {
        viewModel.setPageContext(Tuple2<BuildContext, String>(context, _routing.projectBrowsingPage));
        return SafeArea(
          top: false,
          child: ThemeContainer(
              context,
              Column(children: <Widget>[
                pageHeader(context, 'Recherche de projets'),
                Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height - 110,
                    child: StreamBuilder<QuerySnapshot>(
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
                                  return Padding(
                                      child: CustomCard(viewModel: viewModel, routing: _routing, project: document),
                                      padding: EdgeInsets.all(10));
                                }).toList(),
                              );
                          }
                        }))
              ])),
        );
      }),
    );
  }
}

class CustomCard extends StatelessWidget {
  ProjectBrowsingPageViewModel _viewModel;
  DocumentSnapshot  _project;
  IRoutes           _routing;

  CustomCard({@required ProjectBrowsingPageViewModel viewModel, @required IRoutes routing, @required DocumentSnapshot project})
      : _viewModel = viewModel, _routing = routing, _project = project;

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
    return (_buildContainer(width: MediaQuery.of(context).size.width, context: context));
  }

  Text _buildTitle() {
    return (Text(
      _project['name'] ?? 'title not found',
      textAlign: TextAlign.left,
      //style: storyHeaderTextStyle,
      maxLines: 1,
      overflow: TextOverflow.fade,
    ));
  }

  Text _buildDescription() {
    return (Text(_project['description'] ?? 'description not found',
        textAlign: TextAlign.right,
        //style: storyDescriptionTextStyle,
        maxLines: 2,
        overflow: TextOverflow.fade));
  }

  Widget _buildContainer({double width, BuildContext context}) {
    DecorationImage image = DecorationImage(
        image: NetworkImage(_project['bannerPath'] ?? null),
        fit: BoxFit.cover,
        alignment: Alignment.topCenter);
    BoxDecoration decoration = BoxDecoration(
        color: Colors.lightBlue[200],
        borderRadius: BorderRadius.all(Radius.circular(5)),
        image: image);
    final double sidePadding = 10;
    Widget result = GestureDetector(
        onTap: () {
          this._viewModel.pushDynamicPage(
              route: _routing.projectDescriptionPage,
              widgetContext: context,
              args: <String, dynamic>{'project': this._project}
            );
        },
        child: Container(
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
        ));
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
