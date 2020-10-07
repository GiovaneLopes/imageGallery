import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imageGallery/core/resources/dimensions.dart';
import 'package:imageGallery/core/resources/strings.dart';
import 'package:imageGallery/core/ui/loading_widget.dart';
import 'package:imageGallery/core/ui/theme.dart';
import 'package:imageGallery/features/gallery/domain/entities/image_gallery.dart';
import 'package:imageGallery/features/gallery/presentation/bloc/gallery_bloc.dart'
    as _galleryBloc;
import 'package:imageGallery/features/gallery/presentation/widgets/button_app_bar_widget.dart';
import 'package:imageGallery/features/gallery/presentation/widgets/floating_action_button_widget.dart';
import 'package:imageGallery/features/gallery/presentation/widgets/gallery_grid.dart';
import 'package:imageGallery/features/gallery/presentation/widgets/gallery_list.dart';
import 'package:imageGallery/features/gallery/presentation/widgets/sign_out_dialog.dart';
import 'package:provider/provider.dart';

class GalleryScreenPage extends StatefulWidget {
  @override
  _GalleryScreenPageState createState() => _GalleryScreenPageState();
}

class _GalleryScreenPageState extends State<GalleryScreenPage> {
  List<ImageGallery> _images= List<ImageGallery>();
  int _currentTab = 0;

  @override
  void initState() {
    super.initState();
    _images = List<ImageGallery>();
  }

  Widget _buildBody(BuildContext context, List<ImageGallery> images) {
    List<Widget> tabs = [
      // Grid tab
      GalleryGrid(images: images),
      // List tab
      GalleryList(images: images),
    ];
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            padding:
                Dimensions.getEdgeInsets(context, top: 50, left: 30, right: 30),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    // App name
                    Text(
                      Strings(context).appName,
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
            padding:
                Dimensions.getEdgeInsets(context, top: 50, left: 30, right: 30),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                TabBar(
                  indicatorColor: _buildThemetab(),
                  labelColor: _buildThemetab(),
                  unselectedLabelColor: _buildThemetab().withOpacity(.25),
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
              child: tabs[_currentTab],
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButtonWidget(listLength: images.length,),
      bottomNavigationBar: BottomAppBarWidget(),
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
      child: BlocListener<_galleryBloc.GalleryBloc, _galleryBloc.GalleryState>(
        listener: (context, state) {
          if (state is _galleryBloc.Error) {
            SnackBar(content: Text("Error"));
          }
        },
        child: BlocBuilder<_galleryBloc.GalleryBloc, _galleryBloc.GalleryState>(
          builder: (context, state) {
            if (state is _galleryBloc.Loading) {
              return LoadingWidget(
                _buildBody(context, List<ImageGallery>()),
              );
            } else if (state is _galleryBloc.Loaded) {
              _images = state.images;
              _images.sort((a,b)=> b.order.compareTo(a.order));
              return _buildBody(context, _images);
            } else {
              return _buildBody(context, List<ImageGallery>());
            }
          },
        ),
      ),
    );
  }
}
