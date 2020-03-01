class ProductsModel {
  int _id;
  String _itemName;
  double _quantity;
  double _productCost;
  double _sellingPrice;
  String _serviceDate;
  String _time;
  double _totalPrice;
  double _totalCost;
  double _grossProfit;



  String get time => _time;

  set time(String value) {
    this._time = value;
  }

  ProductsModel(
    this._itemName,
    this._quantity,
    this._productCost,
    this._sellingPrice,
    this._serviceDate,
    this._time,
    this._totalPrice,
    this._totalCost,
    this._grossProfit,
  );
  ProductsModel.withId(
      this._id,
      this._itemName,
      this._quantity,
      this._productCost,
      this._sellingPrice,
      this._serviceDate,
      this._time,
      this._totalPrice,
      this._totalCost,
      this._grossProfit);

  String get itemName => _itemName;
  double get productCost => _productCost;
  String get serviceDate => _serviceDate;
  double get quantity => _quantity;
  double get sellingPrice => _sellingPrice;
  int get id => _id;
  double get totalPrice => _totalPrice;
  double get totalCost => _totalCost;
  double get grossProfit => _grossProfit;

  set id(int id) {
    this._id = id;
  }

  set itemName(String name) {
    this._itemName = name;
  }

  set quantity(double quantity) {
    this._quantity = quantity;
  }

  set serviceDate(String serviceDate) {
    this._serviceDate = serviceDate;
  }
  set productCost(double productCost) {
    this._productCost = productCost;
  }

  set sellingPrice(double sellingPrice) {
    this._sellingPrice = sellingPrice;
  }

  set totalPrice(double totalPrice) {
    this._totalPrice = totalPrice;
  }

  set totalCost(double totalCost) {
    this._totalCost = totalCost;
  }

  set grossProfit(double grossProfit) {
    this._grossProfit = grossProfit;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['id'] = _id;
    map['serviceDate'] = _serviceDate;
    map['productCost'] = _productCost;
    map['time'] = _time;
    map['quantity'] = _quantity;
    map['itemName'] = _itemName;
    map['sellingPrice'] = _sellingPrice;
    map['totalPrice'] = _totalPrice;
    map['totalCost'] = _totalCost;
    map['grossProfit'] = _grossProfit;
    return map;
  }

  ProductsModel.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._itemName = map['itemName'];
    this._productCost = map['productCost'];
    this._quantity = map['quantity'];
    this._serviceDate = map['serviceDate'];
    this._sellingPrice = map['sellingPrice'];
    this._time = map['time'];
    this._totalPrice = map['totalPrice'];
    this._totalCost = map['totalCost'];
    this._grossProfit = map['grossProfit'];
  }
}
