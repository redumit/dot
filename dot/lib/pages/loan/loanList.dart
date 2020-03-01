import 'package:dot/helper/databaseHelper.dart';
import 'package:dot/model/loanModel.dart';
import 'package:dot/pages/loan/loanAdd.dart';
import 'package:dot/pages/loan/loanDetail.dart';
import 'package:dot/pages/loan/loanEdit.dart';
import 'package:dot/pages/loan/loanPaymentAdd.dart';
import 'package:dot/pages/loan/loanPaymentList.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sqflite/sqflite.dart';

class LoanList extends StatefulWidget {
  @override
  _LoanListState createState() => _LoanListState();
}

class _LoanListState extends State<LoanList> with SingleTickerProviderStateMixin{

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
  }

  void _handleTabSelection() {
    setState(() {
      colorVal = Colors.blue;
    });
  }

  DatabaseHelper helper = new DatabaseHelper();
  List<LoanModel> loanList;
  int count = 0;
  @override
  Widget build(BuildContext context) {

    if (loanList == null) {
      loanList = List<LoanModel>();
      updateListView();
    }

    LoanPaymentList loanUpdate = LoanPaymentList();
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Loan List"),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.refresh), onPressed: updateListView)
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
                text: "Add New Loan",
                icon: Icon(FontAwesomeIcons.bandAid),
              ),
              Tab(
                text: "Loan Payment",
                icon: Icon(Icons.work),
              )
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [newLoan(), LoanPaymentList()],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green,
          child: Icon(Icons.add),
          onPressed: () {
            if(index==0){
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => LoanAdd()));
            }else{
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => LoanPayment()));
            }
          },
        ),
      ),
    );
  }

  Widget newLoan(){
   return  ListView.builder(
        itemCount: count,
        itemBuilder: (BuildContext context, index) {
          return Column(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.local_atm),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(loanList[index].lender),
                    Text(loanList[index].loanAmount.toString()),
                  ],
                ),
                subtitle: Text(loanList[index].paymentDate),
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LoanDetail(loanList[index])));
                },
                trailing: CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LoanEdit(loanList[index])));
                      }),
                ),
              ),
              Divider()
            ],
          );
        });
  }

  void updateListView() {
    final Future<Database> dbfuture = helper.databaseIntiolize();
    dbfuture.then((database) {
      Future<List<LoanModel>> loanListFuture = helper.loanToMapList();
      loanListFuture.then((loanlists) {
        setState(() {
          this.loanList = loanlists;
          this.count = loanlists.length;
        });
      });
    });
  }
}
