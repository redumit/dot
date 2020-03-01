import 'package:dot/helper/databaseHelper.dart';
import 'package:dot/model/serviceModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailService extends StatefulWidget {
  DetailService(this.service);
  ServiceModel service;
  @override
  _DetailServiceState createState() => _DetailServiceState(this.service);
}

class _DetailServiceState extends State<DetailService> {
  _DetailServiceState(this.service);
  ServiceModel service;

  List<String> names = [
    'Service Name',
    'Customer segment',
    'Selling Price',
    'Labor Cost',
    'Other Expense',
    'Hours of Work',
    'Gross Profit',
    'Service Date',
    'Service Time',
  ];
  List<dynamic> serviceValue;
  @override
  void initState() {
    servceName = service.serviceName;
    sellingprice = service.sellingPrice;
    servicedate = service.date;
    time = service.time;
    hourWork = service.hourWork;
    laborCost = service.laborCost;
    serviceSegment = service.segment;
    otherExpense = service.otherExpense;
    grossProfit = service.grossProfit;
    super.initState();
  }

  String servceName, servicedate, time, serviceSegment;
  double sellingprice, laborCost, otherExpense, grossProfit;
  int hourWork;
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        allowFontScaling: true);

    serviceValue = [
      service.serviceName,
      service.segment,
      service.sellingPrice,
      service.laborCost,
      service.otherExpense,
      service.hourWork,
      service.grossProfit,
      service.date,
      service.time,
    ];
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Service Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
                height: MediaQuery.of(context).size.height * 0.7,
                child: details()),
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
                              child: Icon(Icons.cancel, color: Colors.brown)),
                          Text(
                            'cancel',
                            style: TextStyle(color: Colors.brown),
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
                      borderSide: BorderSide(color: Colors.red),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      onPressed: () {
                        _delete(service.id);
                      }, //
                      child: Row(
                        children: <Widget>[
                          Container(
                              padding: EdgeInsets.only(
                                  right: ScreenUtil().setWidth(8)),
                              child: Icon(Icons.delete, color: Colors.red)),
                          Text(
                            'Delete',
                            style: TextStyle(color: Colors.red),
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
    );
  }

  _delete(int id) async {
    var db = DatabaseHelper();
    int x = await db.deleteService(id);
    if (x == null) {
      var snackbar = SnackBar(
        content: Text('Not deleted!'),
        backgroundColor: Colors.grey,
      );
      Scaffold.of(context).showSnackBar(snackbar);
    } else {
      Navigator.pop(context);
      var snackbar = SnackBar(
        content: Text('service deleted!'),
        backgroundColor: Colors.red,
      );
      Scaffold.of(context).showSnackBar(snackbar);
    }
  }

  Widget details() {
    return ListView.builder(
        itemCount: names.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: <Widget>[
              ListTile(
                title: Text(names[index]),
                trailing: Text(serviceValue[index].toString()),
              ),
              Divider(),
            ],
          );
        });
  }
}
