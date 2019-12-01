import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/rendering.dart';
import 'package:partnership/viewmodel/AViewModel.dart';
import 'package:partnership/viewmodel/ProjectManagementTabsViewModel.dart';

class RemoveMemberCard extends StatelessWidget {
  AViewModel viewModel;
  MemberRemove memberRemove;
  RemoveMemberCard(MemberRemove memberRemove, AViewModel viewModel)
      : memberRemove = memberRemove,
        viewModel = viewModel;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Image.network(
          this.memberRemove.imgUrl,
          height: 80,
          width: 80,
        ),
        AutoSizeText(this.memberRemove.name,
            style: TextStyle(
                fontSize: 15,
                fontFamily: 'Orkney',
                fontWeight: FontWeight.bold,
                color: Colors.white)),
                Icon(
      Icons.check,
      color: Colors.green,
    ),
    Icon(
      Icons.clear,
      color: Colors.red,
    ),
      ],
    );
  }
}
