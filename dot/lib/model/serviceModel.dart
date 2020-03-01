class ServiceModel {
  int _id;

  String _serviceName;
  String _segment;
  double _laborCost;
  double _otherExpense;
  double _sellingPrice;
  int _hourWork;
  String _date;
  String _time;
  double _grossProfit;

  ServiceModel(
      this._id,
      this._serviceName,
      this._segment,
      this._laborCost,
      this._otherExpense,
      this._sellingPrice,
      this._hourWork,
      this._date,
      this._time,
      this._grossProfit);

  String get serviceName => _serviceName;
  double get grossProfit => _grossProfit;

  int get id => _id;

  set id(int value) {
    this._id = value;
  }

  set serviceName(String value) {
    this._serviceName = value;
  }

  set grossProfit(double value) {
    this._grossProfit = value;
  }

  String get segment => _segment;

  set segment(String value) {
    this._segment = value;
  }

  double get laborCost => _laborCost;

  set laborCost(double value) {
    this._laborCost = value;
  }

  double get otherExpense => _otherExpense;

  set otherExpense(double value) {
    this._otherExpense = value;
  }

  double get sellingPrice => _sellingPrice;

  set sellingPrice(double value) {
    this._sellingPrice = value;
  }

  int get hourWork => _hourWork;

  set hourWork(int value) {
    this._hourWork = value;
  }

  String get date => _date;

  set date(String value) {
    this._date = value;
  }

  String get time => _time;

  set time(String value) {
    this._time = value;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['id'] = _id;
    map['serviceName'] = _serviceName;
    map['segment'] = _segment;
    map['laborCost'] = _laborCost;
    map['otherExpense'] = _otherExpense;
    map['sellingPrice'] = _sellingPrice;
    map['hourWork'] = _hourWork;
    map['serviceDate'] = _date;
    map['time'] = _time;
    map['grossProfit'] = _grossProfit;
    return map;
  }

  ServiceModel.fromMapObject(Map<String, dynamic> map) {
    _id = map['id'];
    _serviceName = map['serviceName'];
    _segment = map['segment'];
    _laborCost = map['laborCost'];
    _otherExpense = map['otherExpense'];
    _sellingPrice = map['sellingPrice'];
    _hourWork = map['hourWork'];
    _date = map['serviceDate'];
    _time = map['time'];
    _grossProfit = map['grossProfit'];
  }
}
