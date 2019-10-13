import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

Container pageHeader(BuildContext context, String title) {
  return Container(
    margin: EdgeInsets.only(top: 25),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Image.asset('assets/img/logo_white_partnership.png', width: 50, height: 50),
        AutoSizeText(
          title,
          maxLines: 1,
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontFamily: 'Orkney'),
        ),
        IconButton(
            icon: Icon(Icons.menu, color: Colors.white),
            onPressed: () => Scaffold.of(context).openEndDrawer())
      ],
    ),
  );
}