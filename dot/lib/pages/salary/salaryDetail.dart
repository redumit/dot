import 'package:dot/helper/databaseHelper.dart';
import 'package:dot/model/productModel.dart';
import 'package:dot/model/salaryModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SalaryDetail extends StatefulWidget {
  SalaryDetail(this.salary);
  SalaryModel salary;
  @override
  _SalaryDetailState createState() => _SalaryDetailState(this.salary);
}

class _SalaryDetailState extends State<SalaryDetail> {
  _SalaryDetailState(this.salary);
  SalaryModel salary;

  List<String> names = [
    'Employee Name',
    'Position',
    'Gender',
    'Total Date',
    'Rate Per Day',
    'Total Payment',
    'Date',

  ];
  List <dynamic> salaryValue;
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        allowFontScaling: true);
    salaryValue = [
      salary.employeeName,
      salary.position,
      salary.gender,
      salary.totalDate,
      salary.ratePerDay,
      salary.totalPayment,
      salary.date,

    ];
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Salary Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
                height: MediaQuery.of(context).size.height*0.7,
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
                              child:
                              Icon(Icons.cancel, color: Colors.brown)),
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
                      onPressed:(){
                        _delete(salary.id);
                      },//
                      child: Row(
                        children: <Widget>[
                          Container(
                              padding: EdgeInsets.only(
                                  right: ScreenUtil().setWidth(8)),
                              child: Icon(Icons.delete,
                                  color: Colors.red)),
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
          ],),

      ),

    );
  }


  _delete(int id) async{
    var db=DatabaseHelper();
    int x=await db.deleteSalary(id);
    if(x==null){
      var snackbar=SnackBar(content: Text('Not deleted!'),backgroundColor: Colors.grey,);
      Scaffold.of(context).showSnackBar(snackbar);

    }
    else{
      Navigator.pop(context);
      var snackbar=SnackBar(content: Text('salary deleted!'),backgroundColor: Colors.red,);
//      Scaffold.of(context).showSnackBar(snackbar);

    }

  }

  Widget details(){
    return ListView.builder(
        itemCount: names.length,
        itemBuilder: (BuildContext context, int index){
          return Column(
            children: <Widget>[
              ListTile(
                title: Text(
                    names[index]
                ),
                trailing:  Text(
                    salaryValue[index].toString()
                ),
              ),
              Divider(),
            ],
          );
        });
  }

}