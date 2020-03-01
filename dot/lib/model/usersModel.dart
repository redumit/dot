class UserModel {
  int _id;
  String _fullName;
  String _company;
  String _address;
  String _email;
  String _phone;
  String _password;

  set id(int value) {
    this._id = value;
  }

  UserModel(
      this._id,
    this._fullName,
    this._company,
    this._address,
    this._email,
    this._phone,
    this._password,
  );

  int get id => _id;
  String get fullName => _fullName;

  String get company => _company;

  String get address => _address;

  String get email => _email;

  String get phone => _phone;

  String get password => _password;

  set fullName(String value) {
    if (value.length >= 3) {
      this._fullName = value;
    }
  }

  set password(String value) {
    this._password = value;
  }

  set phone(String value) {
    this._phone = value;
  }

  set email(String value) {
    this._email = value;
  }

  set address(String value) {
    this._address = value;
  }

  set company(String value) {
    this._company = value;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if(id != null){
      map["id"] = _id;
    }
    map["fullName"] = _fullName;
    map["company"] = _company;
    map["address"] = _address;
    map["email"] = _email;
    map["phone"] = _phone;
    map["password"] = _password;

    return map;
  }

  UserModel.fromMapObject(Map<String, dynamic> map) {
    _id = map["id"];
    _fullName = map["fullName"];
    _company = map["company"];
    _address = map["address"];
    _email = map["email"];
    _phone = map["email"];
    _password = map["password"];
  }
}
