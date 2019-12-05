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
  Widget _buildCircleAvatar(BuildContext context) {
    return GestureDetector(
      child: CircleAvatar(
          radius: 32, backgroundImage: NetworkImage(this.memberRemove.imgUrl)),
      onTap: () =>
          {print('RemoveCard Image Click of ' + this.memberRemove.firstName)},
    );
  }

  Widget _buildTextName(BuildContext context) {
    return GestureDetector(
      child: AutoSizeText(
          this.memberRemove.firstName + ' ' + this.memberRemove.lastName,
          style: TextStyle(
              fontSize: 25,
              fontFamily: 'Orkney',
              fontWeight: FontWeight.bold,
              color: Colors.white)),
      onTap: () =>
          {print('RemoveCard Name Click of ' + this.memberRemove.firstName)},
    );
  }

  Widget _buildDeclineIcon(BuildContext context) {
    return GestureDetector(
      child: Icon(
        Icons.clear,
        color: Colors.red,
        size: 45,
      ),
      onTap: () =>
          {print('RemoveCard Uncheck Click of ' + this.memberRemove.firstName)},
    //call kicker le membre du projet + envoi de notif à l'utilisateur ?
    );
  }

  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildCircleAvatar(context),
          _buildTextName(context),
          Container(
            height: 45,
            width: 45,
          ),
          _buildDeclineIcon(context),
        ],
      ),
    );
  }
}
