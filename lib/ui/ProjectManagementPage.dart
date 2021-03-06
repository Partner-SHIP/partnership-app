import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:partnership/utils/Routes.dart';
import 'package:partnership/ui/widgets/ThemeContainer.dart';
import 'package:partnership/ui/widgets/EndDrawer.dart';
import 'package:partnership/ui/widgets/PageHeader.dart';
import 'package:partnership/viewmodel/ProjectManagementPageViewModel.dart';
import 'package:partnership/viewmodel/AViewModelFactory.dart';
import 'package:partnership/ui/widgets/PartnershipCard.dart';
import 'package:partnership/ui/widgets/SearchBar.dart';
import 'package:tuple/tuple.dart';

class ProjectManagementPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProjectManagementPageState();
  }
}

class _ProjectManagementPageState extends State<ProjectManagementPage> {
  IRoutes      _routing = Routes();
  StreamSubscription _connectivitySub;
  ProjectManagementPageViewModel get viewModel =>
      AViewModelFactory.register[_routing.projectManagement];

  @override
  void initState(){
    super.initState();
    this._connectivitySub = viewModel.subscribeToConnectivity(this._connectivityHandler);
    viewModel.setStateHandler(this._reloadWidgets);
    viewModel.pageExist = true;
  }
  @override
  void dispose(){
    viewModel.pageExist = false;
    this._connectivitySub.cancel();
    super.dispose();
  }

  void _reloadWidgets(){
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double paddedHeight = screenSize.height - 24;
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      endDrawer: Theme(
        data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
        child: buildEndDrawer(context: context, viewModel: viewModel, projectManagement: false),
      ),
      body: Builder(
          builder: (BuildContext context) {
            viewModel.setPageContext(Tuple2<BuildContext, String>(context, _routing.homePage));
            return SafeArea(
                top: false,
                child: ThemeContainer(
                    context,
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        pageHeader(context, 'Mes Projets'),
                        Container(
                          width: screenSize.width,
                          height: screenSize.height - 75,
                          child:  ListView(
                              children: [
                                  StreamBuilder(
                                  stream: this.viewModel.model.firestore.collection('projects').where("creator", isEqualTo: viewModel.loggedInUser().uid).snapshots(),
                                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                      if (snapshot.hasData)
                                        return Column(
                                            children: snapshot.data.documents.map((doc){
                                              return PartnershipCard(doc, viewModel);
                                            }).toList()
                                        );
                                      else
                                        return AutoSizeText("aucun projet trouvé");
                                    }
                                ),
                              ]
                          ),
                        ),
                      ],
                    ))
            );
          }
      ),
    );
  }
  void _connectivityHandler(bool value) {

  }
}