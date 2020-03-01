import 'package:dot/helper/databaseHelper.dart';
import 'package:dot/model/loanPaymentModel.dart';
import 'package:dot/pages/loan/loanPaymentEdit.dart';

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import 'loanPaymentDetail.dart';

class LoanPaymentList extends StatefulWidget {
  @override
  _LoanPaymentListState createState() => _LoanPaymentListState();
}

class _LoanPaymentListState extends State<LoanPaymentList> {

  DatabaseHelper helper = new DatabaseHelper();
  List<LoanPaymentModel> loanPaymentList;
  int count = 0;
  @override
  Widget build(BuildContext context) {

    if (loanPaymentList == null) {
      loanPaymentList = List<LoanPaymentModel>();
      updateListView();
    }
    return Scaffold(
      body: ListView.builder(
          itemCount: count,
          itemBuilder: (BuildContext context, index) {
            return Column(
              children: <Widget>[
                ListTile(

                  leading: Icon(Icons.attach_money),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('${loanPaymentList[index].lender}'),
                      Text('${loanPaymentList[index].amount.toString()}'),
                    ],
                  ),
                  subtitle: Row(
                    children: <Widget>[
                      Expanded(
                        flex:3,
                          child: Text('${loanPaymentList[index].description}',
                            overflow: TextOverflow.clip,
                            )
                      ),
                      Expanded(
                        flex:1,
                          child: Text('${loanPaymentList[index].date}')
                      ),
                    ],
                  ),
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LoanPaymentDetail(loanPaymentList[index])));
                  },
                  trailing: CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: IconButton(icon: Icon(Icons.edit), onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LoanPaymentEdit(loanPaymentList[index])));
                    }),
                  ),
                ),
                Divider()
              ],
            );
          }),
    );
  }

  void updateListView() async{
    final Future<Database> dbfuture =  helper.databaseIntiolize();
    dbfuture.then((database) {
      Future<List<LoanPaymentModel>> loanPaymentListFuture = helper.loanPaymentToMapList();
      loanPaymentListFuture.then((otherList) {
        setState(() {
          this.loanPaymentList = otherList;
          this.count = otherList.length;
        });
      });
    });
  }
}
