import 'package:flutter/material.dart';
import 'package:imageGallery/features/gallery/presentation/pages/gallery_screen_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routes: <String, WidgetBuilder>{
          '/': (BuildContext context) => GalleryScreenPage(),
        });
  }
}
