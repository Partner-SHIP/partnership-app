import 'package:flutter/material.dart';
import 'dart:async';
import 'package:partnership/utils/Routes.dart';
import 'package:partnership/viewmodel/AViewModelFactory.dart';
import 'package:partnership/viewmodel/HomePageViewModel.dart';
import 'package:partnership/ui/widgets/StoryList.dart';
import 'package:partnership/ui/widgets/ThemeContainer.dart';
import 'package:partnership/ui/widgets/EndDrawer.dart';
import 'package:partnership/ui/widgets/PageHeader.dart';
import 'package:auto_size_text/auto_size_text.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  StoryList     _stories = StoryList();
  IRoutes      _routing = Routes();
  StreamSubscription _connectivitySub;
  HomePageViewModel get viewModel =>
      AViewModelFactory.register[_routing.homePage];
  bool isOffline = false;
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  StreamSubscription<dynamic> sub;
  //StreamSubscription<QuerySnapshot> user_sub;
  void listencb() {}
  void pausecb() {}
  void resumecb() {}
  void cancelcb() {}

  @override
  void initState(){
    super.initState();
    this._connectivitySub = viewModel.subscribeToConnectivity(this._connectivityHandler);
    viewModel.getStoryList((value) => this._updateStoryList(value));
  }
  @override
  void dispose(){
    this._connectivitySub.cancel();
    super.dispose();
  }

  void _updateStoryList(List<StoryData> param) {
    this.setState(() {
      if (!mounted)
        return ;
      this._stories = StoryList();
      List<StoryListItem> newStories = param.map((elem) {
        return (StoryListItem(imgPath: elem.imgPath, title:elem.title, description: elem.description));
      }).toList();
      this._stories.updateList(list:newStories);
    });
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
