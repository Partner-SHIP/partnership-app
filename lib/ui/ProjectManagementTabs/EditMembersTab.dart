import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:partnership/ui/widgets/EditMembersWidgets/AcceptMemberCard.dart';
import 'package:partnership/ui/widgets/EditMembersWidgets/RemoveMemberCard.dart';
import 'package:partnership/ui/widgets/ThemeContainer.dart';
import 'package:partnership/viewmodel/ProjectManagementPageViewModel.dart';
import 'package:partnership/viewmodel/ProjectManagementTabsViewModel.dart';
import 'package:auto_size_text/auto_size_text.dart';

class EditMembersTab extends StatelessWidget {
  final ProjectManagementTabsViewModel viewModel;
  final Project project;
  EditMembersTab(ProjectManagementTabsViewModel vm, Project project)
      : viewModel = vm,
        project = project;
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size.height;
    List<Widget> widgetRemoveList = [];
    this.viewModel.dummyRemoveList.forEach(
        (value) => widgetRemoveList.add(RemoveMemberCard(value, viewModel)));

    List<Widget> widgetAcceptList = [];
    this.viewModel.dummyAcceptList.forEach(
        (value) => widgetAcceptList.add(AcceptMemberCard(value, viewModel)));

    return Column(
      children: <Widget>[
        AutoSizeText("Candidatures en attente",
            style: TextStyle(
                fontSize: 20,
                fontFamily: 'Orkney',
                fontWeight: FontWeight.bold,
                color: Colors.white)),
                SizedBox(width: 10, height: 10,),
        Container(
          child: ListView(children: widgetAcceptList),
          height: screenSize / 2.7,
        ),
        SizedBox(width: 10, height: 10,),
        ClipRect(
            child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Container(
            width: MediaQuery.of(context).size.height / 2,
            height: 2,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.8),
            ),
          ),
        )),
        SizedBox(width: 10, height: 10,),
        AutoSizeText("Membres du projet",
            style: TextStyle(
                fontSize: 20,
                fontFamily: 'Orkney',
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        Container(
          child: ListView(children: widgetRemoveList),
          margin: EdgeInsets.all(5),
          height: screenSize / 2.7,
        ),
      ],
    );
  }
}
