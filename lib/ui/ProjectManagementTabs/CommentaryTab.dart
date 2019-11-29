import 'package:flutter/material.dart';
import 'package:partnership/viewmodel/ProjectManagementTabsViewModel.dart';
import 'package:auto_size_text/auto_size_text.dart';

class CommentaryTab extends StatelessWidget {
  final ProjectManagementTabsViewModel viewModel;
  CommentaryTab(ProjectManagementTabsViewModel vm) : viewModel = vm;
  @override
  Widget build(BuildContext context) {
    return AutoSizeText("Commentary Tab");
  }
}