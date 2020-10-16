import 'package:flutter/material.dart';

import 'customButtons.dart';

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
        icon: Icon(Icons.file_download),
        onPressed: () => onPressed(context),
      ),
    );
  }
}
