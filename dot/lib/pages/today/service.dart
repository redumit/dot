import 'package:dot/helper/databaseHelper.dart';
import 'package:dot/model/productModel.dart';
import 'package:dot/model/serviceModel.dart';
import 'package:dot/pages/today/addProduct.dart';
import 'package:dot/pages/today/addService.dart';
import 'package:dot/pages/today/detailProduct.dart';
import 'package:dot/pages/today/productEdit.dart';
import 'package:dot/pages/today/serviceDetail.dart';
import 'package:dot/pages/today/serviceEdit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sqflite/sqflite.dart';

class TodayActivity extends StatefulWidget {
  @override
  _TodayActivityState createState() => _TodayActivityState();
}

class _TodayActivityState extends State<TodayActivity>
    with SingleTickerProviderStateMixin {

  //tabcontroller
  TabController _tabController;
  // index
  int index = 0;
  Color colorVal;
  // service data
  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 2);
    _tabController.addListener(_handleTabSelection);
    updateProductListView();
    updateServiceListView();
  }

  void _handleTabSelection() {
    setState(() {
      colorVal = Colors.blue;
    });
  }

  //Database
  DatabaseHelper helper = new DatabaseHelper();
  List<ServiceModel> serviceList;
  List<ProductsModel> productList;
  int serviceCount = 0;
  int productCount = 0;

  void updateServiceListView() {
    final Future<Database> dbFuture = helper.databaseIntiolize();
    dbFuture.then((database) {
      Future<List<ServiceModel>> serviceListFuture = helper.serviceToMapList();
      serviceListFuture.then((serviceList) {
        setState(() {
          this.serviceList = serviceList;
          this.serviceCount = serviceList.length;
        });
      });
    });
  }
  void updateProductListView() {
    final Future<Database> dbFuture = helper.databaseIntiolize();
    dbFuture.then((database) {
      Future<List<ProductsModel>> productListFuture = helper.productToMapList();
      productListFuture.then((productList) {
        setState(() {
          this.productList = productList;
          this.productCount = productList.length;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (serviceList == null) {
      serviceList = List<ServiceModel>();
      updateServiceListView();
    }
    if (productList == null) {
      productList = List<ProductsModel>();
      updateProductListView();
    }
    var ht = MediaQuery.of(context).size.height;
    var wd = MediaQuery.of(context).size.width;
    ScreenUtil.init(context, width: wd, height: ht, allowFontScaling: true);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Today"),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.refresh), onPressed: (){
              if(index == 0){
                updateServiceListView();
              }
              else{
                updateProductListView();
              }
            })
          ],
          bottom: TabBar(
            onTap: (currentIndex) {
              setState(() {
                index = currentIndex;
              });
            },
            controller: _tabController,
            tabs: <Widget>[
              Tab(
                text: "Service",
                icon: Icon(Icons.map),
              ),
              Tab(
                text: "Product",
                icon: Icon(Icons.work),
              )
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [serviceTab(), productTab()],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green,
          child: Icon(Icons.add),
          onPressed: () {
            debugPrint("Pressed");
            if (index == 0) {
               Navigator.of(context)
                   .push(MaterialPageRoute(builder: (context) => AddService()));
            } else {
               Navigator.of(context)
                   .push(MaterialPageRoute(builder: (context) => AddProduct()));
            }
          },
        ),
      ),
    );
  }

  Widget addService() {
    return SimpleDialog(
      title: Text("service"),
      children: <Widget>[Text("Content")],
    );
  }

  Widget addProduct() {
    return AlertDialog(
      title: Text("Product"),
      content: Text("content"),
    );
  }

  Widget productTab() {
    return ListView.builder(
        itemCount: productCount,
        itemBuilder: (BuildContext context, index) {
          return Column(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.work),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(productList[index].itemName),
                    Text(productList[index].grossProfit.toString()),
                  ],
                ),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(productList[index].serviceDate),
                    SizedBox(
                      width: 15,
                    ),
                    Text(productList[index].time)
                  ],
                ),
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>DetailProduct(productList[index])));
                },
                trailing: CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: IconButton(icon: Icon(Icons.edit), onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>EditProduct(productList[index])));
                  }),
                ),
              ),
              Divider()
            ],
          );
        });
  }

  Widget serviceTab() {

    return ListView.builder(
        itemCount: serviceCount,
        itemBuilder: (BuildContext context, index) {
          return Column(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.pan_tool),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(serviceList[index].serviceName),
                    Text(serviceList[index].grossProfit.toString()),
                  ],
                ),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(serviceList[index].date),
                    SizedBox(
                      width: 15,
                    ),
                    Text(serviceList[index].time)
                  ],
                ),
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>DetailService(serviceList[index])));
                },
                trailing: CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: IconButton(icon: Icon(Icons.edit), onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>EditService(serviceList[index])));
                  }),
                ),
              ),
              Divider()
            ],
          );
        });
  }
}
