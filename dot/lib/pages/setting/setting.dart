import 'package:dot/localize/applications.dart';
import 'package:dot/localize/translate.dart';
import 'package:dot/pages/new/aboutUs.dart';
import 'package:dot/pages/new/accountprofile.dart';
import 'package:dot/pages/setting/addEmail.dart';
import 'package:dot/pages/setting/help.dart';
import 'package:dot/pages/setting/updateProfile.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Setting extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {

  String fname;
  String company;
  String address;
  String phone;
  String userEmail;
  getUser() async {
    SharedPreferences prf = await SharedPreferences.getInstance();
    setState(() {
      userEmail = prf.getString("email");
      fname = prf.getString("fullName");
      company = prf.getString("company");
      address = prf.getString("address");
      phone = prf.getString("phone");
    });
  }

  static final List<String> languagesList = application.supportedLanguages;
  static final List<String> languageCodesList =
      application.supportedLanguagesCodes;

  final Map<dynamic, dynamic> languagesMap = {
    languagesList[0]: languageCodesList[0],
    languagesList[1]: languageCodesList[1],
    languagesList[2]: languageCodesList[2],
  };

  String label = languagesList[0];

  final formKey = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    application.onLocaleChanged = onLocaleChange;
    onLocaleChange(Locale(languagesMap["ኣማርኛ"]));

    super.initState();
  }

  void onLocaleChange(Locale locale) async {
    setState(() {
      AppTranslations.load(locale);
    });
  }

  @override
  void dispose() {

    super.dispose();
  }

  void _select(String language) {
    print("dd "+language);
    onLocaleChange(Locale(languagesMap[language]));

  }


  @override
  Widget build(BuildContext context) {
    if (userEmail == null) {
      getUser();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(AppTranslations.of(context).text('setting')),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage("assets/Amete.jpg"),
                radius: 28,
              ),
              title: Text("$fname"),
              subtitle: Text("$company"),
              trailing: IconButton(
                onPressed: () {
                  debugPrint("Edit Profile");
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ProfileUpdate()));
                },
                icon: CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.blue,
                  child: Icon(Icons.edit),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Container(
                color: Colors.blue[50],
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      ListTile(
                        leading: Icon(Icons.language, color: Colors.blue),
                        title: Text(
                          AppTranslations.of(context).text('language'),
                          style: TextStyle(color: Colors.blue),
                        ),
                        trailing: PopupMenuButton<String>(
                          // overflow menu
                          onSelected: _select,
                          icon: new Icon(Icons.arrow_drop_down, color: Colors.blue[300]),
                          itemBuilder: (BuildContext context) {
                            return languagesList
                                .map<PopupMenuItem<String>>((String choice) {
                              return PopupMenuItem<String>(
                                value: choice,
                                child: Text(choice),
                              );
                            }).toList();
                          },
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.settings, color: Colors.blue),
                        title: Text(
                          AppTranslations.of(context).text('general'),
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                      ListTile(
                        onTap: () => Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Profile())),
                        leading: Icon(Icons.person, color: Colors.blue),
                        title: Text(
                          AppTranslations.of(context).text('account'),
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                      ListTile(
                        onTap: () => Navigator.push(context,
                            MaterialPageRoute(builder: (context) => AboutUs())),
                        leading: Icon(FontAwesomeIcons.infoCircle,
                            color: Colors.blue),
                        title: Text(
                          AppTranslations.of(context).text('aboutus'),
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                      ListTile(
                        onTap: () => Navigator.push(context,
                            MaterialPageRoute(builder: (context) => AddEmail())),
                        leading: Icon(Icons.help, color: Colors.blue),
                        title: Text(
                          AppTranslations.of(context).text('help'),
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                      ListTile(
                        onTap: () => Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Help())),
                        leading: Icon(Icons.help, color: Colors.blue),
                        title: Text(
                          AppTranslations.of(context).text('help'),
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
