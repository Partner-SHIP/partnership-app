import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:partnership/ui/widgets/EditMembersWidgets/AcceptMemberCard.dart';
import 'package:partnership/ui/widgets/EditMembersWidgets/RemoveMemberCard.dart';
import 'package:partnership/ui/widgets/ThemeContainer.dart';
import 'package:partnership/viewmodel/ProjectManagementPageViewModel.dart';
import 'package:partnership/viewmodel/ProjectManagementTabsViewModel.dart';
import 'package:auto_size_text/auto_size_text.dart';

class EditMembersTab extends StatelessWidget {
  final ProjectManagementTabsViewModel viewModel;
  final DocumentSnapshot project;
  EditMembersTab(ProjectManagementTabsViewModel vm, DocumentSnapshot project)
      : viewModel = vm,
        project = project;

  sortMembersList(toto) {
// on parcourt la list des membres, et on tri ceux qui sont "en attente" et ceux "membre"
  }

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
        SizedBox(
          width: 10,
          height: 10,
        ),
        widgetAcceptList.isEmpty
            ? Container(
              height: screenSize / 2.7,
              child: AutoSizeText("Il n'y a aucune demande",
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Orkney',
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
            )
            : Container(
                child: ListView(children: widgetAcceptList),
                height: screenSize / 2.7,
              ),
        SizedBox(
          width: 10,
          height: 10,
        ),
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
        SizedBox(
          width: 10,
          height: 10,
        ),
        AutoSizeText("Membres du projet",
            style: TextStyle(
                fontSize: 20,
                fontFamily: 'Orkney',
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        widgetRemoveList.isEmpty
            ? Container(
              height: screenSize / 5.7,
              child: AutoSizeText("Il n'y a aucun membre",
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Orkney',
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
            )
            : Container(
                child: ListView(children: widgetRemoveList),
                margin: EdgeInsets.all(5),
                height: screenSize / 2.7,
              ),
      ],
    );
  }
}
