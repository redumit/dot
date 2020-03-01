import 'dart:io';

import 'package:dot/model/emailModel.dart';
import 'package:dot/model/loanModel.dart';
import 'package:dot/model/loanPaymentModel.dart';
import 'package:dot/model/materialModel.dart';
import 'package:dot/model/otherExpenseModel.dart';
import 'package:dot/model/productModel.dart';
import 'package:dot/model/salaryModel.dart';
import 'package:dot/model/serviceModel.dart';
import 'package:dot/model/usersModel.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper _instance;
  DatabaseHelper._createInstance();
  static Database _db;

  String userTable = "users";
  String loanTable = "loan";
  String salaryTable = "salary";
  String serviceTable = "service";
  String productTable = "product";
  String materialTable = "material";
  String otherExpTable = "otherExpense";
  String loanPaymentTable="loanPayment";
  String emailTable="emails";

  factory DatabaseHelper() {
    if (_instance == null) {
      _instance = DatabaseHelper._createInstance();
    }
    return _instance;
  }
  Future<Database> get database async {
    if (_db == null) {
      _db = await databaseIntiolize();
    }
    return _db;
  }

  Future<Database> databaseIntiolize() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + '/Dot.db';
    var pixelDb = await openDatabase(
      path,
      version: 1,
      onCreate: _createdb,
    );
    return pixelDb;
  }

  void _createdb(Database db, int version) async {
    await db.execute('CREATE TABLE '
        '$serviceTable( '
        'id INTEGER PRIMARY KEY AUTOINCREMENT ,'
        'serviceName TEXT, '
        'segment TEXT ,'
        'laborCost DOUBLE , '
        'hourWork INTEGER,'
        'sellingPrice DOUBLE , '
        'otherExpense DOUBLE,'
        'serviceDate TEXT ,'
        'time TEXT,'
        'grossProfit DOUBLE) ');
    await db.execute('CREATE TABLE $productTable( '
        'id INTEGER PRIMARY KEY AUTOINCREMENT ,'
        'itemName TEXT,'
        'quantity DOUBLE ,'
        'productCost DOUBLE , '
        'sellingPrice DOUBLE ,'
        'serviceDate TEXT ,'
        'totalPrice DOUBLE,'
        'totalCost DOUBLE,'
        'grossProfit DOUBLE,'
        'time TEXT) ');
    await db.execute('CREATE TABLE $otherExpTable( '
        'id INTEGER PRIMARY KEY AUTOINCREMENT ,'
        'expenseName TEXT,'
        'purchaseCost DOUBLE,'
        'serviceDate TEXT ,'
        'time TEXT) ');
    await db.execute('CREATE TABLE $materialTable('
        'id INTEGER PRIMARY KEY AUTOINCREMENT, '
        'materialName TEXT,'
        'quantity DOUBLE,'
        'purchaseCost DOUBLE,'
        'purchaseDate TEXT,'
        'totalCost DOUBLE,'
        'deprecationYear DOUBLE,'
        'deprecationCostPerYear DOUBLE,'
        'deprecationCostPerMonth DOUBLE,'
        'restValue DOUBLE)');
    await db.execute('CREATE TABLE $loanTable ('
        'id INTEGER PRIMARY KEY AUTOINCREMENT,'
        'lender TEXT,'
        'paymentDate TEXT,'
        'loanAmount DOUBLE,'
        'principal DOUBLE,'
        'interest DOUBLE,'
        'interestPaid DOUBLE,'
        'paymentPerMonth DOUBLE,'
        'remain DOUBLE)');
    await db.execute('CREATE TABLE $userTable('
        'id INTEGER PRIMARY KEY AUTOINCREMENT ,'
        'fullName TEXT,'
        'company TEXT,'
        'address TEXT,'
        'email TEXT,'
        'phone TEXT,'
        'password TEXT)');
    await db.execute('CREATE TABLE $salaryTable ('
        'id INTEGER PRIMARY KEY AUTOINCREMENT ,'
        'employeeName TEXT,'
        'totalDate int,'
        'ratePerDay DOUBLE,'
        'gender TEXT,'
        'position TEXT,'
        'date TEXT,'
        'totalPayment DOUBLE)');
    await db.execute('CREATE TABLE $loanPaymentTable ('
        'id INTEGER PRIMARY KEY AUTOINCREMENT ,'
        'lender TEXT,'
        'amount DOUBLE,'
        'date TEXT,'
        'description TEXT)');
    await db.execute('CREATE TABLE $emailTable(id INTEGER PRIMARY KEY AUTOINCREMENT,email TEXT)');
  }

