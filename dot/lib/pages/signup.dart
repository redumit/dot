import 'package:dot/localize/applications.dart';
import 'package:dot/localize/translate.dart';
import 'package:dot/pages/analytics/analytics.dart';
import 'package:dot/pages/expense/expenseList.dart';
import 'package:dot/pages/generate/generateJson.dart';
import 'package:dot/pages/loan/loanList.dart';
import 'package:dot/pages/login/registerLogin.dart';
import 'package:dot/pages/material/materialList.dart';
import 'package:dot/pages/salary/salaryLists.dart';
import 'package:dot/pages/setting/setting.dart';
import 'package:dot/pages/sync/syncs.dart';
import 'package:dot/pages/today/service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

import '../main.dart';


class SignUpUI extends StatefulWidget {
  @override
  _SignUpScreenState createState() => new _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpUI> {
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
    super.initState();
    application.onLocaleChanged = onLocaleChange;
    onLocaleChange(Locale(languagesMap["ኣማርኛ"]));
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
    setState(() {
      if (language == "Hindi") {
        label = "हिंदी";
      } else {
        label = language;
      }
    });
  }

   @override
  Widget build(BuildContext context) {


    return  MaterialApp(

      home:Scaffold(
      key: scaffoldKey,
      appBar: AppBar(

        actions: <Widget>[
            PopupMenuButton<String>(
              // overflow menu
              onSelected: _select,
              icon: new Icon(Icons.language, color: Colors.white),
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
          ],
        title: ListTile(
          title: Center(
            child: Container(
              height: 50,
              width: 60,
              child: CircleAvatar(
                backgroundImage: AssetImage('images/stadium.jpg'),
              ),
            ),
          ),
          trailing: Padding(
            padding: const EdgeInsets.only(left:80,right: 0),
            child: Icon(Icons.more_vert,color: Colors.white,),
          ),
        ),
      ),
      drawer: Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
           child:UserAccountsDrawerHeader(
             accountEmail: Text('data'),
            accountName: Container(
              //padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundImage: AssetImage('images/stadium.jpg'),),
                    Text('Pixel Sales'),
                  ],
                )),
            ),
          ),),
          ListTile(leading: Icon(Icons.add_photo_alternate),
          title: Text(AppTranslations.of(context).text('home')),
          onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>MyApp(),))
          ,),
          ListTile(
            onTap:(){},//=> Navigator.push(context, MaterialPageRoute(builder: (context)=>Langs())),
            leading: Icon(Icons.folder),
          title: Text(AppTranslations.of(context).text('account')),),
          ListTile(leading: Icon(Icons.settings),
          title: Text(AppTranslations.of(context).text('sync')),),


          ListTile(leading: Icon(Icons.help),
          title: Text(AppTranslations.of(context).text('today')),),
          ListTile(leading: Icon(Icons.home),
          title: Text(AppTranslations.of(context).text('home')),),

        ],
      )
    ),
      body:  Container(
     height: MediaQuery.of(context).size.height * 0.5,
     child: GridView.count(
     padding: const EdgeInsets.all(20),
     crossAxisCount: 3,
     children: <Widget>[
     IconButton(
     onPressed: () {
     Navigator.of(context).push(MaterialPageRoute(
     builder: (context) => TodayActivity()));
     debugPrint("Today");
     },
     icon: Column(
     children: <Widget>[
     CircleAvatar(
     radius: 30,
     backgroundColor: Colors.blueGrey,
     child: Icon(
     Icons.calendar_today,
     size: 32,
     color: Colors.amberAccent,
     ),
     ),
     Container(
     padding: EdgeInsets.all(10), child: Text('Today'))
     ],
     ),
     iconSize: 100,
     ),
     IconButton(
     onPressed: () {
     debugPrint("Analysis");
     Navigator.of(context).push(MaterialPageRoute(
     builder: (context) => ReportAnalitic()));
     },
     icon: Column(
     children: <Widget>[
     CircleAvatar(
     radius: 30,
     backgroundColor: Colors.blue[50],
     child: Icon(Icons.insert_chart),
     ),
     Container(
     padding: EdgeInsets.all(10),
     child: Text('Analtics'))
     ],
     ),
     iconSize: 100,
     ),
     IconButton(
     onPressed: () {
     debugPrint("Salary");
     Navigator.of(context).push(MaterialPageRoute(
     builder: (context) => SalaryList()));
     },
     icon: Column(
     children: <Widget>[
     CircleAvatar(
     radius: 30,
     backgroundColor: Colors.pink[100],
     child: Icon(
     Icons.money_off,
     size: 30,
     color: Colors.white70,
     ),
     ),
     Container(
     padding: EdgeInsets.all(10), child: Text('Salary'))
     ],
     ),
     iconSize: 100,
     ),
     IconButton(
     onPressed: () {
     debugPrint("Material");
     Navigator.of(context).push(MaterialPageRoute(
     builder: (context) => MaterialList()));
     },
     icon: Column(
     children: <Widget>[
     CircleAvatar(
     radius: 30,
     backgroundColor: Colors.deepOrange[200],
     child: Icon(Icons.account_balance_wallet),
     ),
     Container(
     padding: EdgeInsets.all(10),
     child: Text('Material'))
     ],
     ),
     iconSize: 100,
     ),
     IconButton(
     onPressed: () {
     debugPrint("Loan");
     Navigator.of(context).push(MaterialPageRoute(
     builder: (context) => LoanList()));
     },
     icon: Column(
     children: <Widget>[
     CircleAvatar(
     radius: 30,
     backgroundColor: Colors.blue[200],
     child: Icon(Icons.airline_seat_legroom_normal),
     ),
     Container(
     padding: EdgeInsets.all(10), child: Text('Loan'))
     ],
     ),
     iconSize: 100,
     ),
     IconButton(
     onPressed: () {
     debugPrint("Other expenses");
     Navigator.of(context).push(MaterialPageRoute(
     builder: (context) => ExpenseList()));
     },
     icon: Column(
     children: <Widget>[
     CircleAvatar(
     radius: 30,
     backgroundColor: Colors.purple[100],
     child: Icon(Icons.card_membership),
     ),
     Container(
     padding: EdgeInsets.all(10),
     child: Text(
     'Expense',
     overflow: TextOverflow.clip,
     textAlign: TextAlign.left,
     style: TextStyle(),
     ))
     ],
     ),
     iconSize: 100,
     ),
     IconButton(
     onPressed: () {
     Navigator.of(context).push(MaterialPageRoute(
     builder: (context) => GenerateJsonFile()));
     debugPrint("Generate");
     },
     icon: Column(
     children: <Widget>[
     CircleAvatar(
     radius: 30,
     backgroundColor: Colors.green[100],
     child: Icon(Icons.folder_open),
     ),
     Container(
     padding: EdgeInsets.all(10),
     child: Text('Generate'))
     ],
     ),
     iconSize: 100,
     ),
     IconButton(
     onPressed: () {
     debugPrint("Sync");
     Navigator.of(context).push(MaterialPageRoute(
     builder: (context) => Syncing()));
     },
     icon: Column(
     children: <Widget>[
     CircleAvatar(
     radius: 30,
     backgroundColor: Colors.green[200],
     child: Icon(Icons.threed_rotation),
     ),
     Container(
     padding: EdgeInsets.all(10), child: Text('Sync'))
     ],
     ),
     iconSize: 100,
     ),
     IconButton(
     onPressed: () {
     Navigator.of(context).push(MaterialPageRoute(
     builder: (context) => Setting()));
     },
     icon: Column(
     children: <Widget>[
     CircleAvatar(
     radius: 30,
     backgroundColor: Colors.purple[200],
     child: Icon(
     Icons.settings,
     color: Colors.blue,
     ),
     ),
     Container(
     padding: EdgeInsets.all(10), child: Text('Setting'))
     ],
     ),
     iconSize: 100,
     ),
     ],
     ),
     ),
     ));
                                            //   MaterialApp(
                                            //     debugShowCheckedModeBanner: false,
                                            //     theme: new ThemeData(
                                            //       primaryColor: const Color(0xFF02BB9F),
                                            //       primaryColorDark: const Color(0xFF167F67),
                                            //       accentColor: const Color(0xFF167F67),
                                            //     ),
                                            //     home: new Scaffold(
                                            //       backgroundColor: const Color(0xFFF1F1EF),
                                            //       appBar: new AppBar(
                                            //         title: new Text(
                                            //           label,
                                            //           style: new TextStyle(color: Colors.white),
                                            //         ),
                                            //         actions: <Widget>[
                                            //           PopupMenuButton<String>(
                                            //             // overflow menu
                                            //             onSelected: _select,
                                            //             icon: new Icon(Icons.language, color: Colors.white),
                                            //             itemBuilder: (BuildContext context) {
                                            //               return languagesList
                                            //                   .map<PopupMenuItem<String>>((String choice) {
                                            //                 return PopupMenuItem<String>(
                                            //                   value: choice,
                                            //                   child: Text(choice),
                                            //                 );
                                            //               }).toList();
                                            //             },
                                            //           ),
                                            //         ],
                                            //       ),
                                            //       key: scaffoldKey,
                                            //       body: new Container(
                                            //         child: new SingleChildScrollView(
                                            //           child: new Center(
                                            //             child: signUpForm,
                                            //           ),
                                            //         ),
                                            //       ),
                                            //     ),
                                            //   );
                                             }

                                            Widget buttonWithColorBg(
                                                String buttonLabel, EdgeInsets margin, Color bgColor, Color textColor) {
                                              var loginBtn = new Container(
                                                margin: margin,
                                                padding: EdgeInsets.all(15.0),
                                                alignment: FractionalOffset.center,
                                                decoration: new BoxDecoration(
                                                  color: bgColor,
                                                  borderRadius: new BorderRadius.all(const Radius.circular(6.0)),
                                                ),
                                                child: Text(
                                                  buttonLabel,
                                                  style: new TextStyle(
                                                      color: textColor, fontSize: 20.0, fontWeight: FontWeight.bold),
                                                ),
                                              );
                                              return loginBtn;
                                            }

                                            Forms(String s) {}
}