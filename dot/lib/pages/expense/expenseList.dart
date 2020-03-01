import 'package:dot/helper/databaseHelper.dart';
import 'package:dot/model/otherExpenseModel.dart';
import 'package:dot/pages/expense/expenseAdd.dart';
import 'package:dot/pages/expense/expenseDetail.dart';
import 'package:dot/pages/expense/expenseEdit.dart';
import 'package:dot/pages/material/materialAdd.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class ExpenseList extends StatefulWidget {
  @override
  _ExpenseListState createState() => _ExpenseListState();
}

class _ExpenseListState extends State<ExpenseList> {

  DatabaseHelper helper = new DatabaseHelper();
  List<OtherExpenseModel> expenseList;
  int count = 0;
  @override
  Widget build(BuildContext context) {

    if (expenseList == null) {
      expenseList = List<OtherExpenseModel>();
      updateListView();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Other Expense"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.refresh), onPressed: updateListView)
        ],
      ),
      body: ListView.builder(
          itemCount: count,
          itemBuilder: (BuildContext context, index) {
            return Column(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.computer),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(expenseList[index].expenseName),
                      Text(expenseList[index].purchaseCost.toString()),
                    ],
                  ),
                  subtitle: Text(expenseList[index].time),
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ExpenseDetail(expenseList[index])));
                  },
                  trailing: CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: IconButton(icon: Icon(Icons.edit), onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ExpenseEdit(expenseList[index])));
                    }),
                  ),
                ),
                Divider()
              ],
            );
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        child: Icon(Icons.add),
        onPressed: () {
          debugPrint("Pressed");
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => ExpenceAdd()));
        },
      ),
    );
  }

  void updateListView() async{
    final Future<Database> dbfuture =  helper.databaseIntiolize();
    dbfuture.then((database) {
      Future<List<OtherExpenseModel>> expenseListFuture = helper.otherExpenseToMapList();
      expenseListFuture.then((otherList) {
        setState(() {
          this.expenseList = otherList;
          this.count = otherList.length;
        });
      });
    });
  }
}
