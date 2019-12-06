import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:partnership/viewmodel/AViewModel.dart';
import 'package:partnership/viewmodel/ProjectManagementPageViewModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PartnershipCard extends StatelessWidget {
  DocumentSnapshot  document;
  AViewModel viewModel;
  PartnershipCard(DocumentSnapshot document, AViewModel viewModel): document = document, viewModel = viewModel;

  Container _buildImageContainer(BuildContext context){
    return Container(
        width: 100,
        height: 100,
        child: Container(
          decoration: BoxDecoration(
              color: Colors.red,
              image: DecorationImage(
                  image: NetworkImage(Uri.decodeComponent(document["bannerPath"])),
                  fit: BoxFit.cover),
              borderRadius: BorderRadius.all(Radius.circular(45.0)),
              boxShadow: [
                BoxShadow(blurRadius: 7.0, color: Colors.black)
              ]),
        )
    );
  }

  Container _buildProjectInfo(BuildContext context){
    Size screen_size = MediaQuery.of(context).size;
    return Container(
      child: Column(
        children: <Widget>[
          AutoSizeText(document["name"],style: TextStyle(
          fontSize: 15,
          fontFamily: 'Orkney',
          fontWeight: FontWeight.bold,
          color: Colors.white)),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: AutoSizeText(document["viewNumber"].toString()+" vues | "+document["followNumber"].toString()+" follow | "+document["likeNumber"].toString()+" likes", style: TextStyle(
                fontSize: 15,
                fontFamily: 'Orkney',
                fontWeight: FontWeight.normal,
                color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget  _buildCard(BuildContext context){
    Size screen_size = MediaQuery.of(context).size;
    Container card = Container(
      margin: EdgeInsets.all(15),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildImageContainer(context),
          _buildProjectInfo(context)
        ],
      )
    );
    return InkWell(
      child: card,
      onTap: () => viewModel.pushDynamicPage(route: '/project_management_tabs', widgetContext: context, args: {"project": document}),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildCard(context);
  }

}