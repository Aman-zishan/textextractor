import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SwipeIndicator extends StatelessWidget {
  const SwipeIndicator({
    Key key,
    @required this.width,
    @required this.labelPosition,
  }) : super(key: key);

  final double width;
  final int labelPosition;

  @override
  Widget build(BuildContext context) {
    var content = <Widget>[
      //reflect along y > to <
      Transform(
          transform: Matrix4.rotationY(labelPosition == 0 ? 3.1415926535 : 0),
          child: Icon(Icons.arrow_left)),
      //label for indicator
      Transform(
        transform:
            Matrix4.translationValues(labelPosition == 0 ? -20 : 0, 0, 0),
        child: Text(
          labelPosition == 0 ? "Text" : "Image",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      )
    ];
    // text first icon second
    if (labelPosition != 0) {
      content = content.reversed.toList();
    }
    return Shimmer.fromColors(
      baseColor: Colors.grey[400],
      highlightColor: Colors.grey[100],
      child: Container(
        width: width,
        padding: EdgeInsets.only(bottom: 20, left: 20),
        child: Row(
          mainAxisAlignment: labelPosition == 0
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: content,
        ),
      ),
    );
  }
}
