import 'package:flutter/material.dart';
import 'package:partnership/viewmodel/ProjectManagementTabsViewModel.dart';
import 'package:auto_size_text/auto_size_text.dart';

class EditMembersTab extends StatelessWidget {
  final ProjectManagementTabsViewModel viewModel;
  EditMembersTab(ProjectManagementTabsViewModel vm) : viewModel = vm;
  @override
  Widget build(BuildContext context) {
    return AutoSizeText("Edit Members Tab");
  }
}