import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:imageGallery/core/resources/dimensions.dart';
import 'package:imageGallery/core/resources/strings.dart';
import 'package:imageGallery/core/ui/button_app.dart';

class SignoutDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: Dimensions.getEdgeInsetsAll(context, 22),
        height: Dimensions.getConvertedHeightSize(context, 291),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            Dimensions.getConvertedWidthSize(context, 15),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                // Sign out title
                Text(
                  Strings.signout_title,
                  style: TextStyle(
                    fontSize: Dimensions.getTextSize(context, 24),
                    fontWeight: FontWeight.w300,
                  ),
                ),
                // Close dialog icon
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    FeatherIcons.x,
                    size: Dimensions.getConvertedWidthSize(context, 18),
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child:
                      // Sign out confirmation text
                      Text(
                    Strings.signout_confirmation_text,
                    style: TextStyle(
                      fontSize: Dimensions.getTextSize(context, 18),
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ],
            ),
            // Yes button
            ButtonApp(
              title: Strings.yes,
              onPressed: () {},
              type: ButtonType.BUTTON_WHITE,
            ),
            // No button
            ButtonApp(
              title: Strings.cancel_title,
              onPressed: () {
                Navigator.pop(context);
              },
              type: ButtonType.BUTTON_BLACK,
            ),
          ],
        ),
      ),
    );
  }
}
