import 'package:dot/helper/databaseHelper.dart';
import 'package:dot/model/usersModel.dart';
import 'package:dot/model/usersModel.dart';
import 'package:dot/model/usersModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sqflite/sqlite_api.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  DatabaseHelper helper=DatabaseHelper();
List<UserModel> user;
void updatelistProducts(){
      final Future<Database> prodb=helper.databaseIntiolize();
      prodb.then((database){
        Future<List<UserModel>> proLists=helper.userToMapList();
        proLists.then((lists){
         
          setState(() {
            this.user=lists;
            
            
          });
        });
      });
     
      
    }
   
  @override
  Widget build(BuildContext context) {
    if(user==null){
      user=List<UserModel>();
       updatelistProducts();
    }
    ScreenUtil.init(context,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        allowFontScaling: true);
    return Scaffold(
      appBar: AppBar(
        centerTitle:true,
        title:Text('Account Profile')
      ),
      body: Container(
        color: Colors.blue,
        padding: EdgeInsets.only(top:30),
        child: Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(topLeft:Radius.circular(50),topRight: Radius.circular(50)),
          ),
          child: Container(
                    padding: EdgeInsets.only( right:ScreenUtil().setWidth(50),left:ScreenUtil().setWidth(15)),
            child: Column(
            children: <Widget>[
              Center( child:  CircleAvatar(
                backgroundImage: AssetImage("assets/Amete.jpg"),
                radius: 28,
              ),),
              ListTile( 
                title: Text('Name'),
                trailing: Text('${user[0].fullName}'),//user.name
              ),
              Divider(),
              ListTile( 
                title: Text('Email'),
                trailing: Text('${user[0].email}'),
              ),
              Divider(),
              ListTile( 
                title: Text('Company Name'),
                trailing: Text('${user[0].company}'), //user.companyname
              ),
              ListTile( 
                title: Text('Address'),
                trailing: Text('${user[0].address}'),
              ), 
              Divider(),
              ListTile( 
                title: Text('Phone'),
                trailing: Text('${user[0].phone}'),
              )
            ],
            ),
          ),
        ),
      ),
      
    );
  }
}