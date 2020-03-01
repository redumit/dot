import 'package:dot/localize/translate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class Help extends StatefulWidget {
  @override
  _HelpState createState() => _HelpState();
}

class _HelpState extends State<Help> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        allowFontScaling: true);
    return Scaffold(
      appBar: AppBar(
        centerTitle:true,
        title:Text(AppTranslations.of(context).text('help'))
      ),
      body: Center(
        child: Container(
          color: Colors.white,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
            Column(
              children: <Widget>[
                Center(
                  child:  CircleAvatar(
            backgroundImage: AssetImage("assets/Amete.jpg"),
            radius: 28,
            ),
                ),
                Text('Dot Ethiopia'),
                Flex(direction:Axis.vertical,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(15),
                  child:Center(
                  child: Text('   Dot ethiopia is simplly \n Digital Oportunity Trust\n and other' 
                  +' Just we say well com to yuo guys'),
                ),
                  ),
               Container(
                    padding: EdgeInsets.all(15),
                  child:Center(
                  child: Text('   Dot ethiopia is simplly \n Digital Oportunity Trust\n and other' 
                  +' Just we say well com to yuo guys'),
                ),
                  ),
                ],)
              ],
            )

            ],
          ),
        ),

      ),
    );
  }
}