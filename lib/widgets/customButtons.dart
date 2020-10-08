import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  final String text;
  final Function onPressed;
  final Icon icon;

  CustomButton(
      {@required this.text, @required this.icon, @required this.onPressed});

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool _highlight = false;
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      textColor: _highlight ? Colors.orange : Colors.white,
      padding: EdgeInsets.all(18),
      onPressed: widget.onPressed,
      color: Colors.orange,
      highlightColor: Colors.white,
      onHighlightChanged: (high) => setState(() {
        _highlight = high;
      }),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          widget.icon,
          Text(
            widget.text,
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
      shape: Border.all(width: 0),
    );
  }
}
