import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';

import 'jsonFile.dart';

class GeneralSettings extends StatefulWidget {
  @override
  _GeneralSettingsState createState() => _GeneralSettingsState();
}

class _GeneralSettingsState extends State<GeneralSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Example App")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text("Next Theme"),
              onPressed: ThemeProvider.controllerOf(context).nextTheme,
            ),
            RaisedButton(
              child: Text("Theme Dialog"),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (_) => ThemeConsumer(child: ThemeDialog()));
              },
            ),
            RaisedButton(
              child: Text("Second Screen"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ThemeConsumer(child: JsonFile()),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
