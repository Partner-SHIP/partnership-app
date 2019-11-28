import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:partnership/viewmodel/AViewModel.dart';
class PartnershipCard extends StatelessWidget {
  String  img;
  String  name;
  int     metrics;
  AViewModel viewModel;
  PartnershipCard(String img, String name, int metrics, AViewModel viewModel): img = img, name = name, metrics = metrics, viewModel = viewModel;

  Container _buildImageContainer(BuildContext context){
    return Container(
        width: 100,
        height: 100,
        child: Container(
          decoration: BoxDecoration(
              color: Colors.red,
              image: DecorationImage(
                  image: NetworkImage(img),
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
          AutoSizeText(name,style: TextStyle(
          fontSize: 15,
          fontFamily: 'Orkney',
          fontWeight: FontWeight.bold,
          color: Colors.white)),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: AutoSizeText(metrics.toString()+" vues | "+metrics.toString()+" follow | "+metrics.toString()+" likes", style: TextStyle(
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
      onTap: () => viewModel.pushDynamicPage(route: null, widgetContext: context, args: null),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildCard(context);
  }

}