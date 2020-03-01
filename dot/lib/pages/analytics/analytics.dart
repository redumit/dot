import 'package:dot/helper/databaseHelper.dart';
import 'package:dot/model/productModel.dart';
import 'package:dot/model/serviceModel.dart';
import 'package:dot/pages/analytics/monthly.dart';
import 'package:dot/pages/sync/syncs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:sqflite/sqflite.dart';

class ReportAnalitic extends StatefulWidget {
  @override
  _ReportAnaliticState createState() => _ReportAnaliticState();
}

class _ReportAnaliticState extends State<ReportAnalitic> {
  int _i = 0;

  Color _color2, _color3 = Colors.white;
  Color _color1 = Colors.blue;
  void colorchangeday() {
    setState(() {
      _color1 = Colors.blue;
      _color2 = Colors.white;
      _color3 = Colors.white;
    });
  }

  void colorchangweek() {
    setState(() {
      _color2 = Colors.blue;
      _color1 = Colors.white;
      _color3 = Colors.white;
    });
  }

  void colorchangmonth() {
    setState(() {
      _color2 = Colors.white;
      _color3 = Colors.blue;
      _color1 = Colors.white;
    });
  }

  final titlestyle =
  TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white);
  Widget bodypage() {
    switch (_i) {
      case 0:
        return Dayliy();
      case 1:
        return Weekly();
      case 2:
        return Monthlyanalysis();
        break;
      default:
        return Dayliy();
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        allowFontScaling: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Reporting'),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
            child: Center(
              child: Center(
                child: Row(
                  children: <Widget>[
                    Container(
                      height: ScreenUtil().setWidth(45),
                      width: MediaQuery.of(context).size.width / 3.3,
                      padding: EdgeInsets.only(left: ScreenUtil().setWidth(10)),
                      child: FlatButton(
                        color: _color1,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        onPressed: () {
                          colorchangeday();
                          setState(() {
                            _i = 0;
                          });
                        },
                        child: Text(
                          'Dayliy',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54),
                        ),
                      ),
                    ),
                    Container(
                      height: ScreenUtil().setWidth(45),
                      width: MediaQuery.of(context).size.width / 3.3,
                      padding: EdgeInsets.only(left: ScreenUtil().setWidth(10)),
                      child: FlatButton(
                        color: _color2,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        onPressed: () {
                          colorchangweek();
                          setState(() {
                            _i = 1;
                          });
                        },
                        child: Text(
                          'Weekliy',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54),
                        ),
                      ),
                    ),
                    Container(
                      height: ScreenUtil().setWidth(45),
                      width: MediaQuery.of(context).size.width / 3.3,
                      padding: EdgeInsets.only(
                        left: ScreenUtil().setWidth(10),
                      ),
                      child: FlatButton(
                          color: _color3,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          onPressed: () {
                            colorchangmonth();
                            setState(() {
                              _i = 2;
                            });
                          },
                          child: Text(
                            'Monthly',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black54),
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Divider(
            color: Colors.black12,
            thickness: 1,
          ),
          bodypage(),
        ],
      ),
    );
  }
}

//

class Dayliy extends StatefulWidget {
  @override
  _DayliyState createState() => _DayliyState();
}

class _DayliyState extends State<Dayliy> {
  TextStyle txtstyle =
  TextStyle(fontSize: ScreenUtil().setSp(16), fontWeight: FontWeight.bold);
  String _nowdate = DateFormat.yMd().format(DateTime.now()).toString();
  Map<String, double> dataMap = Map();
  List<Color> colorList = [
    Colors.red,
    Colors.lightBlueAccent,
    Colors.yellow,
    Colors.grey,
  ];

  double totalSaleService = 0;
  double totalExpeService = 0;
  double grossProfitService = 0;
  double totalSale =0;
  double totalExpense =0;
  double totalGrossProfit =0;
  List<ProductsModel> products ;
  List<ServiceModel> services ;
  int count = 0;
  int countService = 0;
  DatabaseHelper helper = new DatabaseHelper();

  _updateProducts(){
    final Future<Database> dbfuture = helper.databaseIntiolize();
    dbfuture.then((database) {
      Future<List<ProductsModel>> productListFture = helper.productToMapList();
      productListFture.then((productlist) {
        setState(() {
          this.products = productlist;
          this.count = productlist.length;
        });
      });
    });

  }
  _updateService(){
    final Future<Database> dbfuture = helper.databaseIntiolize();
    dbfuture.then((database) {
      Future<List<ServiceModel>> serviceListFuture = helper.serviceToMapList();
      serviceListFuture.then((servicelist) {
        setState(() {
          this.services = servicelist;
          this.countService = servicelist.length;
        });
      });
    });

  }

  @override
  void initState() {
    super.initState();
    dataMap.putIfAbsent("Income", () => 5);
    dataMap.putIfAbsent("Outcome", () => 3);
    dataMap.putIfAbsent("Savings", () => 3);
    dataMap.putIfAbsent("Others", () => 1);
  }


  @override
  Widget build(BuildContext context) {
    if(products == null){
      products = List<ProductsModel>();
      _updateProducts();
    }
    if(count>0){
      for(int i=0;i<products.length; i++){
        setState(() {
          totalSale +=products[i].totalPrice;
          totalExpense += products[i].totalCost;
          totalGrossProfit +=products[i].grossProfit;
        });
      }
    }
    if(services == null){
      services = List<ServiceModel>();
      _updateService();
    }
    if(countService>0){
      for(int i=0;i<services.length; i++){
        setState(() {
          totalSaleService +=services[i].sellingPrice;
          totalExpeService +=services[i].laborCost+services[i].otherExpense;
          grossProfitService += services[i].grossProfit;
        });
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(ScreenUtil().setWidth(8)),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: EdgeInsets.only(left: ScreenUtil().setWidth(15)),
              decoration: BoxDecoration(
                  border: Border.all(width: .8),
                  borderRadius: BorderRadius.circular(8)),
              width: ScreenUtil().setWidth(150),
              child: Row(
                children: <Widget>[
                  Text('$_nowdate'),
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
                          _nowdate = format.format(date).toString();
                        });
                      });
                    },
                  )
                ],
              ),
            ),
          ),
        ),
        PieChart(
          legendStyle: TextStyle(
              color: Colors.indigo,
              fontSize: ScreenUtil().setSp(17),
              fontWeight: FontWeight.bold),
          dataMap: dataMap,
          animationDuration: Duration(milliseconds: 800),
          chartLegendSpacing: ScreenUtil().setWidth(40),
          chartRadius: MediaQuery.of(context).size.width / 2.5,
          showChartValuesInPercentage: true,
          showChartValues: true,
          showChartValuesOutside: false,
          chartValueBackgroundColor: Colors.grey[200],
          colorList: colorList,
          showLegends: true,
          legendPosition: LegendPosition.right,
          decimalPlaces: 1,
          showChartValueLabel: true,
          initialAngle: 0,
          chartValueStyle: defaultChartValueStyle.copyWith(
            color: Colors.blueGrey[900].withOpacity(0.9),
          ),
          chartType: ChartType.disc,
        ),
        Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(columns: <DataColumn>[
              DataColumn(
                  label: Text(
                    'Type',
                    style: txtstyle,
                  )),
              DataColumn(
                  label: Text(
                    'TotalSales',
                    style: txtstyle,
                    overflow: TextOverflow.visible,
                  )),
              DataColumn(label: Text('EXpence', style: txtstyle)),
              DataColumn(label: Text('Profit', style: txtstyle)),
            ], rows: <DataRow>[
              DataRow(
                cells: <DataCell>[
                  DataCell(Center(
                    child: Text("Product", style: txtstyle),
                  )),
                  DataCell(Text(totalSale.toString())),
                  DataCell(Text(totalExpense.toString())),
                  DataCell(Text(totalGrossProfit.toString())),
                ],
              ),
              DataRow(
                cells: <DataCell>[
                  DataCell(Center(
                    child: Text("Service", style: txtstyle),
                  )),
                  DataCell(Text(totalSaleService.toString())),
                  DataCell(Text(totalExpeService.toString())),
                  DataCell(Text(grossProfitService.toString())),
                ],
              ),
              DataRow(
                cells: <DataCell>[
                  DataCell(Center(
                    child: Text("Total", style: txtstyle),
                  )),
                  DataCell(Text("${totalSale + totalSaleService}")),
                  DataCell(Text("${totalExpense+ totalExpeService}")),
                  DataCell(Text("${totalGrossProfit+ grossProfitService}")),
                ],
              ),
            ]),
          ),
        ),
      ],
    );
  }
}