// database operations
  //service Table
  Future<List<Map<String, dynamic>>> getService() async {
    Database db = await this.database;
    var result = await db.query(serviceTable); // using helper
    return result;
  }
  Future<List<Map<String, dynamic>>> getServiceByDate( String date1, String date2) async {
    Database db = await this.database;
    var result = await db.rawQuery("SELECT * FROM $serviceTable WHERE serviceDate BETWEEN $date1 AND $date2;");// using helper
    return result;
  }

  Future<int> insertService(ServiceModel service) async {
    Database db = await this.database;
    print("u insert "+ service.toMap().toString());
    var result = await db.insert(serviceTable, service.toMap()); // using helper
    return result;
  }

  Future<int> updateService(ServiceModel service) async {
    Database db = await this.database;
    var result = db.update(serviceTable, service.toMap(),
        where: 'id=?', whereArgs: [service.id]);
    return result;
  }

  Future<int> deleteService(int id) async {
    Database db = await this.database;
    var result = db.rawDelete('DELETE FROM $serviceTable where id=$id');
    return result;
  }

  Future<List<ServiceModel>> serviceToMapList() async {
    var service = await getService();
    int length = service.length;
    List<ServiceModel> serviceList = List<ServiceModel>();
    for (int i = 0; i < length; i++) {
      serviceList.add(ServiceModel.fromMapObject(service[i]));
    }
    debugPrint(serviceList.toString());
    return serviceList;
  }

  //product table
  Future<List<Map<String, dynamic>>> getProduct() async {
    Database db = await this.database;
    var result = await db.query(productTable); // using helper
    return result;
  }

  Future<int> insertProduct(ProductsModel product) async {
    Database db = await this.database;
    var result = await db.insert(productTable, product.toMap()); // using helper
    return result;
  }

  Future<int> updateProduct(ProductsModel product) async {
    Database db = await this.database;
    var result = db.update(productTable, product.toMap(),
        where: 'id=?', whereArgs: [product.id]);
    return result;
  }

  Future<int> deleteProduct(int id) async {
    Database db = await this.database;
    var result = db.rawDelete('DELETE FROM $productTable where id=$id');
    return result;
  }

  Future<List<ProductsModel>> productToMapList() async {
    var product = await getProduct();
    int length = product.length;
    List<ProductsModel> productList = List<ProductsModel>();
    for (int i = 0; i < length; i++) {
      productList.add(ProductsModel.fromMapObject(product[i]));
    }
    debugPrint(productList.toString());
    return productList;
  }

  //material table
  Future<List<Map<String, dynamic>>> getMaterial() async {
    Database db = await this.database;
    var result = await db.query(materialTable); // using helper
    return result;
  }

  Future<int> insertMaterial(MaterialModel material) async {
    Database db = await this.database;
    var result =
        await db.insert(materialTable, material.toMap()); // using helper
    return result;
  }

  Future<int> updateMaterial(MaterialModel material) async {
    Database db = await this.database;
    var result = db.update(materialTable, material.toMap(),
        where: 'id=?', whereArgs: [material.id]);
    return result;
  }

  Future<int> deleteMaterial(int id) async {
    Database db = await this.database;
    var result = db.rawDelete('DELETE FROM $materialTable where id=$id');
    return result;
  }

  Future<List<MaterialModel>> materialToMapList() async {
    var material = await getMaterial();
    int length = material.length;
    List<MaterialModel> materialList = List<MaterialModel>();
    for (int i = 0; i < length; i++) {
      materialList.add(MaterialModel.fromMapObject(material[i]));
    }
    debugPrint(materialList.toString());
    return materialList;
  }

  //otherExpTable
  Future<List<Map<String, dynamic>>> getOtherExpense() async {
    Database db = await this.database;
    var result = await db.query(otherExpTable); // using helper
    return result;
  }

  Future<int> insertOtherExpense(OtherExpenseModel otherExp) async {
    Database db = await this.database;
    var result =
        await db.insert(otherExpTable, otherExp.toMap()); // using helper
    return result;
  }

  Future<int> updateOtherExpense(OtherExpenseModel otherExpense) async {
    Database db = await this.database;
    var result = db.update(otherExpTable, otherExpense.toMap(),
        where: 'id=?', whereArgs: [otherExpense.id]);
    return result;
  }

  Future<int> deleteOtherExpense(int id) async {
    Database db = await this.database;
    var result = db.rawDelete('DELETE FROM $otherExpTable where id=$id');
    return result;
  }

  Future<List<OtherExpenseModel>> otherExpenseToMapList() async {
    var otherExpense = await getOtherExpense();
    int length = otherExpense.length;
    List<OtherExpenseModel> otherExpenseList = List<OtherExpenseModel>();
    for (int i = 0; i < length; i++) {
      otherExpenseList.add(OtherExpenseModel.fromMapObject(otherExpense[i]));
    }
    debugPrint(otherExpenseList.toString());
    return otherExpenseList;
  }

  //salary table
  Future<List<Map<String, dynamic>>> getSalary() async {
    Database db = await this.database;
    var result = await db.query(salaryTable); // using helper
    return result;
  }

  Future<int> insertSalary(SalaryModel salary) async {
    Database db = await this.database;
    var result = await db.insert(salaryTable, salary.toMap()); // using helper
    return result;
  }

  Future<int> updateSalary(SalaryModel salary) async {
    Database db = await this.database;
    var result = db.update(salaryTable, salary.toMap(),
        where: 'id=?', whereArgs: [salary.id]);
    return result;
  }

  Future<int> deleteSalary(int id) async {
    Database db = await this.database;
    var result = db.rawDelete('DELETE FROM $salaryTable where id=$id');
    return result;
  }

  Future<List<SalaryModel>> salaryToMapList() async {
    var salary = await getSalary();
    int length = salary.length;
    List<SalaryModel> salaryList = List<SalaryModel>();
    for (int i = 0; i < length; i++) {
      salaryList.add(SalaryModel.fromMapList(salary[i]));
    }
    debugPrint(salaryList.toString());
    return salaryList;
  }

  //loan table
  Future<List<Map<String, dynamic>>> getLoan() async {
    Database db = await this.database;
    var result = await db.query(loanTable); // using helper
    return result;
  }

  Future<int> insertLoan(LoanModel loan) async {
    Database db = await this.database;
    var result = await db.insert(loanTable, loan.toMap()); // using helper
    return result;
  }

  Future<int> updateLoan(LoanModel loan) async {
    Database db = await this.database;
    var result =
        db.update(loanTable, loan.toMap(), where: 'id=?', whereArgs: [loan.id]);
    return result;
  }

  Future<int> deleteLoan(int id) async {
    Database db = await this.database;
    var result = db.rawDelete('DELETE FROM $loanTable where id=$id');
    return result;
  }

  Future<List<LoanModel>> loanToMapList() async {
    var loan = await getLoan();
    int length = loan.length;
    List<LoanModel> loanList = List<LoanModel>();
    for (int i = 0; i < length; i++) {
      loanList.add(LoanModel.fromMapToList(loan[i]));
    }
    debugPrint(loanList.toString());
    return loanList;
  }

  //user table
  Future<List<Map<String, dynamic>>> getUser() async {
    Database db = await this.database;
    var result = await db.query(userTable); // using helper
    return result;
  }

  Future<int> insertUSer(UserModel user) async {
    Database db = await this.database;
    var result = await db.insert(userTable, user.toMap()); // using helper
    return result;
  }

  Future<int> updateUser(UserModel user) async {
    Database db = await this.database;
    var result =
        db.update(userTable, user.toMap(), where: 'email=?', whereArgs: [user.email]);
    return result;
  }

  Future<int> deleteUser(int id) async {
    Database db = await this.database;
    var result = db.rawDelete('DELETE FROM $userTable where id=$id');
    return result;
  }

  Future<List<UserModel>> userToMapList() async {
    var user = await getUser();
    int length = user.length;
    List<UserModel> userList = List<UserModel>();
    for (int i = 0; i < length; i++) {
      userList.add(UserModel.fromMapObject(user[i]));
    }
    debugPrint(userList.toString());
    return userList;
  }

  Future<int> userCheck( UserModel user) async{
    var db = await this.database;
    var result = await db.query(userTable, where: "email=?", whereArgs: [user.email]);
    if(result.length>0){
      return 1;
    }else{
      return null;
    }
  }
  Future<int> userLogin( UserModel user) async{
    var db = await this.database;
    var result = await db.query(userTable, where: "email=? and password=?", whereArgs: [user.email,user.password]);
    if(result.length>0){
      return 1;
    }else{
      return null;
    }
  }

  //Loan payment table

  Future<List<Map<String, dynamic>>> getLoanPayment() async {
    Database db = await this.database;
    var result = await db.query(loanPaymentTable); // using helper
    return result;
  }

  Future<int> insertLoanPayment(LoanPaymentModel loanPaymentModel) async {
    try{
      Database db = await this.database;
      debugPrint("the loan payment values ${loanPaymentModel.toMap().toString()}");// using helper
      var result = await db.insert(loanPaymentTable, loanPaymentModel.toMap());
      return result;
    }catch(e){
      debugPrint("Exception in insert loanPayment $e");
    }
  }

  Future<int> updateLoanPayment(LoanPaymentModel loanPaymentModel) async {
    Database db = await this.database;
    var result = db.update(loanPaymentTable, loanPaymentModel.toMap(),
        where: 'id=?', whereArgs: [loanPaymentModel.id]);
    return result;
  }

  Future<int> deleteLoanPayment(int id) async {
    Database db = await this.database;
    var result = db.rawDelete('DELETE FROM $loanPaymentTable where id=$id');
    return result;
  }

  Future<List<LoanPaymentModel>> loanPaymentToMapList() async {
    var loanPayment = await getLoanPayment();
    int length = loanPayment.length;
    List<LoanPaymentModel> loanPaymentList = List<LoanPaymentModel>();
    for (int i = 0; i < length; i++) {
      loanPaymentList.add(LoanPaymentModel.fromMapList(loanPayment[i]));
    }
    return loanPaymentList;
  }

  // Email Admin operations

  Future<List<Map<String, dynamic>>> getEmail() async {
    Database db = await this.database;
    var result = await db.query(emailTable); // using helper
    return result;
  }
  Future<List<EmailModel>> emailToMapList() async {
    var user = await getEmail();
    int length = user.length;
    List<EmailModel> userList = List<EmailModel>();
    for (int i = 0; i < length; i++) {
      userList.add(EmailModel.fromMapToList(user[i]));
    }
    return userList;}

  Future<int> insertEmail(EmailModel user) async {
    Database db = await this.database;
    var result = await db.insert(emailTable, user.toMap()); // using helper
    return result;
  }

  Future<int> updateEmail(EmailModel user) async {
    Database db = await this.database;
    var result =
    db.update(emailTable, user.toMap(), where: 'id=?', whereArgs: [user.id]);
    return result;
  }
}
