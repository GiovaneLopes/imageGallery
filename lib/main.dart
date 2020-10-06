import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:imageGallery/features/auth/presentation/pages/splash_page.dart';
import 'package:imageGallery/features/gallery/presentation/pages/gallery_screen_page.dart';
import 'package:internationalization/internationalization.dart';
import 'package:provider/provider.dart';

import 'core/ui/theme.dart';
import 'features/auth/presentation/pages/auth_page.dart';
import 'features/auth/presentation/pages/verify_email_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Internationalization.loadConfigurations();
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
        supportedLocales: suportedLocales,
        localizationsDelegates: [
          Internationalization.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        routes: <String, WidgetBuilder>{
          '/': (BuildContext context) => SplashPage(),
          '/authPage': (BuildContext context) => AuthPage(),
          '/galleryScreen': (BuildContext context) => GalleryScreenPage(),
          '/verifyEmailPage': (BuildContext context) => VerifyEmailPage(),
        });
  }
}
