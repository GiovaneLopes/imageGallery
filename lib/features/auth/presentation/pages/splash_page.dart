import 'package:flutter/material.dart';
import 'package:imageGallery/core/resources/dimensions.dart';
import 'package:imageGallery/core/resources/images.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: _buidSplashScreen(context),
      ),
    );
  }

  Widget _buidSplashScreen(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/authPage');
      },
      child: Container(
        alignment: Alignment.center,
        child: Image.asset(
          Images.logo,
          width: Dimensions.getConvertedWidthSize(context, 741),
          height: Dimensions.getConvertedHeightSize(context, 265),
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
