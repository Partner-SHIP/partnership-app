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
    return AutoSizeText("Commentary Tab");
  }
}
