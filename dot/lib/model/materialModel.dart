
class MaterialModel {
  int _id;
  String _materialName;
  double _quantity;
  double _purchaseCost;
  String _purchaseDate;
  double _totalCost;
  double _deprecationYear;
  double _deprecationCostPerYear;
  double _deprecationCostPerMonth;
  double _restValue;

  

  double get deprecationCostPerYear => _deprecationCostPerYear;

  set deprecationCostPerYear(double value) {
    this._deprecationCostPerYear = value;
  }

  MaterialModel(
    this._materialName,
    this._quantity,
    this._purchaseCost,
    this._purchaseDate,
    this._totalCost,
    this._deprecationYear,
    this._deprecationCostPerYear,
    this._deprecationCostPerMonth,
    this._restValue,
  );
  MaterialModel.withId(
    this._id,
    this._materialName,
    this._quantity,
    this._purchaseCost,
    this._purchaseDate,
    this._totalCost,
    this._deprecationYear,
    this._deprecationCostPerYear,
    this._deprecationCostPerMonth,
    this._restValue,
  );

  String get materialName => _materialName;
  double get purchaseCost => _purchaseCost;
  String get purchaseDate => _purchaseDate;
  double get quantity => _quantity;
  double get totalCost => _totalCost;
  double get deprecationYear => _deprecationYear;
  double get deprecationPerYear => _deprecationCostPerYear;
  double get deprecationPerMonth => _deprecationCostPerMonth;

  int get id => _id;

  set id(int id) {
    this._id = id;
  }

  set materialName(String name) {
    this._materialName = name;
  }

  set purchaseDate(String purchaseDate) {
    this._purchaseDate = purchaseDate;
  }

  set purchaseCost(double purchaseCost) {
    this._purchaseCost = purchaseCost;
  }

  double get deprecationCostPerMonth => _deprecationCostPerMonth;

  double get restValue => _restValue;

  set restValue(double restValue) {
    this._restValue = restValue;
  }

  set deprecationCostPerMonth(double value) {
    this._deprecationCostPerMonth = value;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['id'] = _id;
    map['materialName'] = _materialName;
    map['purchaseDate'] = _purchaseDate;
    map['purchaseCost'] = _purchaseCost;
    map['quantity'] = _quantity;
    map['totalCost'] = _totalCost;
    map['deprecationYear'] = _deprecationYear;
    map['deprecationCostPerYear'] = _deprecationCostPerYear;
    map['deprecationCostPerMonth'] = _deprecationCostPerMonth;

    return map;
  }

  MaterialModel.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._materialName = map['materialName'];
    this._purchaseCost = map['purchaseCost'];
    this._purchaseDate = map['purchaseDate'];
    this._quantity = map['quantity'];
    this._totalCost = map['totalCost'];
    this._deprecationYear = map['deprecationYear'];
    this._deprecationCostPerYear = map['deprecationCostPerYear'];
    this._deprecationCostPerMonth = map['deprecationCostPerMonth'];
  }

}