class Weekly extends StatefulWidget {
  @override
  _WeeklyState createState() => _WeeklyState();
}

class _WeeklyState extends State<Weekly> {
  TextStyle txtstyle =
  TextStyle(fontSize: ScreenUtil().setSp(16), fontWeight: FontWeight.bold);
  String _weekdate = DateFormat.yMd().format(DateTime.now()).toString();

  Map<String, double> dataMap  ;
  List<Color> colorList ;

  double totalSaleService = 0;
  double totalExpeService = 0;
  double grossProfitService = 0;
  double totalSale =0;
  double totalExpense =0;
  double totalGrossProfit =0;
  List<ProductsModel> products ;
  List<ServiceModel> services ;
  int count = 0;
  int countService = 0;
  DatabaseHelper helper = new DatabaseHelper();

  _updateProducts(){
    final Future<Database> dbfuture = helper.databaseIntiolize();
    dbfuture.then((database) {
      Future<List<ProductsModel>> productListFture = helper.productToMapList();
      productListFture.then((productlist) {
        setState(() {
          this.products = productlist;
          this.count = productlist.length;
        });
      });
    });

  }
  _updateService(){
    final Future<Database> dbfuture = helper.databaseIntiolize();
    dbfuture.then((database) {
      Future<List<ServiceModel>> serviceListFuture = helper.serviceToMapList();
      serviceListFuture.then((servicelist) {
        setState(() {
          this.services = servicelist;
          this.countService = servicelist.length;
        });
      });
    });

  }

