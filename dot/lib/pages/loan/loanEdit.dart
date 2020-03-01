import 'package:dot/helper/databaseHelper.dart';
import 'package:dot/model/loanModel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LoanEdit extends StatefulWidget {
  LoanEdit(this.loan);
  LoanModel loan ;
  @override
  _LoanEditState createState() => _LoanEditState(loan);
}

class _LoanEditState extends State<LoanEdit> {
  _LoanEditState(this.oldLoan);
  LoanModel oldLoan;
  final formkey = GlobalKey<FormState>();
  static bool _autoValidate = false;
  bool _isLoading = false;
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  final lenderController = TextEditingController();
  final amountController = TextEditingController();
  final principalController = TextEditingController();
  final interestController = TextEditingController();
  final interestPaidController = TextEditingController();
  String _serviceDate = DateFormat.yMd().format(DateTime.now());

  double remain,paymentPerMonth;

  @override
   initState() {
    lenderController.text = oldLoan.lender.toString();
    amountController.text = oldLoan.loanAmount.toString();
    principalController.text = oldLoan.principal.toString();
    interestController.text = oldLoan.interest.toString();
    interestPaidController.text = oldLoan.interestPaid.toString();
    _serviceDate = oldLoan.paymentDate.toString();
    paymentPerMonth = oldLoan.paymentPerMonth;
    remain = oldLoan.remain;
    super.initState();
    principalController.addListener(_calculations);
    interestPaidController.addListener(_calculations);
    interestController.addListener(_calculations);
    amountController.addListener(_calculations);
  }

  _calculations(){
    setState(() {
      interestPaidController.text = (double.parse(amountController.text)*double.parse(interestController.text)/100).toString();
      paymentPerMonth = double.parse(principalController.text)+double.parse(interestPaidController.text);
      remain = double.parse(amountController.text);
    });
  }

  onsave() async{
    final form = formkey.currentState;
    if (form.validate()) {
      print('saved');
      form.save();
      LoanModel loan = new LoanModel(oldLoan.id, lenderController.text, _serviceDate, double.parse(amountController.text), double.parse(principalController.text), double.parse(interestController.text), double.parse(interestPaidController.text), paymentPerMonth, remain);
      DatabaseHelper helper = DatabaseHelper();
      await helper.updateLoan(loan);
      Navigator.pop(context);
    }else {
      setState(() {
        _autoValidate = true;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Loan"),
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.topLeft,
          padding: EdgeInsets.only(top: 20, left: 20),
          child: Form(
            key: formkey,
            autovalidate: _autoValidate,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                Row(
                  children: <Widget>[
                    Card(
                        child: Container(
                          height: 150,
                          width: MediaQuery.of(context).size.width * 0.40,
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Monthly Payment = $paymentPerMonth",
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )),
                    Card(
                        child: Container(
                          height: 150,
                          width: MediaQuery.of(context).size.width * 0.40,
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Remaining loan = $remain",
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  alignment: Alignment.topLeft,
                  width: MediaQuery.of(context).size.width * 0.70,
                  child: TextFormField(
                    controller: lenderController,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Lender Name is required';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                          BorderSide(color: Colors.teal, width: 1.0)),
                      labelText: 'Lender',
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.70,
                  child: TextFormField(
                    controller: amountController,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Amount is requierd';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                          BorderSide(color: Colors.teal, width: 1.0)),
                      labelText: 'Amount',
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width * 0.35,
                      child: TextFormField(
                        controller: principalController,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'principal is requierd';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                              BorderSide(color: Colors.teal, width: 1.0)),
                          labelText: 'Principal',
                        ),
                      ),
                    ),
                    SizedBox(width: 20,),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.35,
                      child: TextFormField(
                        controller: interestController,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Interest is requierd';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                              BorderSide(color: Colors.teal, width: 1.0)),
                          labelText: 'Interest',
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.70,
                  child: TextFormField(
                    controller: interestPaidController,
                    readOnly: true,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Interest paid is requierd';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                          BorderSide(color: Colors.teal, width: 1.0)),
                      labelText: 'Interest Paid',
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(3),
                      child: Align(
                          alignment: Alignment.centerLeft, child: Text('Date')),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.65,
                      margin: EdgeInsets.all(5),
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(width: 0.80),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('$_serviceDate'),
                          IconButton(
                            icon: Icon(Icons.date_range, color: Colors.blue),
                            onPressed: () {
                              var format = DateFormat.yMd();
                              showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(200),
                                  lastDate: DateTime(2021))
                                  .then((date) {
                                setState(() {
                                  _serviceDate = format.format(date).toString();
                                });
                              });
                            },
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(
                              left: 10,
                              right: 15),
                          child: OutlineButton(
                            borderSide: BorderSide(color: Colors.red),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            onPressed: () => Navigator.pop(context),
                            child: Row(
                              children: <Widget>[
                                Container(
                                    padding: EdgeInsets.only(
                                        right: 8),
                                    child: Icon(Icons.cancel,
                                        color: Colors.red[200])),
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
                          padding: EdgeInsets.only(
                              left: 15,
                              right: 10),
                          child: OutlineButton(
                            borderSide: BorderSide(color: Colors.green),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            onPressed: onsave,
                            child: Row(
                              children: <Widget>[
                                Container(
                                    padding: EdgeInsets.only(
                                        right: 8),
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
        ),
      ),
    );
  }
}
