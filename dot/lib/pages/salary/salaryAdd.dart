import 'package:dot/helper/databaseHelper.dart';
import 'package:dot/model/salaryModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class SalaryAdd extends StatefulWidget {
  @override
  _SalaryAddState createState() => _SalaryAddState();
}

class _SalaryAddState extends State<SalaryAdd> {
  final _formkey2 = GlobalKey<FormState>();
  static bool _autoValidate = false;

  //TextfieldForms
  final empcontroller = TextEditingController();
  final totalDaysController = TextEditingController();
  final ratePerDayController = TextEditingController();
  final postioncontroller = TextEditingController();

  //radiobuttons
  String _genderGroup = null;

  //Date Pickeer
  String _date = DateFormat.yMd().format(DateTime.now()).toString();

  //variables
  String empName, position;
  static double totalDay, ratePerDay;

  // total payment
  double totalPayment;

  //initialization
  @override
  initState() {
    super.initState();
    totalDaysController.addListener(_totalPayment);
    ratePerDayController.addListener(_totalPayment);
  }

  //calculate total payment
  void _totalPayment() {
    setState(() {

        totalPayment = double.parse(totalDaysController.text) *
            double.parse(ratePerDayController.text);

    });
  }

// input validator
  onsave() {
    final form = _formkey2.currentState;
    if (form.validate()) {
      _formkey2.currentState.save();
      print('saved');
      _submit();
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        allowFontScaling: true);
    return Scaffold(
      //app bar
      appBar: AppBar(
        title: Text('Edit Sallary'),
      ),
      //body
      body: Container(
        padding: EdgeInsets.only(
            left: ScreenUtil().setSp(30), top: ScreenUtil().setSp(10)),
        //form
        child: Form(
          autovalidate: _autoValidate,
          key: _formkey2,
          child: ListView(
            children: <Widget>[
              //total payment
              Card(
                  child: Container(
                    height: 80,
                    width: MediaQuery.of(context).size.width * 0.70,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Total Payment = $totalPayment",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )),
              //Employee name
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  padding: EdgeInsets.only(top: 8),
                  width: MediaQuery.of(context).size.width / 1.6,
                  child: TextFormField(
                    controller: empcontroller,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Employee is requierd';
                      } else if (value.length < 3) {
                        return "Name must greater than 2 characters";
                      }
                      return null;
                    },
                    onSaved: (value) => empName = value,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                          BorderSide(color: Colors.teal, width: 1.0)),
                      labelText: 'Employee Name',
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: ScreenUtil().setWidth(15),
              ),

              //total day and rate per day
              Row(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width / 2.5,
                        child: TextFormField(
                          controller: totalDaysController,
                          keyboardType: TextInputType.numberWithOptions(signed: true),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Total day is requierd';
                            } else if (int.parse(value) < 0) {
                              return "total days should greater than 0";
                            } else if (int.parse(value).isNaN) {
                              return "Input should be only number";
                            }
                            return null;
                          },
                          inputFormatters: <TextInputFormatter>[
                            WhitelistingTextInputFormatter.digitsOnly
                          ],
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                BorderSide(color: Colors.teal, width: 1.0)),
                            labelText: 'Total Day',
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.only(left: ScreenUtil().setWidth(10)),
                    width: MediaQuery.of(context).size.width / 2.5,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: ratePerDayController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Rate per day is requierd';
                        } else if (int.parse(value) < 0) {
                          return "rate per day should greater than 0";
                        } else if (int.parse(value).isNaN) {
                          return "Input should be only number";
                        }
                        return null;
                      },
                      inputFormatters: <TextInputFormatter>[
                        WhitelistingTextInputFormatter.digitsOnly
                      ],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                            BorderSide(color: Colors.teal, width: 1.0)),
                        labelText: 'Rate Per Day',
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: ScreenUtil().setWidth(15),
              ),
              //radio button
              Align(
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(ScreenUtil().setWidth(5)),
                      padding: EdgeInsets.all(ScreenUtil().setWidth(5)),
                      child: Text('Gender'),
                    ),
                    Container(
                      height: 60,
                      width: MediaQuery.of(context).size.width / 1.6,
                      margin: EdgeInsets.all(ScreenUtil().setWidth(5)),
                      padding: EdgeInsets.all(ScreenUtil().setWidth(5)),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(width: 0.80),
                      ),
                      child: Center(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Radio(
                                    value: "male",
                                    groupValue: _genderGroup,
                                    onChanged: (value) {
                                      setState(() {
                                        _genderGroup = value;
                                      });
                                    },
                                  ),
                                  Text('Male')
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Radio(
                                    value: 'female',
                                    groupValue: _genderGroup,
                                    onChanged: (value) {
                                      setState(() {
                                        _genderGroup = value;
                                      });
                                    },
                                  ),
                                  Text('Female')
                                ],
                              ),
                            ],
                          )),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: ScreenUtil().setWidth(15),
              ),
              // job position
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  width: MediaQuery.of(context).size.width / 1.6,
                  child: TextFormField(
                    controller: postioncontroller,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Employee is requierd';
                      } else if (value.length < 3) {
                        return "Name must greater than 2 characters";
                      }
                      return null;
                    },
                    onSaved: (value) => position = value,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                          BorderSide(color: Colors.teal, width: 1.0)),
                      labelText: 'Position',
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: ScreenUtil().setWidth(15),
              ),
              //Date
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(ScreenUtil().setWidth(3)),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Salary Date')),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 2.3,
                    margin: EdgeInsets.all(ScreenUtil().setWidth(5)),
                    padding: EdgeInsets.all(ScreenUtil().setWidth(5)),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(width: 0.80),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('$_date'),
                        IconButton(
                          icon: Icon(Icons.date_range, color: Colors.blue),
                          onPressed: () {
                            var format = DateFormat.yMd();
                            showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(200),
                                lastDate: DateTime(2021))
                                .then((date) {
                              setState(() {
                                _date = format.format(date).toString();
                              });
                            });
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
              //buttons
              Padding(
                padding: EdgeInsets.only(top: ScreenUtil().setWidth(30)),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(
                            left: ScreenUtil().setWidth(10),
                            right: ScreenUtil().setWidth(15)),
                        child: OutlineButton(
                          borderSide: BorderSide(color: Colors.red),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          onPressed: () => Navigator.pop(context),
                          child: Row(
                            children: <Widget>[
                              Container(
                                  padding: EdgeInsets.only(
                                      right: ScreenUtil().setWidth(8)),
                                  child: Icon(Icons.cancel,
                                      color: Colors.red[200])),
                              Text(
                                'cancel',
                                style: TextStyle(color: Colors.red),
                              ),
                            ],
                          ),
                          color: Colors.red,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            left: ScreenUtil().setWidth(15),
                            right: ScreenUtil().setWidth(10)),
                        child: OutlineButton(
                          borderSide: BorderSide(color: Colors.green),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          onPressed: onsave,
                          child: Row(
                            children: <Widget>[
                              Container(
                                  padding: EdgeInsets.only(
                                      right: ScreenUtil().setWidth(8)),
                                  child: Icon(Icons.mail_outline,
                                      color: Colors.green)),
                              Text(
                                'Save',
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
    SalaryModel model = new SalaryModel(
        null,
        empcontroller.text,
        int.parse(totalDaysController.text),
        double.parse(ratePerDayController.text),
        _genderGroup,
        postioncontroller.text,
        _date,
        totalPayment);
    var db = await DatabaseHelper();
    print(model.toMap());

    print(db.insertSalary(model));
    Navigator.pop(context);
  }
}
