class SalaryModel {
  int id;
  String employeeName;
  int totalDate;
  double ratePerDay;
  String gender;
  String position;
  String date;
  double totalPayment;

  SalaryModel(this.id, this.employeeName, this.totalDate, this.ratePerDay,
      this.gender, this.position, this.date, this.totalPayment);

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (id != null) {
      map['id'] = id;
    }
    map['employeeName'] = employeeName;
    map['totalDate'] = totalDate;
    map['ratePerDay'] = ratePerDay;
    map['gender'] = gender;
    map['position'] = position;
    map['date'] = date;
    map['totalPayment'] = totalPayment;

    return map;
  }

  SalaryModel.fromMapList(Map<String, dynamic> map) {
    id = map['id'];
    employeeName = map['employeeName'];
    totalDate = map['totalDate'];
    ratePerDay = map['ratePerDay'];
    gender = map['gender'];
    position = map['position'];
    date = map['date'];
    totalPayment = map['totalPayment'];
  }
}
