import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:imageGallery/core/resources/dimensions.dart';
import 'package:imageGallery/core/resources/strings.dart';

class NoImagesWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          FeatherIcons.image,
          size: Dimensions.getConvertedWidthSize(context, 45),
        ),
        SizedBox(
          height: Dimensions.getConvertedHeightSize(context, 15),
        ),
        Text(
          Strings(context).noImage,
          style: TextStyle(
            fontSize: Dimensions.getTextSize(context, 20),
          ),
        ),
      ],
    );
  }
}
