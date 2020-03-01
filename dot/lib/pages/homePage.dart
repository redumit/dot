import 'package:dot/localize/applications.dart';
import 'package:dot/localize/translate.dart';
import 'package:dot/pages/analytics/analytics.dart';
import 'package:dot/pages/expense/expenseList.dart';
import 'package:dot/pages/generate/generateJson.dart';
import 'package:dot/pages/loan/loanList.dart';
import 'package:dot/pages/login/registerLogin.dart';
import 'package:dot/pages/material/materialList.dart';
import 'package:dot/pages/new/aboutUs.dart';
import 'package:dot/pages/new/jsonFile.dart';
import 'package:dot/pages/salary/salaryLists.dart';
import 'package:dot/pages/setting/setting.dart';
import 'package:dot/pages/sync/mailing.dart';
import 'package:dot/pages/sync/syncs.dart';
import 'package:dot/pages/today/service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {


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
    ScreenUtil.init(context,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        allowFontScaling: true);
    if (userEmail == null) {
      getUser();
    }
    return Scaffold(
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
                backgroundImage: AssetImage('assets/Amete.jpg'),
              ),
            ),
          ),

        ),
      ),
      drawer: _navDrawer(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.blue[700],
              width: MediaQuery.of(context).size.width,
              height: 100,
              child: Padding(
                padding: EdgeInsets.only(top: ScreenUtil().setWidth(50)),
                child: Center(
                  heightFactor: 1,
                  child: Column(
                    children: <Widget>[
                      Text(
                        "Hi $fname",
                        style: TextStyle(fontSize: 28, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: ScreenUtil().setWidth(25)),
              child: WaveWidget(
                // wavePhase: 1,
                duration: 3,
                config: CustomConfig(
                  gradients: [
                    [Colors.blue, Colors.lightBlueAccent],
                    [Colors.lightBlueAccent, Colors.blue],
                    [Colors.white, Colors.lightBlue],
                    [Colors.white, Colors.lightBlueAccent]
                  ],
                  durations: [35000, 19440, 10800, 6000],
                  heightPercentages: [0.25, 0.5, 0.75, 1],
                  blur: MaskFilter.blur(BlurStyle.solid, 5),
                  gradientBegin: Alignment.bottomRight,
                  gradientEnd: Alignment.bottomLeft,
                ),
                waveAmplitude: 1.0,
                backgroundColor: Colors.blue,
                size: Size(double.infinity, 40.0),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.5,
              child: GridView.count(
                padding: EdgeInsets.all(ScreenUtil().setWidth(20)),
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
                          radius: ScreenUtil().setWidth(30),
                          backgroundColor: Colors.blueGrey,
                          child: Icon(
                            Icons.calendar_today,
                            size: 32,
                            color: Colors.amberAccent,
                          ),
                        ),
                        Expanded(
                          child: Center(child: Text(AppTranslations.of(context).text('today'))),
                        )
                      ],
                    ),
                    iconSize: ScreenUtil().setWidth(300),
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
                          radius: ScreenUtil().setWidth(30),
                          backgroundColor: Colors.blue[50],
                          child: Icon(FontAwesomeIcons.chartLine),
                        ),
                        Expanded(
                          child: Center(child: Text(AppTranslations.of(context).text('report'))),
                        )
                      ],
                    ),
                    iconSize: ScreenUtil().setWidth(300),
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
                          radius: ScreenUtil().setWidth(30),
                          backgroundColor: Colors.pink[100],
                          child: Icon(
                            FontAwesomeIcons.moneyBill,
                            size: 30,
                            color: Colors.white70,
                          ),
                        ),
                        Expanded(
                          child: Center(child: Text(AppTranslations.of(context).text('sallary'))),
                        )
                      ],
                    ),
                    iconSize: ScreenUtil().setWidth(300),
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
                          radius: ScreenUtil().setWidth(30),
                          backgroundColor: Colors.deepOrange[200],
                          child: Icon(Icons.account_balance_wallet),
                        ),
                        Expanded(
                          child: Center(child: Text(AppTranslations.of(context).text('material'))),
                        )
                      ],
                    ),
                    iconSize: ScreenUtil().setWidth(300),
                  ),
                  IconButton(
                    onPressed: () {
                      debugPrint("Loan");
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => LoanList()));
                    },
                    icon: Column(
                      children: <Widget>[
                        CircleAvatar(
                          radius: ScreenUtil().setWidth(30),
                          backgroundColor: Colors.blue[200],
                          child: Icon(FontAwesomeIcons.businessTime),
                        ),
                        Expanded(
                          child: Center(child: Text(AppTranslations.of(context).text('loan'))),
                        )
                      ],
                    ),
                    iconSize: ScreenUtil().setWidth(300),
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
                          radius: ScreenUtil().setWidth(30),
                          backgroundColor: Colors.purple[100],
                          child: Icon(Icons.card_membership),
                        ),
                        Expanded(
                          child: Center(
                              child: Text(
                                AppTranslations.of(context).text('otherexpense'),
                            textAlign: TextAlign.center,
                          )),
                        )
                      ],
                    ),
                    iconSize: ScreenUtil().setWidth(300),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => JsonFile()));
                      debugPrint("Generate");
                    },
                    icon: Column(
                      children: <Widget>[
                        CircleAvatar(
                          radius: ScreenUtil().setWidth(30),
                          backgroundColor: Colors.green[100],
                          child: Icon(Icons.folder_open),
                        ),
                        Expanded(
                          child: Center(child: Text(AppTranslations.of(context).text('generate'))),
                        )
                      ],
                    ),
                    iconSize: ScreenUtil().setWidth(300),
                  ),
                  IconButton(
                    onPressed: () {
                      debugPrint("Sync");
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => SendEmail()));
                    },
                    icon: Column(
                      children: <Widget>[
                        CircleAvatar(
                          radius: ScreenUtil().setWidth(30),
                          backgroundColor: Colors.green[200],
                          child: Icon(FontAwesomeIcons.sync),
                        ),
                        Expanded(
                          child: Center(child: Text(AppTranslations.of(context).text('sync'))),
                        )
                      ],
                    ),
                    iconSize: ScreenUtil().setWidth(300),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => Setting()));
                    },
                    icon: Column(
                      children: <Widget>[
                        CircleAvatar(
                          radius: ScreenUtil().setWidth(30),
                          backgroundColor: Colors.purple[200],
                          child: Icon(
                            Icons.settings,
                            color: Colors.blue,
                          ),
                        ),
                        Expanded(
                          child: Center(child: Text(AppTranslations.of(context).text('setting'))),
                        )
                      ],
                    ),
                    iconSize: ScreenUtil().setWidth(300),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _navDrawer() {
    return Drawer(
      child: ListView(
        children: <Widget>[
          Container(
            height: ScreenUtil().setWidth(191),
            child: DrawerHeader(
              padding: EdgeInsets.only(left: ScreenUtil().setWidth(50)),
              decoration: BoxDecoration(
                color: Colors.blue[50],
              ),
              child: UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                ),
                currentAccountPicture: CircleAvatar(
                    radius: ScreenUtil().setWidth(45.5),
                    backgroundImage: AssetImage("assets/Amete.jpg")),
                accountName: Text(
                  "$fname",
                  style: TextStyle(color: Colors.blue),
                ),
                accountEmail: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Icon(
                      FontAwesomeIcons.envelope,
                      color: Colors.blue,
                    ),
                    Text(
                      "\t\t$phone",
                      style: TextStyle(color: Colors.blue),
                    )
                  ],
                ),
              ),
            ),
          ),
          ListTile(
            onTap: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => SendEmail())),
            leading: Icon(
              Icons.email,
              color: Colors.blue,
            ),
            title: Text(
    AppTranslations.of(context).text('report'),
              style: TextStyle(color: Colors.blue),
            ),
          ),
          Divider(),
          ListTile(
            onTap: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => JsonFile())),
            leading: Icon(
              FontAwesomeIcons.chartLine,
              color: Colors.blue,
            ),
            title: Text(
    AppTranslations.of(context).text('generate'),
              style: TextStyle(color: Colors.blue),
            ),
          ),
          Divider(),
          ListTile(
            onTap: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => AboutUs())),
            leading: Icon(
              FontAwesomeIcons.infoCircle,
              color: Colors.blue,
            ),
            title: Text(
    AppTranslations.of(context).text('aboutus'),
              style: TextStyle(color: Colors.blue),
            ),
          ),
          Divider(),
          ListTile(
            onTap: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => LoginScreen()));
            },
            leading: Icon(
              Icons.power_settings_new,
              color: Colors.blue,
            ),
            title: Text(
              "Log out",
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ],
      ),
    );
  }
}
