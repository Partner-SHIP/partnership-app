import 'package:flutter/material.dart';

class StoryList extends StatelessWidget {
  List<StoryListItem> _list;
  StoryList();
  void updateList({@required List<StoryListItem> list}) {
    _list = list;
  }
  Container _mapList() {
    return (Container(height: 450, child: SingleChildScrollView(child: Column(children:_list),),));
  }
  @override
  Widget build(BuildContext context) {
    if (_list == null) {
      return (Text(""));
    }
    return (_mapList());
  }
}

class StoryListItem extends StatelessWidget {
  final String _imgPath;
  final String _title;
  final String _description;
  StoryListItem({@required String imgPath, @required String title, String description = ""}) :_imgPath = imgPath, _title = title, _description = description;
  Row _buildTitle() {
    return (Row(children: [Text(_title)], mainAxisSize: MainAxisSize.max, ));
  }
  Row _buildDescription() {
    return (Row(children: [Text(_description)], mainAxisSize: MainAxisSize.max, ));
  }
  Container _buildContainer() {
    BoxDecoration decoration =BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.all(Radius.circular(5)));
    Container result = Container(
      decoration: decoration,
      height: 100,
      padding: EdgeInsets.only(bottom: 10, top: 10, left: 5, right: 5),
      child: Column(
        children: <Widget>[_buildTitle(), _buildDescription()],
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      ),
      
    );
    return (result);
  }
  @override
  Widget build(BuildContext context) {
    
    Container result = _buildContainer();
    
    return (Padding(child: result, padding: EdgeInsets.only(bottom: 2),));
  }
}