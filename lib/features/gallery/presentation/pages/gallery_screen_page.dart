import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:imageGallery/core/resources/dimensions.dart';
import 'package:imageGallery/core/resources/strings.dart';
import 'package:imageGallery/features/gallery/presentation/models/image_gallery.dart';
import 'package:imageGallery/features/gallery/presentation/widgets/gallery_grid.dart';
import 'package:imageGallery/features/gallery/presentation/widgets/gallery_list.dart';
import 'package:imageGallery/features/gallery/presentation/widgets/sign_out_dialog.dart';

class GalleryScreenPage extends StatefulWidget {
  @override
  _GalleryScreenPageState createState() => _GalleryScreenPageState();
}

class _GalleryScreenPageState extends State<GalleryScreenPage> {
  List<ImageGallery> _images = [
    ImageGallery(
        imageLink:
            "https://lh3.googleusercontent.com/proxy/fUxz8UK3BO1UCfJQAUIhlqRnMyVWUe1qxnpWOAOIrBOi8IoT4QAseoGgwfzdRW-l_qsHi6WjsWVsSIiDDDzMnckGzZnut1Fj2Y-POvMtUym8wAdNhyFnHqU",
        name: "Vazio",
        discription: "Teste",
        time: "05/10/2020"),
    ImageGallery(
        imageLink:
            "https://lh3.googleusercontent.com/proxy/fUxz8UK3BO1UCfJQAUIhlqRnMyVWUe1qxnpWOAOIrBOi8IoT4QAseoGgwfzdRW-l_qsHi6WjsWVsSIiDDDzMnckGzZnut1Fj2Y-POvMtUym8wAdNhyFnHqU",
        name: "Vazio",
        discription: "Teste",
        time: "05/10/2020"),
  ];
  int _currentTab = 0;

  // @override
  // void initState() {
  //   super.initState();
  //   _images = null;
  // }

  Widget _buildBody(BuildContext context, List<ImageGallery> images) {
    List<Widget> tabs = [
      // Grid tab
      GalleryGrid(images: images),
      // List tab
      GalleryList(images: images),
    ];
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Container(
          padding:
              Dimensions.getEdgeInsets(context, top: 50, left: 30, right: 30),
          color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  // App name
                  Text(
                    Strings.app_name,
                    style: TextStyle(
                      fontSize: Dimensions.getTextSize(context, 20),
                    ),
                  ),
                  //Log out icon
                  InkWell(
                    onTap: () {
                      // Signout Icon
                      showDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (BuildContext context) {
                          return SignoutDialog();
                        },
                      );
                    },
                    child: Icon(
                      FeatherIcons.logOut,
                      size: Dimensions.getConvertedWidthSize(context, 24),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        Container(
          color: Colors.white,
          padding:
              Dimensions.getEdgeInsets(context, top: 50, left: 30, right: 30),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              TabBar(
                indicatorColor: Colors.black,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.black.withOpacity(.25),
                indicatorSize: TabBarIndicatorSize.tab,
                tabs: <Widget>[
                  //Grid Tab
                  Tab(
                    icon: Icon(
                      FeatherIcons.grid,
                      size: Dimensions.getConvertedWidthSize(context, 24),
                    ),
                  ),
                  //List Tab
                  Tab(
                    icon: Icon(
                      FeatherIcons.list,
                      size: Dimensions.getConvertedWidthSize(context, 24),
                    ),
                  ),
                ],
                onTap: (index) {
                  setState(() {
                    _currentTab = index;
                  });
                },
              ),
            ],
          ),
        ),
        Expanded(
          child:
              // Tab contents
              Container(
            width: double.infinity,
            padding: Dimensions.getEdgeInsets(context, left: 30, right: 30),
            color: Colors.white,
            child: tabs[_currentTab],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: _buildBody(context, _images),
      ),
    );
  }
}
