//
//
//import 'dart:async';
//import 'package:flutter/material.dart';
//import 'package:flutter_localizations/flutter_localizations.dart';
//import 'package:fortest/app_translate_delegate.dart';
//import 'package:fortest/applications.dart';
//import 'package:fortest/signup.dart';
//
//Future<Null> main() async {
//  runApp(new LocalisedApp());
//}
//
//class LocalisedApp extends StatefulWidget {
//  @override
//  LocalisedAppState createState() {
//    return new LocalisedAppState();
//  }
//}
//
//class LocalisedAppState extends State<LocalisedApp> {
//  AppTranslationsDelegate _newLocaleDelegate;
//
//  @override
//  void initState() {
//    super.initState();
//    _newLocaleDelegate = AppTranslationsDelegate(newLocale: null);
//    application.onLocaleChanged = onLocaleChange;
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      debugShowCheckedModeBanner: false,
//      home: SignUpUI(),
//      localizationsDelegates: [
//        _newLocaleDelegate,
//        //provides localised strings
//        GlobalMaterialLocalizations.delegate,
//        //provides RTL support
//        GlobalWidgetsLocalizations.delegate,
//      ],
//      supportedLocales: [
//        const Locale("en", ""),
//        const Locale("hi", ""),
//        const Locale("tig", ""),
//        const Locale("am", ""),
//      ],
//    );
//  }
//
//  void onLocaleChange(Locale locale) {
//    setState(() {
//      _newLocaleDelegate = AppTranslationsDelegate(newLocale: locale);
//    });
//  }
//}
