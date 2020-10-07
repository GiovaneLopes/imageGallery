import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:imageGallery/core/resources/dimensions.dart';
import 'package:imageGallery/features/gallery/presentation/widgets/select_image_source_dialog.dart';

class FloatingActionButtonWidget extends StatelessWidget {
  final int listLength;

  const FloatingActionButtonWidget({Key key, this.listLength}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.black,
      onPressed: () {
        showDialog(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext context) {
            // Select image source Dialog
            return SelectImageSourceDialog(listLength: listLength,);
          },
        );
      },
      // Plus icon
      child: Icon(
        FeatherIcons.plus,
        size: Dimensions.getConvertedWidthSize(context, 30),
        color: Colors.white,
      ),
      elevation: 4.0,
    );
  }
}
