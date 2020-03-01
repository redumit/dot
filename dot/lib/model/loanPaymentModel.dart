class LoanPaymentModel{
  int _id;
  String _lender;
  String _date;
  double _amount;
  String _description;

  LoanPaymentModel(this._id, this._lender, this._date, this._amount,
      this._description);

  String get description => _description;

  set description(String value) {
    _description = value;
  }

  double get amount => _amount;

  set amount(double value) {
    _amount = value;
  }

  String get date => _date;

  set date(String value) {
    _date = value;
  }

  String get lender => _lender;

  set lender(String value) {
    _lender = value;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }

Map<String,dynamic> toMap(){
    var map=Map<String,dynamic>();
    map['id']=this._id;
    map['lender']=this._lender;
    map['amount']=this._amount;
    map['date']=this._date;
    map['description']=this.description;
    return map;
  }

  LoanPaymentModel.fromMapList(Map<String,dynamic> map){
    this._id = map['id'];
    this._lender = map['lender'];
    this._amount = map['amount'];
    this._date =map['date'];
    this._description =map['description'];
  }

}