import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:textextractor/data/detectText.dart';
import 'package:textextractor/data/saveText.dart';
import 'package:textextractor/widgets/customAppBar.dart';
import 'package:textextractor/widgets/customButtons.dart';
import 'package:textextractor/widgets/customCards/cardList.dart';
import 'package:textextractor/widgets/download_button.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<bool> _onWillPop() {
    return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            elevation: 24.0,
            title: Text('Are you sure?'),
            content: Text('Do you want to exit'),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('No'),
              ),
              FlatButton(
                onPressed: () => exit(0),
                /*Navigator.of(context).pop(true)*/
                child: Text('Yes'),
              ),
            ],
          ),
        ) ??
        false;
  }

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
  Future getImage(ImageSource source, BuildContext ctx) async {
    //get image
    final pickedFile = await picker.getImage(
      source: source,
      // max 500p by 500p
      maxHeight: 500,
      maxWidth: 500,
    );
    //change page
    pc.animateToPage(1, duration: Duration(seconds: 1), curve: Curves.easeIn);
    setState(() {
      if (pickedFile != null) {
        detectedText = null;
        _image = File(pickedFile.path);
        //detect changes
        detectText(pickedFile.path).then(
          (value) => setState(() {
            detectedText = value;
            print(detectedText);
          }),
          onError: (error) {
            if (error is DioError && error.type == DioErrorType.DEFAULT) {
              setState(() {
                detectedText = "Please check your internet connection";
                print(detectedText);
              });
              Scaffold.of(ctx).showSnackBar(SnackBar(
                  content: Text(detectedText), duration: Duration(seconds: 3)));
            } else {
              setState(() {
                detectedText = error.message;
                print(error.detectedText);
              });
            }
          },
        );
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
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
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

                    Builder(
                      //provides context to snackbar
                      builder: (ctx) => ButtonBar(
                        buttonPadding: EdgeInsets.all(0),
                        buttonMinWidth: constraints.maxWidth / 2,
                        buttonTextTheme: ButtonTextTheme.primary,
                        children: [
                          CustomButton(
                              onPressed: () {
                                getImage(ImageSource.camera, ctx);
                              },
                              text: " Camera",
                              icon: Icon(Icons.camera_alt)),
                          CustomButton(
                              onPressed: () {
                                getImage(ImageSource.gallery, ctx);
                              },
                              text: " Gallery",
                              icon: Icon(Icons.filter))
                        ],
                      ),
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
      ),
    );
  }
}
