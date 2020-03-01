import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class AboutUs extends StatefulWidget {
  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        allowFontScaling: true);
    return Scaffold(
      appBar: AppBar(
        centerTitle:true,
        title:Text('About Us')
      ),
      body: Center(
        child: Container(
          color: Colors.blue,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
            Container(
              height: ScreenUtil().setHeight(600),
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(top:100),
              child: Card(
                
                color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(topLeft:Radius.circular(50),topRight: Radius.circular(50)),
            ),
                child: Column(
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
                ),
              ))

            ],
          ),
        ),

      ),
    );
  }
}