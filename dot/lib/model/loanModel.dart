class LoanModel {
  int _id;
  String _lender;
  String _paymentDate;
  double _loanAmount;
  double _principal;
  double _interest;
  double _interestPaid;
  double _paymentPerMonth;
  double _remain;

  LoanModel(this._id,this._lender, this._paymentDate,this._loanAmount,
      this._principal, this._interest, this._interestPaid, this._paymentPerMonth,this._remain);
  double get remain => _remain;

  set remain(double value) {
    this._remain = value;
  }

  int get id => _id;

  set id(int value) {
    this._id = value;
  }

  String get lender => _lender;

  double get paymentPerMonth => _paymentPerMonth;

  set paymentPerMonth(double value) {
    this._paymentPerMonth = value;
  }

  double get interestPaid => _interestPaid;

  set interestPaid(double value) {
    this._interestPaid = value;
  }

  double get interest => _interest;

  set interest(double value) {
    this._interest = value;
  }

  double get principal => _principal;

  set principal(double value) {
    this._principal = value;
  }

  double get loanAmount => _loanAmount;

  set loanAmount(double value) {
    this._loanAmount = value;
  }

  String get paymentDate => _paymentDate;

  set paymentDate(String value) {
    this._paymentDate = value;
  }

  set lender(String value) {
    this._lender = value;
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['id'] = _id;
    map['lender'] = _lender;
    map['paymentDate'] = _paymentDate;
    map['loanAmount'] = _loanAmount;
    map['principal'] = _principal;
    map['interest'] = _interest;
    map['interestPaid'] = _interestPaid;
    map['paymentPerMonth'] = _paymentPerMonth;
    map['remain'] = _remain;
    return map;
  }

  LoanModel.fromMapToList(Map<String, dynamic> map) {
    this._id = map['id'];
    this._lender = map['lender'];
    this._paymentDate = map['paymentDate'];
    this._loanAmount = map['loanAmount'];
    this._principal = map['principal'];
    this._interest = map['interest'];
    this._interestPaid = map['interestPaid'];
    this._paymentPerMonth = map['paymentPerMonth'];
    this._remain = map['remain'];
  }
}
