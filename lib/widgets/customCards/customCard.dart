import 'package:flutter/material.dart';

import 'swipeIndicator.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    Key key,
    @required this.height,
    @required this.width,
    @required this.child,
    @required this.labelPosition,
    @required this.hmargin,
  }) : super(key: key);

  final double height;
  final double width;
  final double hmargin;
  final Widget child;
  final int labelPosition;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      margin: EdgeInsets.symmetric(horizontal: hmargin, vertical: 5),
      color: Colors.white,
      elevation: 6,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: Colors.white, width: 10)),
      child: SizedBox(
        height: height,
        width: width,
        child: Stack(
          children: [
            Container(
              height: height,
              width: width,
              child: child,
              // foregroundDecoration: BoxDecoration(color: Colors.blue),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                // foregroundDecoration: BoxDecoration(color: Colors.green),
                child: SwipeIndicator(
                  width: width,
                  labelPosition: labelPosition,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
