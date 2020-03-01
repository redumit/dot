import 'package:dot/helper/databaseHelper.dart';
import 'package:dot/model/otherExpenseModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class ExpenceAdd extends StatefulWidget {
  @override
  _ExpenceAddState createState() => _ExpenceAddState();
}

class _ExpenceAddState extends State<ExpenceAdd> {
  final _formkey = GlobalKey<FormState>();
  static bool _autoValidate = false;
  bool _isLoading = false;
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  List<String> _expences = ['rent', 'supply&utility', 'advertise cost', 'payable','other'];
  String _expenceName;
  final purchaseControl = TextEditingController();

  String _purchaseDate = DateFormat.yMd().format(DateTime.now()).toString();
  String _time = DateFormat.Hm().format(DateTime.now()).toString();

  onsave() async{
    final form = _formkey.currentState;
    if (form.validate()) {
      print('saved');
      form.save();
      OtherExpenseModel otherExpense = new OtherExpenseModel.withId(null, _expenceName, double.parse(purchaseControl.text), _purchaseDate, _time);
      DatabaseHelper helper = DatabaseHelper();
      await helper.insertOtherExpense(otherExpense);
      Navigator.pop(context);
    }else {
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
      appBar: AppBar(
        title: Text('Add OtherExpence'),
      ),
      body: Container(
        padding: EdgeInsets.only(
            top: ScreenUtil().setWidth(30), left: ScreenUtil().setWidth(30)),
        child: Form(
          key: _formkey,
          autovalidate: _autoValidate,
          child: ListView(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: 65,
                        width: MediaQuery.of(context).size.width / 1.8,
                        padding: EdgeInsets.symmetric(
                            horizontal: ScreenUtil().setWidth(10)),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(width: 0.80),
                        ),
                        child: DropdownButton(
                          icon: Align(
                            alignment: Alignment.centerRight,
                            child: Icon(Icons.arrow_drop_down,
                                color: Colors.blue[300]),
                          ),
                          value: _expenceName,
                          hint: Text('Expence Name'),
                          onChanged: (String value) {
                            setState(() {
                              _expenceName = value;
                            });
                          },
                          items: _expences
                              .map(
                                (item) => DropdownMenuItem(
                              child: Text(item),
                              value: item,
                            ),
                          )
                              .toList(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: ScreenUtil().setWidth(10),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  width: MediaQuery.of(context).size.width / 1.8,
                  child: TextFormField(
                    controller: purchaseControl,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'purchasecost is requierd';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      labelText: 'PurchaseCost',
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: ScreenUtil().setWidth(15),
              ),
              Row(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(ScreenUtil().setWidth(3)),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Service Date')),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        margin: EdgeInsets.all(ScreenUtil().setWidth(5)),
                        padding: EdgeInsets.all(ScreenUtil().setWidth(5)),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(width: 0.80),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('$_purchaseDate'),
                            IconButton(
                              icon: Icon(Icons.date_range, color: Colors.blue),
                              onPressed: () {
                                var format = DateFormat.yMd();
                                showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2017),
                                    lastDate: DateTime(2021))
                                    .then((date) {
                                  setState(() {
                                    _purchaseDate =
                                        format.format(date).toString();
                                  });
                                });
                              },
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width / 3,
                        padding: EdgeInsets.all(ScreenUtil().setWidth(3)),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Time')),
                      ),
                      Container(
                        margin: EdgeInsets.all(ScreenUtil().setWidth(5)),
                        padding: EdgeInsets.all(ScreenUtil().setWidth(5)),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(width: 0.80),
                        ),
                        child: Row(
                          children: <Widget>[
                            Text('$_time'),
                            IconButton(
                              icon: Icon(
                                Icons.timer,
                                color: Colors.blue,
                              ),
                              onPressed: () {
                                showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now())
                                    .then((time) {
                                  setState(() {
                                    _time = time.format(context);
                                  });
                                });
                              },
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: ScreenUtil().setWidth(15),
              ),
              Align(
                alignment: Alignment.centerRight,
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
                                child:
                                Icon(Icons.cancel, color: Colors.red[200])),
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
            ],
          ),
        ),
      ),
    );
  }
}
