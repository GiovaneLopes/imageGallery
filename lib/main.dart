import 'package:flutter/material.dart';
import 'package:imageGallery/features/gallery/presentation/pages/gallery_screen_page.dart';
import 'package:provider/provider.dart';

import 'core/ui/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeChanger>(
      create: (_) => ThemeChanger(ThemeData.light()),
      child: MaterialAppWithTheme(),
    );
  }
}

class MaterialAppWithTheme extends StatelessWidget {
  const MaterialAppWithTheme({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);
    return MaterialApp(
        title: 'Flutter Demo',
        theme: theme.getTheme(),
        routes: <String, WidgetBuilder>{
          '/': (BuildContext context) => GalleryScreenPage(),
        });
  }
}
