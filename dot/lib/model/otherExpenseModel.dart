class OtherExpenseModel {
  int _id;
  String _expenseName;
  double _purchaseCost;
  String _serviceDate;
  String _time;

  OtherExpenseModel(
      this._expenseName, this._purchaseCost, this._serviceDate, this._time);
  OtherExpenseModel.withId(this._id, this._expenseName, this._purchaseCost,
      this._serviceDate, this._time);

  String get expenseName => _expenseName;
  double get purchaseCost => _purchaseCost;
  String get serviceDate => _serviceDate;
  String get time => _time;
  int get id => _id;

  set id(int id) {
    this._id = id;
  }

  set expenseName(String name) {
    this._expenseName = name;
  }

  set serviceDate(String serviceDate) {
    this._serviceDate = serviceDate;
  }

  set time(String time) {
    this._time = time;
  }

  set purchaseCost(double prodcuctcost) {
    this._purchaseCost = prodcuctcost;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['id'] = _id;
    map['expenseName'] = _expenseName;
    map['serviceDate'] = _serviceDate;
    map['purchaseCost'] = _purchaseCost;
    map['time'] = _time;

    return map;
  }

  OtherExpenseModel.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._expenseName = map['expenseName'];
    this._purchaseCost = map['purchaseCost'];
    this._serviceDate = map['serviceDate'];
    this._time = map['time'];
  }
}
