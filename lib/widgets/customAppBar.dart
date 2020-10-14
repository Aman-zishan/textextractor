import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  CustomAppBar({Key key})
      : preferredSize = Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize;

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: widget.preferredSize.height,
        width: double.infinity,
        // color: Colors.red,
        child: Stack(
          children: [
            Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: Icon(Icons.settings),
                  onPressed: () {},
                )),
            Align(
                alignment: Alignment.center,
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                          text: "Text",
                          style: TextStyle(
                              color: Colors.deepOrange, fontFamily: 'Poppins')),
                      TextSpan(
                          text: "Extractor2",
                          style: TextStyle(fontFamily: 'Poppins')),
                      TextSpan(
                          text: ".",
                          style: TextStyle(color: Colors.deepOrange)),
                      TextSpan(text: "0"),
                    ],
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        fontSize: Theme.of(context)
                            .primaryTextTheme
                            .headline4
                            .fontSize),
                    // style: TextStyle(backgroundColor: Colors.green),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
