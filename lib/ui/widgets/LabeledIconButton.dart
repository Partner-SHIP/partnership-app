import 'package:flutter/material.dart';

class LabeledIconButton extends StatelessWidget
{
  Function _onPressed;
  String _text;
  Icon _icon;
  TextAlign _align;
  String _toolTip;  
  double _iconSize;
  LabeledIconButton({@required Function onPressed, @required String text, @required Icon icon, TextAlign align = TextAlign.left, String toolTip, double iconSize = 30.0 }) {
    _onPressed = onPressed;
    _text = text;
    _icon = icon;
    _align = align;
    _toolTip = toolTip;
    _iconSize = iconSize;
  }
  @override
  Widget build(BuildContext context) {
    Widget icon = IconButton(
        icon: _icon,
        iconSize: _iconSize,
        tooltip: _toolTip,
        onPressed: _onPressed);
    Widget text = Text(_text);
    List<Widget> labeledIconButton = List<Widget>();
    if (_align == TextAlign.right)
      labeledIconButton.addAll([icon, text]);
    else
      labeledIconButton.addAll([text, icon]);
    return (Padding(padding:EdgeInsets.all(8.0), child:Row(children: labeledIconButton,)));
  }
}