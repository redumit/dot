import 'package:dot/helper/databaseHelper.dart';
import 'package:dot/model/loanModel.dart';
import 'package:dot/model/materialModel.dart';
import 'package:dot/model/otherExpenseModel.dart';
import 'package:dot/model/productModel.dart';
import 'package:dot/model/salaryModel.dart';
import 'package:dot/model/serviceModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sqflite/sqflite.dart';

class Monthlyanalysis extends StatefulWidget {
  @override
  _MonthlyanalysisState createState() => _MonthlyanalysisState();
}

class _MonthlyanalysisState extends State<Monthlyanalysis> {
  DatabaseHelper productDatabaseHelper = DatabaseHelper();
  List<ProductsModel> products;
  List<ServiceModel> services;
  List<OtherExpenseModel> others;
  List<MaterialModel> materials;
  List<SalaryModel> salarys;
  List<LoanModel> loans;
  int count = 0;
  void updatelistProducts() {
    final Future<Database> prodb = productDatabaseHelper.databaseIntiolize();
    prodb.then((database) {
      Future<List<ProductsModel>> proLists =
          productDatabaseHelper.productToMapList();
      proLists.then((lists) {
        setState(() {
          this.products = lists;
          this.count = lists.length;
        });
      });
    });
  }

  void updatelistServices() {
    final Future<Database> prodb = productDatabaseHelper.databaseIntiolize();
    prodb.then((database) {
      Future<List<ServiceModel>> proLists =
          productDatabaseHelper.serviceToMapList();
      proLists.then((lists) {
        setState(() {
          this.services = lists;
          this.count = lists.length;
        });
      });
    });
  }

  void updatelistOthers() {
    final Future<Database> prodb = productDatabaseHelper.databaseIntiolize();
    prodb.then((database) {
      Future<List<OtherExpenseModel>> proLists =
          productDatabaseHelper.otherExpenseToMapList();
      proLists.then((lists) {
        setState(() {
          this.others = lists;
          this.count = lists.length;
        });
      });
    });
  }

  void updatelistMaterials() {
    final Future<Database> prodb = productDatabaseHelper.databaseIntiolize();
    prodb.then((database) {
      Future<List<MaterialModel>> proLists =
          productDatabaseHelper.materialToMapList();
      proLists.then((lists) {
        setState(() {
          this.materials = lists;
          this.count = lists.length;
        });
      });
    });
  }

  void updatelistSalarys() {
    final Future<Database> prodb = productDatabaseHelper.databaseIntiolize();
    prodb.then((database) {
      Future<List<SalaryModel>> proLists =
          productDatabaseHelper.salaryToMapList();
      proLists.then((lists) {
        setState(() {
          this.salarys = lists;
          this.count = lists.length;
        });
      });
    });
  }

  void updatelistLoans() {
    final Future<Database> prodb = productDatabaseHelper.databaseIntiolize();
    prodb.then((database) {
      Future<List<LoanModel>> proLists = productDatabaseHelper.loanToMapList();
      proLists.then((lists) {
        setState(() {
          this.loans = lists;
        });
      });
    });
  }

  void updateAllVariables() {
    for (int i = 0; i < services.length; i++) {
      setState(() {
        serviceRevenue += services[i].sellingPrice;
      });
    }

    for (int i = 0; i < products.length; i++) {
      setState(() {
        productRevenue += products[i].sellingPrice;
      });
    }

    for (int i = 0; i < salarys.length; i++) {
      setState(() {
        salaryExpense += salarys[i].totalPayment;
      });
    }

    for (int i = 0; i < materials.length; i++) {
      setState(() {
        totalPurchaseCost += materials[i].purchaseCost;
        deprecation += materials[i].deprecationPerYear;
      });
    }

    for (int i = 0; i < others.length; i++) {
      setState(() {
        otherExpense += others[i].purchaseCost;
      });
    }
  }

  double serviceRevenue = 0;
  double productRevenue = 0;
  double totalExpense = 0;
  double interestExpense = 0;
  double otherExpense = 0;
  double salaryExpense = 0;
  double totalPurchaseCost = 0;
  double totalGrossProfit = 0;
  double totalIncome = 0;
  double deprecation = 0;

  var totalList;
  @override
  void initState() {
    print('totalexpense $totalExpense');
    updatelistServices();
    updatelistSalarys();
    updatelistLoans();
    updatelistMaterials();
    updatelistOthers();
    updatelistProducts();

    super.initState();
  }

