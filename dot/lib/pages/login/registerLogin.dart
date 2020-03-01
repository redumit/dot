import 'dart:ffi';

import 'package:dot/helper/databaseHelper.dart';
import 'package:dot/model/usersModel.dart';
import 'package:dot/pages/homePage.dart';
import 'package:dot/pages/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

const users = const {
  'redu@gmail.com': '12345',
  'hunter@gmail.com': 'hunter',
};

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {



  DatabaseHelper helper = new DatabaseHelper();
  List<UserModel> usersList;
  int count = 0;

  Duration get loginTime => Duration(milliseconds: 2250);

  Future<String> _register(LoginData data) async {
    user = data.name;
    password = data.password;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    UserModel userModel = new UserModel(null, null, null, null, data.name, null, data.password);
    var db = DatabaseHelper();
    await db.databaseIntiolize();
    return Future.delayed(loginTime).then((_) {
      if (usersList.length>0) {
        for(int i = 0; i<usersList.length; i++){
          if(usersList[i].email == data.name ){
            return "User already exist";
          }

        }
        db.insertUSer(userModel);
        preferences.setString("email", user);
        preferences.setString("password", password);

        print("eamil:"+ preferences.getString("email"));
        return null;
      }
      db.insertUSer(userModel) ;
      preferences.setString("email", data.name);
      return null;
    });

  }


  Future<String> _authUser(LoginData data) async{

      setState(() {
        user = data.name;
        password = data.password;
      });
      SharedPreferences preferences = await SharedPreferences.getInstance();
    return Future.delayed(loginTime).then((_) {
      if (usersList.length>0) {
        for(int i = 0; i<usersList.length; i++){
          if(usersList[i].email == data.name && usersList[i].password== data.password ){
            preferences.setString("email", usersList[i].email);
            preferences.setString("password", usersList[i].password);
            preferences.setString("fullName", usersList[i].fullName);
            preferences.setString("company", usersList[i].company);
            preferences.setString("phone", usersList[i].phone);
            print(preferences.getString("phone"));
            return null;
          }
        }
        return 'User not exists';
      }
      else {
        return 'No user found';
      }
    });


  }

  Future<String> _recoverPassword(String name) {
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(name)) {
        return 'Username not exists';
      }
      return null;
    });
  }

  @override
  void initState() {
    super.initState();
    getAllUsers();
  }
  String user;
  String password;
  Future getAllUsers() async{
    helper.databaseIntiolize();
    final Future<Database> dbfuture = helper.databaseIntiolize();
    dbfuture.then((database) {
      Future<List<UserModel>> salaryListFuture = helper.userToMapList();
      salaryListFuture.then((users) {
        setState(() {
          this.usersList = users;
          this.count = users.length;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FlutterLogin(
        title: 'DOT',
        onLogin: _authUser,
        onSignup: _register,
        onSubmitAnimationCompleted: () {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => Dashboard(),
          ));
        },
        onRecoverPassword: _recoverPassword,
      ),
    );
  }
}

