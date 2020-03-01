//import 'package:flutter/material.dart';
//import 'package:pixelsales/applications.dart';
//import 'package:pixelsales/translate.dart';
//
//import 'generalSettings.dart';
//
//class Settinggs extends StatefulWidget {
//  @override
//  _SettingState createState() => _SettingState();
//}
//
//class _SettingState extends State<Settinggs> {
//
//  static final List<String> languagesList = application.supportedLanguages;
//  static final List<String> languageCodesList =
//      application.supportedLanguagesCodes;
//
//  final Map<dynamic, dynamic> languagesMap = {
//    languagesList[0]: languageCodesList[0],
//    languagesList[1]: languageCodesList[1],
//    languagesList[2]: languageCodesList[2],
//
//  };
//
//  String label = languagesList[0];
//
//  final formKey = new GlobalKey<FormState>();
//  final scaffoldKey = new GlobalKey<ScaffoldState>();
//
//
//  @override
//  void initState() {
//    super.initState();
//    application.onLocaleChanged = onLocaleChange;
//    onLocaleChange(Locale(languagesMap["ኣማርኛ"]));
//  }
//
//  void onLocaleChange(Locale locale) async {
//    setState(() {
//      AppTranslations.load(locale);
//    });
//  }
//
//  @override
//  void dispose() {
//
//    super.dispose();
//  }
//
//  void _select(String language) {
//    print("dd "+language);
//    onLocaleChange(Locale(languagesMap[language]));
//    setState(() {
//      if (language == "Hindi") {
//        label = "हिंदी";
//      } else {
//        label = language;
//      }
//    });
//  }
//  String lang ;
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title: Text(AppTranslations.of(context).text('setting')),
//      ),
//      body: SingleChildScrollView(
//        scrollDirection: Axis.vertical,
//        child: Column(
//          children: <Widget>[
//
//            ListTile(
//              leading: CircleAvatar(
//                backgroundImage: AssetImage("images/stadium.jpg"),
//                radius: 28,
//              ),
//              title: Text("Selam Hagos"),
//              subtitle: Text("Manager"),
//              trailing: IconButton(
//                onPressed: () {
//                  debugPrint("Edit Profile");
//                },
//                icon: CircleAvatar(
//                  radius: 20,
//                  backgroundColor: Colors.blue,
//                  child: Icon(Icons.edit),
//                ),
//              ),
//            ),
//            Padding(
//              padding: const EdgeInsets.all(30.0),
//              child: Container(
//                height: 304,
//                width: 311,
//                color: Colors.blue[50],
//                child: Center(
//                  child: Column(
//                    mainAxisAlignment: MainAxisAlignment.center,
//                    crossAxisAlignment: CrossAxisAlignment.center,
//                    children: <Widget>[
//                      ListTile(
//                        leading: Icon(Icons.language, color: Colors.blue),
//                        title: Text(
//                          AppTranslations.of(context).text('language'),
//                          style: TextStyle(color: Colors.blue),
//                        ),
//                      trailing: DropdownButton(
//                          icon: Align(
//                            alignment: Alignment.centerRight,
//                            child: Icon(Icons.arrow_drop_down,
//                                color: Colors.blue[300]),
//                          ),
//                          //value: _itemName,
//                          //hint: Text('Item Name'),
//                          onChanged: (String value) {
//                            setState(() {
//                              _select(value);
//                            });
//                          },
//                          items: languagesList
//                              .map(
//                                (item) => DropdownMenuItem(
//                                  child: Text(item),
//                                  value: item,
//                                ),
//                              )
//                              .toList(),
//                        ),// PopupMenuButton<String>(
//            //   // overflow menu
//            //   onSelected: _select,
//            //   icon: new Icon(Icons.language, color: Colors.blueGrey),
//            //   itemBuilder: (BuildContext context) {
//            //     return languagesList
//            //         .map<PopupMenuItem<String>>((String choice) {
//            //       return PopupMenuItem<String>(
//            //         value: choice,
//            //         child: Text(choice),
//            //       );
//            //     }).toList();
//            //   },
//            // ),
//                      ),
//                      ListTile(
//                        onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)
//                        =>GeneralSettings())),
//                        leading: Icon(Icons.settings, color: Colors.blue),
//                        title: Text(
//                          AppTranslations.of(context).text('general'),
//                          style: TextStyle(color: Colors.blue),
//
//                        ),
//                      ),
//                      ListTile(
//                        leading: Icon(Icons.person, color: Colors.blue),
//                        title: Text(
//                          AppTranslations.of(context).text('account'),
//                          style: TextStyle(color: Colors.blue),
//                        ),
//                      ),
//                     ListTile(
//                        leading: Icon(Icons.lock, color: Colors.blue),
//                        title: Text(
//                          AppTranslations.of(context).text('privacy'),
//                          style: TextStyle(color: Colors.blue),
//                        ),
//                      ),
//                      ListTile(
//                        leading: Icon(Icons.help, color: Colors.blue),
//                        title: Text(
//                          AppTranslations.of(context).text('help'),
//                          style: TextStyle(color: Colors.blue),
//                        ),
//                      ),
//                    ],
//                  ),
//                ),
//              ),
//            )
//          ],
//        ),
//      ),
//    );
//  }
//}