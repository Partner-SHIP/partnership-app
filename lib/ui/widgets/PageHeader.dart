import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

Row pageHeader(BuildContext context, String title) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Image.asset('assets/img/partnership_logo.png', width: 110, height: 110),
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
  );
}