  String message = "";
  @override
  Widget build(BuildContext context) {
    if (products == null) {
      products = List<ProductsModel>();
      updatelistProducts();
    }
    if (services == null) {
      services = List<ServiceModel>();
      updatelistServices();
    }
    if (others == null) {
      others = List<OtherExpenseModel>();
      updatelistOthers();
    }
    if (materials == null) {
      materials = List<MaterialModel>();
      updatelistMaterials();
    }
    if (salarys == null) {
      salarys = List<SalaryModel>();
      updatelistSalarys();
    }
    if (loans == null) {
      loans = List<LoanModel>();
      updatelistLoans();
    }
    updateAllVariables();
    try {
      totalExpense = totalPurchaseCost + salaryExpense + interestExpense;
      totalIncome = serviceRevenue + productRevenue;
      totalGrossProfit = totalIncome - totalExpense;
    } catch (e) {
      debugPrint(e.toString());
    }
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      child: StaggeredGridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 12.0,
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        children: <Widget>[
          _buildTile(
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Revenue from Service',
                            style: TextStyle(color: Colors.blueAccent)),
                        Text('$serviceRevenue',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 34.0))
                      ],
                    ),
                    Material(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(24.0),
                        child: Center(
                            child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Icon(Icons.timeline,
                              color: Colors.white, size: 30.0),
                        )))
                  ]),
            ),
          ),
          _buildTile(
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Revenue from Product',
                            style: TextStyle(color: Colors.redAccent)),
                        Text('$productRevenue',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 34.0))
                      ],
                    ),
                    Material(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(24.0),
                        child: Center(
                            child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Icon(Icons.account_balance_wallet,
                              color: Colors.white, size: 30.0),
                        )))
                  ]),
            ),
          ),
          _buildTile(
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Material(
                        color: Colors.teal,
                        shape: CircleBorder(),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Icon(Icons.monetization_on,
                              color: Colors.white, size: 30.0),
                        )),
                    Text('Salary Expense',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 18.0)),
                    Text('$salaryExpense',
                        style: TextStyle(color: Colors.black45)),
                  ]),
            ),
          ),
          _buildTile(
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Material(
                        color: Colors.amber,
                        shape: CircleBorder(),
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Icon(Icons.payment,
                              color: Colors.white, size: 30.0),
                        )),
                    Text('Material Exp',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 18.0)),
                    Text('$totalPurchaseCost ',
                        style: TextStyle(color: Colors.black45)),
                  ]),
            ),
          ),
          _buildTile(
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Material(
                        color: Colors.deepPurple,
                        shape: CircleBorder(),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Icon(Icons.devices_other,
                              color: Colors.white, size: 30.0),
                        )),
                    Text('Other Expense',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 18.0)),
                    Text('$otherExpense',
                        style: TextStyle(color: Colors.black45)),
                  ]),
            ),
          ),
          _buildTile(
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Material(
                        color: Colors.pink,
                        shape: CircleBorder(),
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Icon(Icons.redeem,
                              color: Colors.white, size: 30.0),
                        )),
                    Text('Deprecation Expense',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 18.0)),
                    Text('$deprecation ',
                        style: TextStyle(color: Colors.black45)),
                  ]),
            ),
          ),
          _buildTile(
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Total Monthly Expense',
                            style: TextStyle(color: Colors.redAccent)),
                        Text('$totalExpense',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 34.0))
                      ],
                    ),
                    Material(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(24.0),
                        child: Center(
                            child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Icon(Icons.store,
                              color: Colors.white, size: 30.0),
                        )))
                  ]),
            ),
//              onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => ShopItemsPage())),
          ),
          _buildTile(
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Total Monthly Revenu',
                            style: TextStyle(color: Colors.green)),
                        Text('$totalIncome',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 34.0))
                      ],
                    ),
                    Material(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(24.0),
                        child: Center(
                            child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Icon(FontAwesomeIcons.buyNLarge,
                              color: Colors.white, size: 30.0),
                        )))
                  ]),
            ),
//              onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => ShopItemsPage())),
          ),
          _buildTile(
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Income Befor Tax',
                            style: TextStyle(color: Colors.blueAccent)),
                        Text('$totalGrossProfit',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 34.0))
                      ],
                    ),
                    Material(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(24.0),
                        child: Center(
                            child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Icon(FontAwesomeIcons.solidMoneyBillAlt,
                              color: Colors.white, size: 30.0),
                        )))
                  ]),
            ),
//              onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => ShopItemsPage())),
          )
        ],
        staggeredTiles: [
          StaggeredTile.extent(2, 110.0),
          StaggeredTile.extent(2, 110.0),
          StaggeredTile.extent(1, 180.0),
          StaggeredTile.extent(1, 180.0),
          StaggeredTile.extent(1, 180.0),
          StaggeredTile.extent(1, 180.0),
          StaggeredTile.extent(2, 110.0),
          StaggeredTile.extent(2, 110.0),
          StaggeredTile.extent(2, 110.0),
        ],
      ),
    );
  }

  Widget _buildTile(Widget child, {Function() onTap}) {
    return Material(
        elevation: 14.0,
        borderRadius: BorderRadius.circular(12.0),
        shadowColor: Color(0x802196F3),
        child: InkWell(
            // Do onTap() if it isn't null, otherwise do print()
            onTap: onTap != null
                ? () => onTap()
                : () {
                    print('Not set yet');
                  },
            child: child));
  }
}
