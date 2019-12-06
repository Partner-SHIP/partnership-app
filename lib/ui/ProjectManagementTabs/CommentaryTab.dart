import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:partnership/viewmodel/ProjectManagementPageViewModel.dart';
import 'package:partnership/viewmodel/ProjectManagementTabsViewModel.dart';
import 'package:auto_size_text/auto_size_text.dart';

class CommentaryTab extends StatelessWidget {
  final ProjectManagementTabsViewModel viewModel;
  final DocumentSnapshot project;
  CommentaryTab(ProjectManagementTabsViewModel vm, DocumentSnapshot project)
      : viewModel = vm,
        project = project;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: project["commentaire"].length,
        itemBuilder: (_, int index) {
          return new ListTile(
            leading: Image.network(
                project['commentaire'][index]['picture']),
            subtitle: Text(project['commentaire'][index]
            ['firstName'] +
                ' ' +
                project['commentaire'][index]
                ['lastName'] ??
                'user not found'),
            title: Text(project['commentaire'][index]
            ['message'] ??
                'title not found'),
          );
        });
  }
}
