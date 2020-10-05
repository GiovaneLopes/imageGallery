import 'package:flutter/material.dart';
import 'package:imageGallery/core/resources/dimensions.dart';

class BottomAppBarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      notchMargin: Dimensions.getConvertedWidthSize(context, 4),
      child: Container(
        height: Dimensions.getConvertedHeightSize(context, 50),
        child: Row(
          children: <Widget>[],
        ),
      ),
      shape: CircularNotchedRectangle(),
    );
  }
}
