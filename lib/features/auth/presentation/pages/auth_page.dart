import 'package:flutter/material.dart';
import 'package:imageGallery/core/resources/dimensions.dart';
import 'package:imageGallery/core/resources/images.dart';
import 'package:imageGallery/core/resources/strings.dart';
import 'package:imageGallery/core/ui/theme.dart';
import 'package:imageGallery/features/auth/presentation/widgets/register_form.dart';
import 'package:imageGallery/features/auth/presentation/widgets/signin_form.dart';
import 'package:provider/provider.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  int _currentTab = 0;

  Widget _buildBody(BuildContext context) {
    List<Widget> tabs = [
      SigninForm(),
      RegisterForm(),
    ];
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: SingleChildScrollView(
        child: Container(
          padding: Dimensions.getEdgeInsets(context, top: 80),
          child: Column(
            children: <Widget>[
              Image.asset(
                Images.logo,
                width: Dimensions.getConvertedWidthSize(
                  context,
                  200,
                ),
              ),
              Container(
                padding: Dimensions.getEdgeInsets(context,
                    top: 50, left: 29, right: 29),
                child: TabBar(
                  indicatorColor: _buildThemetab(),
                  labelColor: _buildThemetab(),
                  unselectedLabelColor: _buildThemetab().withOpacity(.25),
                  labelStyle: TextStyle(
                    fontSize: Dimensions.getTextSize(context, 20),
                  ),
                  indicatorSize: TabBarIndicatorSize.tab,
                  tabs: <Widget>[
                    //Sign in tab
                    Tab(
                      text: Strings.signin_title,
                    ),
                    //Register tab
                    Tab(
                      text: Strings.register_title,
                    ),
                  ],
                  onTap: (index) {
                    setState(() {
                      _currentTab = index;
                    });
                  },
                ),
              ),
              SizedBox(
                height: Dimensions.getConvertedHeightSize(context, 20),
              ),
              Container(
                width: double.infinity,
                padding: Dimensions.getEdgeInsets(context, left: 30, right: 30),
                child: tabs[_currentTab],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _buildThemetab() {
    ThemeChanger _themeChanger = Provider.of<ThemeChanger>(context);

    return _themeChanger.getThemeData() == false ? Colors.black : Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: _buildBody(context),
      ),
    );
  }
}
