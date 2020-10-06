import 'package:flutter/material.dart';
import 'package:imageGallery/core/resources/dimensions.dart';
import 'package:imageGallery/core/ui/high_contrast_button.dart';

class BottomAppBarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      notchMargin: Dimensions.getConvertedWidthSize(context, 4),
      child: Container(
        padding: Dimensions.getEdgeInsets(context, right: 20),
        height: Dimensions.getConvertedHeightSize(context, 50),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            HighContrastButton(),
          ],
        ),
      ),
      shape: CircularNotchedRectangle(),
    );
  }
}
