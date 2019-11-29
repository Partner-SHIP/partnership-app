import 'package:flutter/material.dart';
import 'package:partnership/viewmodel/ProjectManagementPageViewModel.dart';
import 'package:partnership/viewmodel/ProjectManagementTabsViewModel.dart';
import 'package:auto_size_text/auto_size_text.dart';

class EditMembersTab extends StatelessWidget {
  final ProjectManagementTabsViewModel viewModel;
  final Project                        project;
  EditMembersTab(ProjectManagementTabsViewModel vm, Project project) : viewModel = vm, project = project;
  @override
  Widget build(BuildContext context) {
    return AutoSizeText("Edit Members Tab");
  }
}