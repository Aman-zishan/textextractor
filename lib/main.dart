import 'package:flutter/material.dart';
import 'package:textextractor/widgets/customAppBar.dart';
import 'package:textextractor/widgets/customButtons.dart';

import 'widgets/customCards/cardList.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TextExtractor',
      theme: ThemeData.dark(),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: LayoutBuilder(
        builder: (_, constraints) {
          return Container(
              width: constraints.maxWidth,
              child: Column(
                // This column contains everything exept AppBar

                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //Two buttons to call imagePicker

                  ButtonBar(
                    buttonPadding: EdgeInsets.all(0),
                    buttonMinWidth: constraints.maxWidth / 2,
                    buttonTextTheme: ButtonTextTheme.primary,
                    children: [
                      CustomButton(
                          onPressed: () {},
                          text: " Camera",
                          icon: Icon(Icons.camera_alt)),
                      CustomButton(
                          onPressed: () {},
                          text: " Gallery",
                          icon: Icon(Icons.filter))
                    ],
                  ),

                  // Horizontal List of cards to display image and detected text
                  // change maxHeight and maxWidth inside cardList.dart to change size
                  CardList(
                    maxHeight: constraints.maxHeight,
                    maxWidth: constraints.maxWidth,
                    onPageChange: (int index) => setState(() => _index = index),
                  ),

                  // Button to finally download text
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CustomButton(
                      text: "Download Text",
                      icon: Icon(Icons.download_rounded),
                      onPressed: () {
                        print("ddd");
                      },
                    ),
                  )
                ],
              ));
        },
      ),
    );
  }
}
