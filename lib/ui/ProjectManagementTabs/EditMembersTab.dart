import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:partnership/ui/widgets/EditMembersWidgets/AcceptMemberCard.dart';
import 'package:partnership/ui/widgets/EditMembersWidgets/RemoveMemberCard.dart';
import 'package:partnership/viewmodel/ProjectManagementTabsViewModel.dart';
import 'package:auto_size_text/auto_size_text.dart';

class EditMembersTab extends StatelessWidget {
  final ProjectManagementTabsViewModel viewModel;
  final DocumentSnapshot project;
  EditMembersTab(ProjectManagementTabsViewModel vm, DocumentSnapshot project)
      : viewModel = vm,
        project = project;
  List<DocumentSnapshot> membersSnapshotList = [];

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size.height;
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
        Container(
          child: ListView(children: [
            StreamBuilder(
              stream: this
                  .project
                  .reference
                  .collection('membres')
                  .where("status", isEqualTo: "En attente")
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.data.documents.length > 0) {
                  return Column(
                    children: snapshot.data.documents.map((doc) {
                      MemberAccept member = MemberAccept(
                          doc.data['firstName'],
                          doc.data['lastName'],
                          doc.data['pid'],
                          doc.data['uid'],
                          'https://firebasestorage.googleapis.com/v0/b/partnership-app-e8d99.appspot.com/o/unknowprofilepicture.png?alt=media&token=80d8fd66-ab70-4c8a-bd9f-bed1897e3234');
                      return AcceptMemberCard(member, viewModel);
                    }).toList(),
                  );
                } else {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(80),
                      child: AutoSizeText("Il n'y a aucune demande",
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Orkney',
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ),
                  );
                }
              },
            )
          ]),
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
        Container(
          child: ListView(children: [
            StreamBuilder(
              stream: this
                  .project
                  .reference
                  .collection('membres')
                  .where("status", isEqualTo: "membre")
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.data.documents.length > 0) {
                  return Column(
                    children: snapshot.data.documents.map((doc) {
                      MemberRemove member = MemberRemove(
                          doc.data['firstName'],
                          doc.data['lastName'],
                          doc.data['pid'],
                          doc.data['uid'],
                          'https://firebasestorage.googleapis.com/v0/b/partnership-app-e8d99.appspot.com/o/unknowprofilepicture.png?alt=media&token=80d8fd66-ab70-4c8a-bd9f-bed1897e3234');
                      return RemoveMemberCard(member, viewModel);
                    }).toList(),
                  );
                } else {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(80),
                      child: AutoSizeText("Il n'y a aucun membre",
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Orkney',
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ),
                  );
                }
              },
            ),
          ]),
          margin: EdgeInsets.all(5),
          height: screenSize / 2.7,
        ),
      ],
    );
  }
}
