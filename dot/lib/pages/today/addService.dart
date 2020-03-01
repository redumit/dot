import 'dart:wasm';

import 'package:dot/helper/databaseHelper.dart';
import 'package:dot/model/serviceModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class AddService extends StatefulWidget {
  @override
  _AddServiceState createState() => _AddServiceState();
}

class _AddServiceState extends State<AddService> {
  //controllers


  final formkey = GlobalKey<FormState>();
  static bool _autoValidate = false;
  bool _isLoading = false;
  final scaffoldKey = new GlobalKey<ScaffoldState>();


  List<String> _segments = ['SW', 'HW', 'WC','FA','other'];
  List<String> _items = ['Generator', 'Hand Pump', 'Biogas','Installation', 'other'];


  final laborCostControl = TextEditingController();
  final otherExpenseControl = TextEditingController();
  final sellingPriceControl = TextEditingController();
  final hoursWorkControl = TextEditingController();
  String _serviceDate = DateFormat.yMd().format(DateTime.now()).toString();
  String _time = DateFormat.Hms().format(DateTime.now()).toString();

  double grossProfit = 0;
  String serviceName;
  String serviceSegment;

  @override
  initState(){
    super.initState();
    laborCostControl.addListener(_grossProfit);
    otherExpenseControl.addListener(_grossProfit);
    sellingPriceControl.addListener(_grossProfit);
  }
  _grossProfit(){
    setState(() {
      grossProfit = double.parse(sellingPriceControl.value.text)- double.parse(laborCostControl.value.text)-double.parse(otherExpenseControl.value.text);
    });
  }


  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        allowFontScaling: true);
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text("Add Service"),
      ),
      body: Form(
        key: formkey,
        autovalidate: _autoValidate,
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: ListView(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Card(
                  child: Container(
                    height: 80,
                    width: MediaQuery.of(context).size.width * 0.70,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Gross Profit = $grossProfit",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.only(left: 30.0, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width / 2.5,
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
                        value: serviceName,
                        hint: Text('service name'),
                        onChanged: (String value) {
                          setState(() {
                            serviceName = value;
                          });
                        },
                        items: _items
                            .map(
                              (item) => DropdownMenuItem(
                            child: Text(item),
                            value: item,
                          ),
                        )
                            .toList(),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[

                        Container(
                          margin:
                          EdgeInsets.only(left: ScreenUtil().setWidth(10)),
                          width: MediaQuery.of(context).size.width / 3,
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
                            value: serviceSegment,
                            hint: Text('segments'),
                            onChanged: (String value) {
                              setState(() {
                                serviceSegment = value;
                              });
                            },
                            items: _segments
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
              ),
              SizedBox(
                height: ScreenUtil().setWidth(10),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.65,
                  padding: EdgeInsets.only(left: 30),
                  child: TextFormField(
                    controller: laborCostControl,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Labor Cost is requierd';
                      }
                      return null;
                    },
                    inputFormatters: <TextInputFormatter>[
                      WhitelistingTextInputFormatter.digitsOnly
                    ],
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                          BorderSide(color: Colors.teal, width: 1.0)),
                      labelText: 'Labor Cost',
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: ScreenUtil().setWidth(10),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  padding: EdgeInsets.only(left: 30, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width / 2.5,
                        child: TextFormField(
                          controller: otherExpenseControl,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Expence is requierd';
                            }
                            return null;
                          },

                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                BorderSide(color: Colors.teal, width: 1.0)),
                            labelText: 'Other Expence',
                          ),
                        ),
                      ),
                      Container(
                        padding:
                        EdgeInsets.only(left: ScreenUtil().setWidth(10)),
                        width: MediaQuery.of(context).size.width / 2.5,
                        child: TextFormField(
                          controller: sellingPriceControl,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'SellingPrice is requierd';
                            }
                            return null;
                          },

                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                BorderSide(color: Colors.teal, width: 1.0)),
                            labelText: 'Selling Price',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: ScreenUtil().setWidth(10),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.65,
                  padding: EdgeInsets.only(left: 30),
                  child: TextFormField(
                    controller: hoursWorkControl,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Hours of Work is requierd';
                      }
                      return null;
                    },

                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                          BorderSide(color: Colors.teal, width: 1.0)),
                      labelText: 'Hours of Work',
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: ScreenUtil().setWidth(10),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30.0, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              Text('$_serviceDate'),
                              IconButton(
                                icon:
                                Icon(Icons.date_range, color: Colors.blue),
                                onPressed: () {
                                  var format = DateFormat.yMd();
                                  showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2017),
                                      lastDate: DateTime(2021))
                                      .then((date) {
                                    setState(() {
                                      _serviceDate =
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              ),

              //buttons
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
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
                          onPressed: _submit,
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

  void _showSnackBar(String text) {
    scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(text),
    ));
  }

  void _submit(){
    final form = formkey.currentState;

    if (form.validate()){
      setState(() async {
        _isLoading = true;
        form.save();
        ServiceModel service = new ServiceModel(
            null,
            serviceName,
            serviceSegment,
            double.parse(laborCostControl.value.text),
            double.parse(otherExpenseControl.value.text),
            double.parse(sellingPriceControl.value.text),
            int.parse(hoursWorkControl.value.text),
            _serviceDate,
            _time,
            grossProfit);
        var db = DatabaseHelper();
        await db.insertService(service);
        _isLoading = false;
        Navigator.pop(context);
      });
    }
    else{
      setState(() {
        _autoValidate = true;
      });
    }
  }
}