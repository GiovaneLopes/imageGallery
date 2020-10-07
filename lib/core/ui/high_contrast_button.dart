import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:imageGallery/core/resources/dimensions.dart';
import 'package:imageGallery/core/ui/theme.dart';
import 'package:provider/provider.dart';

class HighContrastButton extends StatefulWidget {
  @override
  _HighContrastButtonState createState() => _HighContrastButtonState();
}

class _HighContrastButtonState extends State<HighContrastButton> {
  @override
  Widget build(BuildContext context) {
    ThemeChanger _themeChanger = Provider.of<ThemeChanger>(context);
    return //High contrast button
        Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        InkWell(
          onTap: () {
            setState(() {
              _themeChanger.changeTheme();
            });
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: Dimensions.getConvertedWidthSize(context, 50),
                margin: Dimensions.getEdgeInsets(context, top: 5),
                child: Switch(
                  value: _themeChanger.getThemeData(),
                  onChanged: (bool data) {
                    _themeChanger.changeTheme();
                  },
                ),
              ),
              Icon(
                FeatherIcons.moon,
                size: Dimensions.getConvertedWidthSize(context, 25),
                color: _themeChanger.getThemeData() == true
                    ? null
                    : Colors.black.withOpacity(.6),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
