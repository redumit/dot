import 'package:dot/helper/databaseHelper.dart';
import 'package:dot/model/emailModel.dart';
import 'package:flutter/material.dart';

class AddEmail extends StatefulWidget {
  @override
  _AddEmailState createState() => _AddEmailState();
}

final formkey = GlobalKey<FormState>();

class _AddEmailState extends State<AddEmail> {

  TextEditingController emailController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('Add Email'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            Form(
              key: formkey,
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Container(
                  alignment: Alignment.topLeft,
                  width: MediaQuery.of(context).size.width * 0.70,
                  child: TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Email is required';
                      }

                      return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                          BorderSide(color: Colors.teal, width: 1.0)),
                      labelText: 'add @ email to send report',
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),

            RaisedButton( elevation: 4,
              color: Colors.teal,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Text('Add'),
              onPressed: _add,
            )
    ]),
      ),
    );
  }
  _add()async{
      final form = formkey.currentState;
      if (form.validate()) {
        print('saved');
        form.save();
        EmailModel email = new  EmailModel( emailController.text);
        DatabaseHelper helper = DatabaseHelper();
        await helper.insertEmail(email);
        Navigator.pop(context);
      }else {


      }

  }
}
