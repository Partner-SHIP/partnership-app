import 'package:flutter/material.dart';
import 'dart:async';
import 'package:partnership/utils/Routes.dart';
import 'package:partnership/viewmodel/AViewModelFactory.dart';
import 'package:partnership/viewmodel/HomePageViewModel.dart';
import 'package:partnership/ui/widgets/StoryList.dart';
import 'package:partnership/ui/widgets/ThemeContainer.dart';
import 'package:partnership/ui/widgets/EndDrawer.dart';
import 'package:partnership/ui/widgets/PageHeader.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  StoryList     _stories = StoryList(items: null);
  IRoutes      _routing = Routes();
  StreamSubscription _connectivitySub;
  HomePageViewModel get viewModel =>
      AViewModelFactory.register[_routing.homePage];

  @override
  void initState(){
    super.initState();
    this._connectivitySub = viewModel.subscribeToConnectivity(this._connectivityHandler);
    viewModel.setStateHandler(this._reloadWidgets);
    viewModel.getStoryList(this._updateStoryList);
    viewModel.pageExist = true;
  }
  @override
  void dispose(){
    viewModel.pageExist = false;
    this._connectivitySub.cancel();
    super.dispose();
  }

  void _updateStoryList(dynamic data) {
    this.setState(() {
      this._stories = StoryList(items: viewModel.convertStoryModelToItems(data));
    });
  }

  void _reloadWidgets(){
    setState(() {});
  }

  Container _buildActions(BuildContext context, double height) {
    FloatingActionButton createProjectAction = FloatingActionButton(heroTag: "add", child:Icon(Icons.add), onPressed: () {this.viewModel.goToCreateProjectPage(context);}, backgroundColor: Colors.grey[700],);
    FloatingActionButton joinProjectAction = FloatingActionButton(heroTag: "join", child:Icon(Icons.file_download), onPressed: () {this.viewModel.goToBrowsingProjectPage(context);}, backgroundColor: Colors.grey[700]);
    Row actionsRow = Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Padding(child: createProjectAction, padding:EdgeInsets.symmetric(horizontal: 5)),
          Padding(child: joinProjectAction, padding: EdgeInsets.only(left: 5)),
        ],
    );
    Container actions = Container(child:actionsRow);
    return (actions);
  }
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double paddedHeight = screenSize.height - 24;
    _stories.setHeight(screenSize.height / 1.3);
    Widget actions = _buildActions(context, paddedHeight / 8);
    Widget view = Scaffold(
      floatingActionButton: actions,
      resizeToAvoidBottomPadding: true,
      backgroundColor: Colors.grey[300],
      endDrawer: Theme(
        data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
        child: buildEndDrawer(context: context, viewModel: viewModel),
      ),
      body: Builder(
        builder: (BuildContext context) {
          return SafeArea(
              top: false,
              child: ThemeContainer(
                  context,
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      pageHeader(context, 'Votre fil d\'actualités'),
                      _stories
                    ],
                  ))
          );
        }
      ),
    );
    return (WillPopScope(onWillPop: null, child: view));
  }
  void _connectivityHandler(bool value) {

  }
}