  @override
  void initState() {
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    if(products == null){
      products = List<ProductsModel>();
      _updateProducts();
    }
    if(count>0){
      for(int i=0;i<products.length; i++){
        setState(() {
          totalSale +=products[i].totalPrice;
          totalExpense += products[i].totalCost;
          totalGrossProfit +=products[i].grossProfit;
        });
      }
    }
    if(services == null){
      services = List<ServiceModel>();
      _updateService();
    }
    if(countService>0){
      for(int i=0;i<services.length; i++){
        setState(() {
          totalSaleService +=services[i].sellingPrice;
          totalExpeService +=services[i].laborCost+services[i].otherExpense;
          grossProfitService += services[i].grossProfit;



        });
      }
    }
    if(dataMap == null || colorList == null ){
      dataMap = Map();
      setState(() {
        dataMap.putIfAbsent("Income", () => 5);
        dataMap.putIfAbsent("Outcome", () => 3);
        dataMap.putIfAbsent("Savings", () => 3);
        dataMap.putIfAbsent("Others", () => 1);
        colorList = [
          Colors.red,
          Colors.lightBlueAccent,
          Colors.yellow,
        ];
      });
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(ScreenUtil().setWidth(8)),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: EdgeInsets.only(left: ScreenUtil().setWidth(15)),
              decoration: BoxDecoration(
                  border: Border.all(width: .8),
                  borderRadius: BorderRadius.circular(8)),
              width: ScreenUtil().setWidth(150),
              child: Row(
                children: <Widget>[
                  Text('$_weekdate'),
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
                          _weekdate = format.format(date).toString();
                        });
                      });
                    },
                  )
                ],
              ),
            ),
          ),
        ),
        PieChart(
          legendStyle: TextStyle(
              color: Colors.indigo,
              fontSize: ScreenUtil().setSp(17),
              fontWeight: FontWeight.bold),
          dataMap: dataMap,
          animationDuration: Duration(milliseconds: 800),
          chartLegendSpacing: ScreenUtil().setWidth(40),
          chartRadius: MediaQuery.of(context).size.width / 2.5,
          showChartValuesInPercentage: true,
          showChartValues: true,
          showChartValuesOutside: false,
          chartValueBackgroundColor: Colors.grey[200],
          colorList: colorList,
          showLegends: true,
          legendPosition: LegendPosition.right,
          decimalPlaces: 1,
          showChartValueLabel: true,
          initialAngle: 0,
          chartValueStyle: defaultChartValueStyle.copyWith(
            color: Colors.blueGrey[900].withOpacity(0.9),
          ),
          chartType: ChartType.disc,
        ),
        Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(columns: <DataColumn>[
              DataColumn(
                  label: Text(
                    'Type',
                    style: txtstyle,
                  )),
              DataColumn(
                  label: Text(
                    'TotalSales',
                    style: txtstyle,
                    overflow: TextOverflow.visible,
                  )),
              DataColumn(label: Text('EXpence', style: txtstyle)),
              DataColumn(label: Text('Profit', style: txtstyle)),
            ], rows: <DataRow>[
              DataRow(
                cells: <DataCell>[
                  DataCell(Center(
                    child: Text("Product", style: txtstyle),
                  )),
                  DataCell(Text(totalSale.toString())),
                  DataCell(Text(totalExpense.toString())),
                  DataCell(Text(totalGrossProfit.toString())),
                ],
              ),
              DataRow(
                cells: <DataCell>[
                  DataCell(Center(
                    child: Text("Service", style: txtstyle),
                  )),
                  DataCell(Text(totalSaleService.toString())),
                  DataCell(Text(totalExpeService.toString())),
                  DataCell(Text(grossProfitService.toString())),
                ],
              ),
              DataRow(
                cells: <DataCell>[
                  DataCell(Center(
                    child: Text("Total", style: txtstyle),
                  )),
                  DataCell(Text("${totalSale + totalSaleService}")),
                  DataCell(Text("${totalExpense+ totalExpeService}")),
                  DataCell(Text("${totalGrossProfit+ grossProfitService}")),
                ],
              ),
            ]),
          ),
        ),
      ],
    );
  }
}

