import 'package:dot/helper/databaseHelper.dart';
import 'package:dot/localize/translate.dart';
import 'package:dot/model/usersModel.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class ProfileUpdate extends StatefulWidget {
  @override
  _ProfileUpdateState createState() => _ProfileUpdateState();
}

class _ProfileUpdateState extends State<ProfileUpdate> {

  final _formkey = GlobalKey<FormState>();
  static bool _autoValidate = false;

  @override
  initState(){
    super.initState();
    getUser();
  }
  Future getUser() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      emailController.text = preferences.getString("email");
      passwordController.text = preferences.getString("password");
    });
  }
  static final fullNameController= TextEditingController();
  static final companyController= TextEditingController();
  static final addressController= TextEditingController();
  static final phoneController= TextEditingController();
  static final passwordController= TextEditingController();
  static final emailController= TextEditingController();

  @override
  void dispose() {
//    fullNameController.dispose();
//    companyController.dispose();
//    addressController.dispose();
//    phoneController.dispose();
//    passwordController.dispose();
    super.dispose();
  }
  final email = TextFormField(
    controller: emailController,
    readOnly: true,
    validator: (value){
      if(value.isEmpty){
        return "Email is requried";
      }
      return null;
    },
    decoration: InputDecoration(
      labelText: "Email",
      icon: Icon(Icons.alternate_email),
    ),
    
  );
  final password = TextFormField(
    obscureText: true,
    controller: passwordController,
    keyboardType: TextInputType.phone,
    validator: (value){
      if(value.isEmpty){
        return "Password is requried";
      }
      return null;
    },
    decoration: InputDecoration(
      labelText: "Password",
      icon: Icon(Icons.lock),
    ),
  );
  final phone = TextFormField(
    controller: phoneController,
    keyboardType: TextInputType.phone,
    validator: (value){
      if(value.isEmpty){
        return "Phone is requried";
      }
      return null;
    },
    decoration: InputDecoration(
      labelText: "Phone",
      icon: Icon(Icons.phone),
    ),
  );
  final address = TextFormField(
    controller: addressController,
    validator: (value){
      if(value.isEmpty){
        return "Address is requried";
      }
      return null;
    },
    decoration: InputDecoration(
      labelText: "Address",
      icon: Icon(Icons.location_on),
    ),
  );
  final company = TextFormField(
    controller: companyController,
    validator: (value){
      if(value.isEmpty){
        return "Company is requried";
      }
      return null;
    },
    decoration: InputDecoration(
      labelText: "Company Name",
      icon: Icon(Icons.view_compact),
    ),
  );
  final  fullName = TextFormField(
    controller: fullNameController,
    validator: (value){
      if(value.isEmpty){
        return "Name is requried";
      }
      return null;
    },
    decoration: InputDecoration(
      labelText: "Full Name",
      icon: Icon(Icons.person),
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppTranslations.of(context).text('updateprofile')),
      ),
      
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Form(
          key: _formkey,
          autovalidate: _autoValidate,
          child: ListView(
            children: <Widget>[
              fullName,
              SizedBox(
                height: 20,
              ),
              company,
              SizedBox(
                height: 20,
              ),
              address,
              SizedBox(
                height: 20,
              ),
              phone,
              SizedBox(
                height: 20,
              ),
              email,
              password,

              Padding(
                padding: EdgeInsets.only(top:30),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(
                            left: 10,
                            right: 15),
                        child: OutlineButton(
                          borderSide: BorderSide(color: Colors.red),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          onPressed: () => Navigator.pop(context),
                          child: Row(
                            children: <Widget>[
                              Container(
                                  padding: EdgeInsets.only(
                                      right: 8),
                                  child: Icon(Icons.cancel,
                                      color: Colors.red[200])),
                              Text(
                                AppTranslations.of(context).text('cancel'),
                                style: TextStyle(color: Colors.red),
                              ),
                            ],
                          ),
                          color: Colors.red,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            left: 15,
                            right: 10),
                        child: OutlineButton(
                          borderSide: BorderSide(color: Colors.green),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          onPressed: _submit,
                          child: Row(
                            children: <Widget>[
                              Container(
                                  padding: EdgeInsets.only(
                                      right: 8),
                                  child: Icon(Icons.update,
                                      color: Colors.green)),
                              Text(
                                AppTranslations.of(context).text('update'),
                                style: TextStyle(color: Colors.green),
                              ),
                            ],
                          ),
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submit() async {
    var form = _formkey.currentState;
    if(form.validate()){
      form.save();
      UserModel model = new UserModel( null,fullNameController.text, companyController.text, addressController.text, emailController.text, phoneController.text, passwordController.text);
      var db = await DatabaseHelper();
      print(model.toMap());

      print(db.updateUser(model));
      SharedPreferences preferences = await SharedPreferences.getInstance();
      setState(() {
        preferences.setString("email", emailController.text);
        preferences.setString("fullName", fullNameController.text);
        preferences.setString("company", companyController.text);
        preferences.setString("address", addressController.text);
        preferences.setString("phone", phoneController.text);
        preferences.setString("password", passwordController.text);
      });

      Navigator.pop(context);
    }else{
      setState(() {
        _autoValidate = true;
      });
    }
  }
}
