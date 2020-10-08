import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'customCard.dart';

class CardList extends StatelessWidget {
  final Function onPageChange;
  final double maxHeight;
  final double maxWidth;
  final File imageFile;
  final String text;
  final PageController pageController;
  const CardList(
      {Key key,
      @required this.onPageChange,
      @required this.maxHeight,
      @required this.maxWidth,
      @required this.imageFile,
      @required this.text,
      @required this.pageController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // change the following values to change card dimensions (for image only)

    double cardHeight = maxHeight * 0.75 - 10;
    double cardWidth = cardHeight * 9 / 16;

    var cards = <Widget>[
      CustomCard(
        labelPosition: 0,
        height: cardHeight,
        width: cardWidth,
        hmargin: (maxWidth - cardWidth) / 2,
        child: imageFile != null
            ? Image.file(
                imageFile,
                fit: BoxFit.cover,
              )
            : Image.network(
                //TODO Image Placeholder
                "https://demos.creative-tim.com/vue-black-dashboard-pro/img/image_placeholder.jpg",
                fit: BoxFit.contain,
              ),
      ),
      CustomCard(
          labelPosition: 1,
          height: cardHeight,
          width: maxWidth,
          hmargin: 20,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              // if no image => "No image selected"
              // if no text => loading
              // else text
              child: imageFile != null
                  ? (text != null
                      ? AutoSizeText(
                          text,
                          maxFontSize: 20,
                          minFontSize: 15,
                          style: TextStyle(
                            color: Colors.orange,
                          ),
                          textAlign: TextAlign.center,
                        )
                      : CircularProgressIndicator())
                  : Text(
                      "No Image Selected",
                      style: TextStyle(
                        color: Colors.orange,
                        fontSize: 20,
                      ),
                    ),
            ),
          ))
    ];
    return SizedBox(
      height: cardHeight + 10,
      width: maxWidth,
      child: PageView.builder(
        itemCount: 2,
        controller: pageController,
        onPageChanged: onPageChange,
        itemBuilder: (_, i) {
          // child is the content in card
          //labelPosition = 0 => right else left
          return cards[i];
        },
      ),
    );
  }
}
