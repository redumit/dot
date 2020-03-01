import 'package:dot/pages/homePage.dart';
import 'package:dot/pages/login/registerLogin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'localize/app_translate_delegate.dart';
import 'localize/applications.dart';

void main() => runApp(MyApps());

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(),
    );
  }
}
class MyApps extends StatefulWidget {
  @override
  _MyAppsState createState() => _MyAppsState();
}

class _MyAppsState extends State<MyApps> {
  AppTranslationsDelegate _newLocaleDelegate;

  @override
  void initState() {
    super.initState();
    _newLocaleDelegate = AppTranslationsDelegate(newLocale: null);
    application.onLocaleChanged = onLocaleChange;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
      localizationsDelegates: [
        _newLocaleDelegate,
        //provides localised strings
        GlobalMaterialLocalizations.delegate,
        //provides RTL support
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale("en", ""),
        const Locale("tig", ""),
        const Locale("am", ""),
      ],
    );
  }

  void onLocaleChange(Locale locale) {
    setState(() {
      _newLocaleDelegate = AppTranslationsDelegate(newLocale: locale);
    });
  }
}

