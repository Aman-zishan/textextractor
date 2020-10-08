import 'package:flutter/material.dart';
import 'customCard.dart';

class CardList extends StatelessWidget {
  final Function onPageChange;
  final double maxHeight;
  final double maxWidth;
  const CardList({
    Key key,
    @required this.onPageChange,
    @required this.maxHeight,
    @required this.maxWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // change the following values to change card dimensions

    double cardHeight = maxHeight * 0.75 - 10;
    double cardWidth = maxWidth;
    return SizedBox(
      height: cardHeight + 10,
      width: maxWidth,
      child: PageView.builder(
        itemCount: 2,
        controller: PageController(),
        onPageChanged: onPageChange,
        itemBuilder: (_, i) {
          // child is the content in card
          //labelPosition = 0 => right else left
          return CustomCard(
            labelPosition: i,
            height: cardHeight,
            width: cardWidth,
            child: Image.network(
              "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/1200px-Image_created_with_a_mobile_phone.png",
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }
}
