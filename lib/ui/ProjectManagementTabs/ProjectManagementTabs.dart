import 'package:flutter/material.dart';
import 'package:partnership/viewmodel/AViewModel.dart';
import 'package:partnership/viewmodel/ProjectManagementTabsViewModel.dart';
import 'package:partnership/utils/Routes.dart';
import 'package:partnership/viewmodel/AViewModelFactory.dart';
import 'package:partnership/ui/widgets/ThemeContainer.dart';
import 'package:partnership/style/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tuple/tuple.dart';
import 'package:partnership/ui/ProjectManagementTabs/EditMembersTab.dart';
import 'package:partnership/ui/ProjectManagementTabs/EditProjectTab.dart';
import 'package:partnership/ui/ProjectManagementTabs/CommentaryTab.dart';
import 'dart:async';

class ProjectManagementTabs extends StatefulWidget {
  static _ProjectManagementTabsState _state;
  ProjectManagementTabs(Map<String, dynamic> args) {
    _state = _ProjectManagementTabsState(args);
  }

  @override
  _ProjectManagementTabsState createState() => _state;
}

class _ProjectManagementTabsState extends State<ProjectManagementTabs> {
  bool busy = false;
  IRoutes _routing = Routes();
  StreamSubscription _connectivitySub;
  ProjectManagementTabsViewModel viewModel;
  Map<String, dynamic> args;
  _ProjectManagementTabsState(Map<String, dynamic> parameters)
      : args = parameters;

  @override
  void initState() {
    super.initState();
    //DocumentSnapshot project = args['project'];
    //var data = project.data;
    viewModel = AViewModelFactory.createDynamicViewModel(
        route: _routing.projectManagementTabs);
    this._connectivitySub =
        viewModel.subscribeToConnectivity(this._connectivityHandler);
  }

  @override
  void dispose() {
    this._connectivitySub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ThemeContainer(context, DefaultTabController(
        length: 3,
        child: Scaffold(
          resizeToAvoidBottomPadding: true,
          bottomNavigationBar: Material(
            color: AThemes.selectedTheme.bgGradient.colors[0],
            child: TabBar(
              indicatorColor: Colors.white,
              unselectedLabelColor: AThemes.selectedTheme.bgGradient.colors[1],
              labelColor: Colors.white,
              tabs: [
                Tab(icon: Icon(Icons.settings)),
                Tab(icon: Icon(Icons.people)),
                Tab(icon: Icon(Icons.comment)
                ),
              ],
            ),
          ),
          body: Builder(builder: (BuildContext context){
            viewModel.setPageContext(Tuple2<BuildContext, String>(context, _routing.projectManagementTabs));
            return ThemeContainer(context, SafeArea(
              child: TabBarView(
                children: [
                  EditProjectTab(viewModel),
                  EditMembersTab(viewModel),
                  CommentaryTab(viewModel)
                ],
              ),
            ));
          }),
        ),
    ));
  }

  void _connectivityHandler(bool value) {}
}