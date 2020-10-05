import 'package:flutter/material.dart';
import 'package:imageGallery/core/resources/dimensions.dart';
import 'package:imageGallery/core/ui/theme.dart';
import 'package:provider/provider.dart';

class ButtonApp extends StatelessWidget {
  final String title;
  final Function onPressed;
  final ButtonType type;
  final IconData preffixIcon;
  final IconData suffixIcon;

  const ButtonApp({
    Key key,
    @required this.title,
    @required this.onPressed,
    @required this.type,
    this.preffixIcon,
    this.suffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeChanger _themeChanger = Provider.of<ThemeChanger>(context);
    return Row(
      children: <Widget>[
        Expanded(
          child: FlatButton(
            padding: Dimensions.getEdgeInsets(context, top: 18, bottom: 18),
            shape: OutlineInputBorder(
              borderSide: BorderSide(
                color: _themeChanger.getThemeData() == false
                    ? Colors.white
                    : Colors.transparent,
                width: Dimensions.getConvertedWidthSize(context, 2),
              ),
              borderRadius: BorderRadius.circular(
                Dimensions.getConvertedWidthSize(context, 10),
              ),
            ),
            color: (type == ButtonType.BUTTON_BLACK)
                ? Colors.black
                : Colors.transparent,
            onPressed: onPressed,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: Dimensions.getTextSize(context, 20),
                      color: type == ButtonType.BUTTON_BLACK
                          ? Colors.white
                          : _themeChanger.getThemeData() == false
                              ? Colors.black
                              : Colors.white),
                ),
                (suffixIcon != null)
                    ? Row(
                        children: <Widget>[
                          SizedBox(
                            width:
                                Dimensions.getConvertedWidthSize(context, 15),
                          ),
                          Icon(
                            suffixIcon,
                            size: Dimensions.getConvertedWidthSize(context, 25),
                          ),
                        ],
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

enum ButtonType { BUTTON_BLACK, BUTTON_WHITE }
