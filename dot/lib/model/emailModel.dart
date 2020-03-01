class EmailModel{

  int _id;
  String _email;
  EmailModel( this._email);

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['id'] = _id;
    map['email'] = _email;

    return map;
  }

  EmailModel.fromMapToList(Map<String, dynamic> map) {
    this._id = map['id'];
    this._email = map['email'];

  }

}