class Monthly extends StatefulWidget {
  @override
  _MonthlyState createState() => _MonthlyState();
}

class _MonthlyState extends State<Monthly> {
  String _todate='to';
  String _fromdate='from';

  String dateFrom = DateFormat.yMd(DateTime.now()).toString();
  var dateUpto;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        allowFontScaling: true);
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[

            Padding(
              padding:EdgeInsets.only(left:8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('$dateFrom'),
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
                          dateFrom = format.format(date);
                        });
                      });
                    },
                  )
                ],
              ),
            ),
            Text('To'),
//            Row(
//              crossAxisAlignment: CrossAxisAlignment.center,
//              children: <Widget>[
//                Text('$_todate'),
//                IconButton(
//                  icon: Icon(Icons.date_range, color: Colors.blue),
//                  onPressed: () {
//                    var format = DateFormat.yMd();
//                    showDatePicker(
//                        context: context,
//                        initialDate: DateTime.now(),
//                        firstDate: DateTime(200),
//                        lastDate: DateTime(2021))
//                        .then((date) {
//                      setState(() {
//                        _todate = format.format(date).toString();
//                      });
//                    });
//                  },
//                ),
//              ],
//            )
          ],
        ),

//        Card(
//
//          child: Container(
//
//            width: ScreenUtil().setWidth(350),
//            height: ScreenUtil().setWidth(110),
//
//
//            child: Column(
//              crossAxisAlignment: CrossAxisAlignment.stretch,
//              children: <Widget>[
//                Row(
//                  mainAxisAlignment: MainAxisAlignment.center,
//                  children: <Widget>[
//                    Card(
//                      elevation: 4,
//
//                      shape: RoundedRectangleBorder(
//                          borderRadius: BorderRadius.circular(30)
//                      ),
//                      child: Container(
//                          width: ScreenUtil().setWidth(350/2.05),
//                          height: ScreenUtil().setWidth(100/2),
//
//                          color: Colors.greenAccent,
//                          child: Column(
//                            children: <Widget>[
//                              Text('Total Monthly Revenue'),
//                              Text('5000 Birr'),
//                            ],
//                          )),
//                    ),
//                    Container(
//                        width: ScreenUtil().setWidth(350/2.05),
//                        height: ScreenUtil().setWidth(100/2),
//
//                        color: Colors.lightBlueAccent,
//                        child: Column(
//                          children: <Widget>[
//                            Text('Total Monthly Expence'),
//                            Text('totalexpence'),
//                          ],
//                        )),
//                  ],
//                ),
//                Container(
//                    width: ScreenUtil().setWidth(350),
//                    height: ScreenUtil().setWidth(100/2),
//
//                    color: Colors.blueGrey,
//                    child: Column(
//                      children: <Widget>[
//                        Text('Total Monthly Expence'),
//                        Text('totalrevenue'),
//                      ],
//                    )),
//              ],
//            ),
//          ),
//        ),
        ListTile(
          title: Text('Revenues'),),

        Padding(
          padding: EdgeInsets.only(left:ScreenUtil().setWidth(15)),
          child: Column(children: <Widget>[
            ListTile(
              title: Text('Reveue From Service'),
              subtitle: Text('2345'),

            ),
            ListTile(
              title: Text('Reveue From MaterialSalles'),
              subtitle: Text('2345'),

            ),
          ],),
        ),

        ListTile(
          title: Text('Expences'),),

        Padding(
          padding: EdgeInsets.only(left:ScreenUtil().setWidth(10)),
          child: Column(
            children: <Widget>[
              ListTile(
                title: Text('CostofGoods'),
                subtitle: Text('34'),),
              ListTile(
                title: Text('Sallary Expense'),
                subtitle: Text('34'),),
              ListTile(
                title: Text('Rent Expence'),
                subtitle: Text('34'),),
              ListTile(
                title: Text('Advertizing Expence'),
                subtitle: Text('34'),),
              ListTile(
                title: Text('Supply \$ Utility Expence'),
                subtitle: Text('34'),),
              ListTile(
                title: Text('Interest Expence'),
                subtitle: Text('34'),),

            ],
          ),)
      ],
    );
  }
}