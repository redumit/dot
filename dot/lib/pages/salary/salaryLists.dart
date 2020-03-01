import 'package:dot/helper/databaseHelper.dart';
import 'package:dot/model/salaryModel.dart';
import 'package:dot/pages/salary/salaryAdd.dart';
import 'package:dot/pages/salary/salaryDetail.dart';
import 'package:dot/pages/salary/salaryEdit.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqlite_api.dart';

class SalaryList extends StatefulWidget {
  @override
  _SalaryListState createState() => _SalaryListState();
}

class _SalaryListState extends State<SalaryList> {
  DatabaseHelper helper = new DatabaseHelper();
  List<SalaryModel> salaryList;
  int count = 0;

@override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {

//      Future.delayed(Duration(seconds: 10)).then((_){
//        updateListView();
//      });
    if(salaryList == null){
      salaryList = List<SalaryModel>();
      updateListView();
    }

    return Scaffold(

      appBar: AppBar(
        title: Text("List of Salary Expenses"),
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
                    leading: Icon(Icons.person),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          flex: 3,
                          child: Text(
                            salaryList[index].employeeName,
                            overflow: TextOverflow.clip,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            salaryList[index].totalPayment.toString(),
                            overflow: TextOverflow.clip,
                          ),
                        ),
                      ],
                    ),
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SalaryDetail(salaryList[index])));
                    },
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(salaryList[index].position),
                        SizedBox(
                          width: 15,
                        ),
                        Text(salaryList[index].date)
                      ],
                    ),
                    trailing: CircleAvatar(
                      backgroundColor: Colors.blue,
                      child: IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    SalaryEdit(salaryList[index])));
                          }),
                    )),
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
              .push(MaterialPageRoute(builder: (context) => SalaryAdd()));
        },
      ),
    );
  }

  void updateListView() {
    final Future<Database> dbfuture = helper.databaseIntiolize();
    dbfuture.then((database) {
      Future<List<SalaryModel>> salaryListFuture = helper.salaryToMapList();
      salaryListFuture.then((salarylist) {
        setState(() {
          this.salaryList = salarylist;
          this.count = salarylist.length;
        });
      });
    });
  }
}
