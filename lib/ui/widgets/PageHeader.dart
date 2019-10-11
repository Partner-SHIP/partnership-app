import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

Row pageHeader(BuildContext context, String title) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: <Widget>[
      Padding(padding: EdgeInsets.only(top: 120.0)),
      Image.asset('assets/img/logo_white_partnership.png', width: 50, height: 50),
      Text(
        title,
        maxLines: 1,
        style: TextStyle(
            color: Colors.white, fontSize: 20, fontFamily: 'Orkney'),
      ),
      IconButton(
          icon: Icon(Icons.menu, color: Colors.white),
          onPressed: () => Scaffold.of(context).openEndDrawer())
    ],
  );
}