import 'package:dot/helper/databaseHelper.dart';
import 'package:dot/model/loanModel.dart';
import 'package:dot/model/loanPaymentModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoanPaymentDetail extends StatefulWidget {
  LoanPaymentDetail(this.loan);
  LoanPaymentModel loan;
  @override
  _LoanDetailState createState() => _LoanDetailState(this.loan);
}

class _LoanDetailState extends State<LoanPaymentDetail> {
  _LoanDetailState(this.oldLoan);
  LoanPaymentModel oldLoan;

  List<String> names = [
    'Lender Name',
    'Amount Payed',
    'Description',
    'Payment Date',

  ];
  List<dynamic> loanValue;
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
    loanValue = [
      oldLoan.lender,
      oldLoan.amount,
      oldLoan.description,
      oldLoan.date,

    ];
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Loan Payment Details'),
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
                        _delete(oldLoan.id);
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
    int x = await db.deleteLoanPayment(id);
    if (x == null) {
      var snackbar = SnackBar(
        content: Text('Not deleted!'),
        backgroundColor: Colors.grey,
      );
      Scaffold.of(context).showSnackBar(snackbar);
    } else {
      Navigator.pop(context);
      var snackbar = SnackBar(
        content: Text('loan deleted!'),
        backgroundColor: Colors.red,
      );
//      Scaffold.of(context).showSnackBar(snackbar);

    }
  }

  Widget details() {
    return ListView.builder(
        itemCount: names.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: <Widget>[
              ListTile(
                title: Text(names[index],style: TextStyle(
                  fontWeight: FontWeight.bold
                ), textAlign: TextAlign.justify,),
                subtitle: Text(loanValue[index].toString(),style: TextStyle(
                  color: Colors.teal,
                  fontSize: 17
                ),),
              ),
              Divider(),
            ],
          );
        });
  }
}
