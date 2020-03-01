import 'package:dot/helper/databaseHelper.dart';
import 'package:dot/model/materialModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class MaterialAdd extends StatefulWidget {
  @override
  _MaterialAddState createState() => _MaterialAddState();
}

class _MaterialAddState extends State<MaterialAdd> {
  final _formkey2 = GlobalKey<FormState>();
  static bool _autoValidate = false;
  bool _isLoading = false;
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  final materialNameController = TextEditingController();
  final quantityController = TextEditingController();
  final purchaseCostController = TextEditingController();
  final deprecationYearController = TextEditingController();
  String _date = DateFormat.yMd().format(DateTime.now()).toString();

  double totalCost,deprecationCostPerYear,deprecationCostPerMonth,restValue;

  onsave() async{
    final form = _formkey2.currentState;
    if (form.validate()) {
      print('saved');
      form.save();
      MaterialModel material = new MaterialModel.withId(null, materialNameController.text, double.parse(quantityController.text),
          double.parse(purchaseCostController.text), _date, totalCost, double.parse(deprecationYearController.text), deprecationCostPerYear, deprecationCostPerMonth, restValue);
      DatabaseHelper helper = DatabaseHelper();
      await helper.insertMaterial(material);
      Navigator.pop(context);
    }else {
      setState(() {
        _autoValidate = true;
      });
    }
  }

  @override
  initState(){
    super.initState();
    quantityController.addListener(_calculations);
    purchaseCostController.addListener(_calculations);
    deprecationYearController.addListener(_calculations);
  }

  _calculations(){
    setState(() {
      totalCost = double.parse(quantityController.text)*double.parse(purchaseCostController.text);
      deprecationCostPerYear = totalCost/double.parse(deprecationYearController.text);
      deprecationCostPerMonth = deprecationCostPerYear/12;
      restValue = totalCost - deprecationCostPerMonth;
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        allowFontScaling: true);
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Material Expense'),
      ),
      body: Container(
        padding: EdgeInsets.only(
            left: ScreenUtil().setSp(30), top: ScreenUtil().setSp(10)),
        child: Form(
          key: _formkey2,
          autovalidate: _autoValidate,
          child: ListView(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Card(
                      child: Container(
                        height: 150,
                        width: MediaQuery.of(context).size.width * 0.40,
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Total Purchase Cost = $totalCost ",
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )),
                  Column(
                    children: <Widget>[
                      Card(
                          child: Container(
                            height: 70,
                            width: MediaQuery.of(context).size.width * 0.40,
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Monthly Depration Cost = $deprecationCostPerMonth",
                                textAlign: TextAlign.center,
                              ),
                            ),
                          )),
                      Card(
                          child: Container(
                            height: 70,
                            width: MediaQuery.of(context).size.width * 0.40,
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Yearly Depration Cost = $deprecationCostPerYear",
                                textAlign: TextAlign.center,
                              ),
                            ),
                          )),
                    ],
                  ),
                ],
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  padding: EdgeInsets.only(top: 30),
                  width: MediaQuery.of(context).size.width / 1.6,
                  child: TextFormField(
                    controller: materialNameController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Name of Material is Required';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                          BorderSide(color: Colors.teal, width: 1.0)),
                      labelText: 'Fixed Material',
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
                        width: MediaQuery.of(context).size.width / 2.5,
                        child: TextFormField(
                          controller: quantityController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Number of Items required';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                BorderSide(color: Colors.teal, width: 1.0)),
                            labelText: 'Number of Items',
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
                      controller: purchaseCostController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Purchase Cost required';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                            BorderSide(color: Colors.teal, width: 1.0)),
                        labelText: 'Purchase cost',
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: ScreenUtil().setWidth(15),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  width: MediaQuery.of(context).size.width / 1.6,
                  child: TextFormField(
                    controller: deprecationYearController,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Depreciation year required';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                          BorderSide(color: Colors.teal, width: 1.0)),
                      labelText: 'Depreciation year',
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: ScreenUtil().setWidth(15),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(ScreenUtil().setWidth(3)),
                    child: Align(
                        alignment: Alignment.centerLeft, child: Text('Date')),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.65,
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
              SizedBox(
                height: ScreenUtil().setWidth(15),
              ),
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
}
