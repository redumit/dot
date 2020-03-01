import 'package:dot/helper/databaseHelper.dart';
import 'package:dot/model/loanModel.dart';
import 'package:dot/model/loanPaymentModel.dart';
import 'package:dot/pages/setting/addEmail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
class LoanPaymentEdit extends StatefulWidget {

  LoanPaymentModel loanpaymentEdit;
  LoanPaymentEdit(this.loanpaymentEdit);
  @override
  _LoanPaymentEditState createState() => _LoanPaymentEditState(this.loanpaymentEdit);
}

class _LoanPaymentEditState extends State<LoanPaymentEdit>{
  LoanPaymentModel loanpaymentEdit;
  _LoanPaymentEditState(this.loanpaymentEdit);
  DatabaseHelper dbhelp=DatabaseHelper();
  List<LoanModel> loans;
  List<String> _items ;
  String lenderName;
  bool _autoValidate = false;
  var formkey = GlobalKey<FormState>();

  //controllers
  final remainingAmountController = TextEditingController();
  final remainingInterestController = TextEditingController();
  final principalController = TextEditingController();
  final rateController = TextEditingController();
  final newPaymentController = TextEditingController();
  final descriptionController = TextEditingController();
  String _date = DateFormat.yMd().format(DateTime.now()).toString();

  double remain = 0;


  @override
  void initState() {
    newPaymentController.addListener(_calculateRemaining);
    lenderName=loanpaymentEdit.lender;
    _date=loanpaymentEdit.date;
    descriptionController.text=loanpaymentEdit.description;
    newPaymentController.text=loanpaymentEdit.amount.toString();

    if(loans == null){
      loans = List<LoanModel>();
      _loanLists();
    }

    super.initState();
  }

  _calculateRemaining(){

    try{
      remainingAmountController.text = (remain-double.parse(newPaymentController.text)).toString();
    }catch(e){
      debugPrint("Exception in _calculateRemaining"+e);
    }
  }

  Future<void> _loanLists(){
    final Future<Database> dbfuture = dbhelp.databaseIntiolize();
    dbfuture.then((database) {
      Future<List<LoanModel>> salaryListFuture = dbhelp.loanToMapList();
      salaryListFuture.then((salarylist) {
        setState(() {
          this.loans = salarylist;
          _items= List<String>();
          for(int i=0; i<loans.length; i++){
            setState(() {
              _items.add(loans[i].lender);
            });
          }
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    _loanDetail(lenderName);
    if(loans == null){
      loans = List<LoanModel>();
      _loanLists();
    }
    if(_items == null){
      _items= List<String>();
      for(int i=0; i<loans.length; i++){
        setState(() {
          _items.add(loans[i].lender);
        });
      }
    }

    debugPrint("length of lenderd "+_items.length.toString());
    return Scaffold(
      appBar: AppBar(
        title: Text("Add new loan payment"),
      ),
      body: _payLoan(context),
    );
  }

  Widget _payLoan(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20, left: 30),
      child: Form(
        key: formkey,
        autovalidate: _autoValidate,
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 30.0, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  DropdownButton(
                    icon: Icon(Icons.arrow_drop_down, color: Colors.blue[300]),

                    value: lenderName,
                    elevation: 16,
                    iconEnabledColor: Colors.green,
                    style: TextStyle(
                        wordSpacing: 5
                    ),
                    hint: Text('$lenderName'),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(right:10.0),
              child: TextFormField(
                controller: remainingAmountController,
                decoration:InputDecoration(
                    labelText: "Remaining Loan",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8))
                    )
                ),
                readOnly: true,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(right:10.0),
              child: TextFormField(
                controller: remainingInterestController,
                decoration:InputDecoration(
                    labelText: "Remaining Interest",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8))
                    )
                ),
                readOnly: true,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: TextFormField(
                      controller: principalController,
                      readOnly: true,
                      decoration:InputDecoration(
                          labelText: "Principal",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(8))
                          )
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 1,
                    child: TextFormField(
                      controller: rateController,
                      decoration:InputDecoration(
                          labelText: "Rate %",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(8))
                          )
                      ),
                      readOnly: true,

                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(right:10.0),
              child: TextFormField(
                controller: newPaymentController,
                decoration:InputDecoration(
                    labelText: "Amount to Pay Now",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8))
                    )
                ),
                keyboardType: TextInputType.numberWithOptions(signed: false, decimal: true),
                validator: (value){
                  if(value.isEmpty){
                    return "Amount is required";
                  }else if(double.parse(value) <=0){
                    return "Invalid amount";
                  }else{
                    return null;
                  }
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(right:10.0),
              child: TextFormField(
                controller: descriptionController,
                decoration:InputDecoration(
                    labelText: "Description",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8))
                    )
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(3),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Payment Date')),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.60,
                    margin: EdgeInsets.all(5),
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(width: 0.80),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('$_date'),
                        IconButton(
                          icon: Icon(Icons.date_range, color: Colors.blue),
                          onPressed: () {
                            var format = DateFormat.yMd();
                            showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1970),
                                lastDate: DateTime(2021))
                                .then((date) {
                              setState(() {
                                _date = format.format(date).toString();
                              });
                            });
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 30),
              child: Align(
                alignment: Alignment.topRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 10, right: 15),
                      child: OutlineButton(
                        borderSide: BorderSide(color: Colors.red),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        onPressed: () => Navigator.pop(context),
                        child: Row(
                          children: <Widget>[
                            Container(
                                padding: EdgeInsets.only(right: 8),
                                child:
                                Icon(Icons.cancel, color: Colors.red[200])),
                            Text(
                              'cancel',
                              style: TextStyle(color: Colors.red),
                            ),
                          ],
                        ),
                        color: Colors.red,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 15, right: 10),
                      child: OutlineButton(
                        onPressed: () {
                          _submit();
                        },
                        borderSide: BorderSide(color: Colors.green),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          children: <Widget>[
                            Container(
                                padding: EdgeInsets.only(right: 8),
                                child: Icon(Icons.update,
                                    color: Colors.green)),
                            Text(
                              'Update',
                              style: TextStyle(color: Colors.green),
                            ),
                          ],
                        ),
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _submit() async{
    var form = formkey.currentState;
    if(form.validate()){
      form.save();
      LoanPaymentModel modle = new LoanPaymentModel(
          loanpaymentEdit.id,
          lenderName,
          _date,
          double.parse(newPaymentController.text),
          descriptionController.text);
      var xx= await dbhelp.updateLoanPayment(modle);
      Navigator.pop(context);
    }else{
      setState(() {
        _autoValidate = true;
      });
    }
  }
  _loanDetail(String lender){
    for(int i=0; i<loans.length; i++){
      if(loans[i].lender == lender){
        setState(() {
        remainingAmountController.text = loans[i].remain.toString();
        remainingInterestController.text = loans[i].interestPaid.toString();
        principalController.text = loans[i].principal.toString();
        rateController.text = loans[i].interest.toString();

          remain = loans[i].remain;
        });
      }
    }
  }
}
