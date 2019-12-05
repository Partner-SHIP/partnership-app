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

  Widget _buildCircleAvatar(BuildContext context) {
    return GestureDetector(
      child: CircleAvatar(
          radius: 32, backgroundImage: NetworkImage(this.memberAccept.imgUrl)),
      onTap: () => {print('AcceptCard Image Click')},
      //call afficher le profil de l'user ? ou afficher l'image en grand
    );
  }

  Widget _buildTextName(BuildContext context) {
    return GestureDetector(
        child: AutoSizeText(
            this.memberAccept.firstName + ' ' + this.memberAccept.lastName,
            style: TextStyle(
                fontSize: 25,
                fontFamily: 'Orkney',
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        onTap: () => {print('AcceptCard Name Click ' + this.memberAccept.pid)}
        //call afficher le profil de l'user ?
        );
  }

  Widget _buildAcceptIcon(BuildContext context) {
    return GestureDetector(
      child: Icon(
        Icons.check,
        color: Colors.green,
        size: 45,
      ),
      onTap: () => {print('AcceptCard Check Icon Click')},
      //call ajouter le membre au projet
    );
  }

  Widget _buildDeclineIcon(BuildContext context) {
    return GestureDetector(
      child: Icon(
        Icons.clear,
        color: Colors.red,
        size: 45,
      ),
      onTap: () => {print('Accept Card Uncheck Icon Click')},
      //call refuser le membre au projet
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
          _buildAcceptIcon(context),
          _buildDeclineIcon(context),
        ],
      ),
    );
  }
}
