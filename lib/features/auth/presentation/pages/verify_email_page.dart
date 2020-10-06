import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:imageGallery/core/resources/dimensions.dart';
import 'package:imageGallery/core/resources/images.dart';
import 'package:imageGallery/core/resources/strings.dart';
import 'package:imageGallery/core/ui/button_app.dart';

class VerifyEmailPage extends StatelessWidget {
  Widget _buildBody(BuildContext context) {
    return Container(
      padding: Dimensions.getEdgeInsetsFromLTRB(context, 37, 83, 37, 55),
      width: double.infinity,
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          // App name
          Text(
            Strings(context).appName,
            style: TextStyle(
              fontSize: Dimensions.getTextSize(context, 28),
            ),
          ),
          // Verify email image
          Padding(
            padding: Dimensions.getEdgeInsets(context, top: 35),
            child: Image.asset(Images.verifyEmail),
          ),
          Column(
            children: <Widget>[
              // Email verified button
              ButtonApp(
                title: Strings(context).emailVerified,
                onPressed: () {},
                type: ButtonType.BUTTON_BLACK,
              ),
              // Email email button
              ButtonApp(
                title: Strings(context).resendTitle,
                onPressed: () {
                  showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (BuildContext context) {
                      return _buildSendEmailDialog();
                    },
                  );
                },
                type: ButtonType.BUTTON_WHITE,
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildSendEmailDialog() {
    return Dialog(
      child: TweenAnimationBuilder(
        duration: Duration(milliseconds: 300),
        tween: Tween<double>(begin: 0, end: 1),
        builder: (BuildContext context, double scale, Widget widget) {
          return Transform.scale(
            scale: scale,
            child: Container(
              padding: Dimensions.getEdgeInsetsAll(context, 22),
              height: Dimensions.getConvertedHeightSize(context, 218),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  Dimensions.getConvertedWidthSize(context, 15),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: Dimensions.getConvertedWidthSize(context, 128),
                        child:
                            // Email sent dialog title
                            Text(
                          Strings(context).emailSentSuccessfully,
                          style: TextStyle(
                            fontSize: Dimensions.getTextSize(context, 18),
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                      // Close dialog icon
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          FeatherIcons.x,
                          size: Dimensions.getConvertedWidthSize(context, 24),
                        ),
                      ),
                    ],
                  ),
                  // Ok dialog button
                  ButtonApp(
                    title: Strings(context).okTitle,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    type: ButtonType.BUTTON_BLACK,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }
}
