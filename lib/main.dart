import 'dart:io';

import 'package:flutter/material.dart';
import 'package:textextractor/data/detectText.dart';
import 'package:textextractor/data/saveText.dart';
import 'package:textextractor/widgets/customAppBar.dart';
import 'package:textextractor/widgets/customButtons.dart';
import 'package:image_picker/image_picker.dart';
import 'widgets/customCards/cardList.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TextExtractor',
      theme: ThemeData.dark().copyWith(accentColor: Colors.orange),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File _image;
  String detectedText;
  final picker = ImagePicker();
  final PageController pc = PageController();

  void saveFile(context) {
    if (detectedText == null || _image == null) {
      Scaffold.of(context).showSnackBar(
          SnackBar(content: Text("No text"), duration: Duration(seconds: 1)));
      return;
    }
    saveText(detectedText).then((value) => Scaffold.of(context).showSnackBar(
        SnackBar(
            content: Text("Text saved in $value"),
            duration: Duration(seconds: 1))));
  }

  // get Image
  Future getImage(ImageSource source) async {
    //get image
    final pickedFile = await picker.getImage(source: source);
    //change page
    pc.animateToPage(1, duration: Duration(seconds: 1), curve: Curves.easeIn);
    setState(() {
      if (pickedFile != null) {
        detectedText = null;
        _image = File(pickedFile.path);
        //detect changes
        detectText(pickedFile.path).then((value) => setState(() {
              detectedText = value;
            }));
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    pc.dispose();
    super.dispose();
  }

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
                          onPressed: () {
                            getImage(ImageSource.camera);
                          },
                          text: " Camera",
                          icon: Icon(Icons.camera_alt)),
                      CustomButton(
                          onPressed: () {
                            getImage(ImageSource.gallery);
                          },
                          text: " Gallery",
                          icon: Icon(Icons.filter))
                    ],
                  ),

                  // Horizontal List of cards to display image and detected text
                  // change maxHeight and maxWidth inside cardList.dart to change size
                  CardList(
                    pageController: pc,
                    maxHeight: constraints.maxHeight,
                    maxWidth: constraints.maxWidth,
                    onPageChange: (int index) {},
                    imageFile: _image,
                    text: detectedText,
                  ),

                  // Button to finally download text
                  DownloadButton(onPressed: (context) => saveFile(context))
                ],
              ));
        },
      ),
    );
  }
}

class DownloadButton extends StatelessWidget {
  final Function onPressed;
  const DownloadButton({
    Key key,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: CustomButton(
        text: "Download Text",
        icon: Icon(Icons.download_rounded),
        onPressed: () => onPressed(context),
      ),
    );
  }
}
