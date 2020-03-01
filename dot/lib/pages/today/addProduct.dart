import 'package:dot/helper/databaseHelper.dart';
import 'package:dot/model/productModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class AddProduct extends StatefulWidget {
  @override
  _ProductState createState() => _ProductState();
}

class _ProductState extends State<AddProduct> {
  final _formkey1 = GlobalKey<FormState>();
  static bool _autoValidate = false;
  bool _isLoading = false;
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  final itemNameController = TextEditingController();
  final quantityController = TextEditingController();
  final productCostController = TextEditingController();
  final sellingPriceController = TextEditingController();
  double totalPrice, totalCost, grossProfit;
  String _serviceDate = DateFormat.yMd().format(DateTime.now()).toString();
  String _time = DateFormat.Hms().format(DateTime.now()).toString();

  @override
  void initState() {
    super.initState();
    quantityController.addListener(_calculations);
    sellingPriceController.addListener(_calculations);
    productCostController.addListener(_calculations);
  }

  _calculations() {
    var quantity = double.parse(quantityController.value.text);
    var price = double.parse(sellingPriceController.value.text);
    var cost = double.parse(productCostController.value.text);
    setState(() {
      totalPrice = quantity * price;
      totalCost = quantity * cost;
      grossProfit = totalPrice - totalCost;
    });
  }

  void submit() {
    final form = _formkey1.currentState;

    if (form.validate()) {
      setState(() async {
        _isLoading = true;
        form.save();
        ProductsModel products = ProductsModel.withId(
            null,
            itemNameController.text.toString(),
            double.parse(quantityController.text),
            double.parse(productCostController.text.toString()),
            double.parse(sellingPriceController.text.toString()),
            _serviceDate,
            _time,
            totalPrice,
            totalCost,
            grossProfit);
        var db = new DatabaseHelper();
        await db.insertProduct(products);
        _isLoading = false;

        Navigator.pop(context);
        // _showSnackBar(context, 'New Product added Success!');
      });
    } else {
      _autoValidate = true;
    }
  }

  void _showSnackBar(BuildContext context, String text) {
    final snackbar = SnackBar(content: Text(text));
    Scaffold.of(context).showSnackBar(snackbar);
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        allowFontScaling: true);

    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Product"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            )),
        padding: EdgeInsets.all(ScreenUtil().setWidth(12)),
        child: Form(
          key: _formkey1,
          autovalidate: _autoValidate,
          child: ListView(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Card(
                        child: Container(
                      height: 80,
                      width: MediaQuery.of(context).size.width * 0.40,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Total price = $totalPrice",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )),
                    Column(
                      children: <Widget>[
                        Card(
                            child: Container(
                          height: 40,
                          width: MediaQuery.of(context).size.width * 0.40,
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Total Cost = $totalCost",
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )),
                        Card(
                            child: Container(
                          height: 40,
                          width: MediaQuery.of(context).size.width * 0.40,
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Gross Profite = $grossProfit",
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )),
                      ],
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  padding: EdgeInsets.only(left: 30),
                  width: MediaQuery.of(context).size.width * 0.65,
                  child: TextFormField(
                    controller: itemNameController,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'item name is requierd';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              BorderSide(color: Colors.teal, width: 1.0)),
                      labelText: 'item name',
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: ScreenUtil().setWidth(10),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width / 2.5,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: quantityController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Quantity is requierd';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  BorderSide(color: Colors.teal, width: 1.0)),
                          labelText: 'Quantity',
                        ),
                      ),
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
                  padding: EdgeInsets.only(left: 30),
                  width: MediaQuery.of(context).size.width * 0.65,
                  child: TextFormField(
                    controller: productCostController,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Product Cost is requierd';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              BorderSide(color: Colors.teal, width: 1.0)),
                      labelText: 'Product Cost',
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
                  padding: EdgeInsets.only(left: 30),
                  width: MediaQuery.of(context).size.width * 0.65,
                  child: TextFormField(
                    controller: sellingPriceController,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Selling Price is requierd';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              BorderSide(color: Colors.teal, width: 1.0)),
                      labelText: 'Selling price',
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30.0, top: 10),
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
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  padding: EdgeInsets.only(top: 20),
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
                          onPressed: submit,
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
