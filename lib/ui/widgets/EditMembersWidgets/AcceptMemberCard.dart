import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:partnership/viewmodel/AViewModel.dart';
import 'package:partnership/viewmodel/ProjectManagementTabsViewModel.dart';

class AcceptMemberCard extends StatelessWidget {
  AViewModel viewModel;
  MemberAccept memberAccept;
  AcceptMemberCard(MemberAccept memberAccept, AViewModel viewModel)
      : memberAccept = memberAccept,
        viewModel = viewModel;
  @override
  Widget build(BuildContext context) {
    return Text('AcceptCard');
  }
}