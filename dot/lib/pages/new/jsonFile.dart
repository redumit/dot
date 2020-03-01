import 'dart:convert';
import 'dart:io';

import 'package:dot/helper/databaseHelper.dart';
import 'package:dot/model/loanModel.dart';
import 'package:dot/model/materialModel.dart';
import 'package:dot/model/otherExpenseModel.dart';
import 'package:dot/model/productModel.dart';
import 'package:dot/model/salaryModel.dart';
import 'package:dot/model/serviceModel.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqlite_api.dart';


class JsonFile extends StatefulWidget {
  @override
  _JsonFileState createState() => _JsonFileState();
}
  final scaffoldKey = new GlobalKey<ScaffoldState>();

class _JsonFileState extends State<JsonFile> {
  DatabaseHelper productDatabaseHelper=DatabaseHelper();
 List<ProductsModel> products;
 List<ServiceModel> services;
 List<OtherExpenseModel> others;
 List<MaterialModel> materials;
 List<SalaryModel> salarys;
 List<LoanModel> loans;
 int count=0;
void updatelistProducts(){
      final Future<Database> prodb=productDatabaseHelper.databaseIntiolize();
      prodb.then((database){
        Future<List<ProductsModel>> proLists=productDatabaseHelper.productToMapList();
        proLists.then((lists){
         
          setState(() {
            this.products=lists;
            this.count=lists.length;
            
          });
        });
      });
     
      
    }
void updatelistServices(){
      final Future<Database> prodb=productDatabaseHelper.databaseIntiolize();
      prodb.then((database){
        Future<List<ServiceModel>> proLists=productDatabaseHelper.serviceToMapList();
        proLists.then((lists){

          setState(() {
            this.services=lists;
            this.count=lists.length;

          });
        });
      });


    }
void updatelistOthers(){
      final Future<Database> prodb=productDatabaseHelper.databaseIntiolize();
      prodb.then((database){
        Future<List<OtherExpenseModel>> proLists=productDatabaseHelper.otherExpenseToMapList();
        proLists.then((lists){

          setState(() {
            this.others=lists;
            this.count=lists.length;

          });
        });
      });


    }
void updatelistMaterials(){
      final Future<Database> prodb=productDatabaseHelper.databaseIntiolize();
      prodb.then((database){
        Future<List<MaterialModel>> proLists=productDatabaseHelper.materialToMapList();
        proLists.then((lists){

          setState(() {
            this.materials=lists;
            this.count=lists.length;

          });
        });
      });


    }
void updatelistSalarys(){
      final Future<Database> prodb=productDatabaseHelper.databaseIntiolize();
      prodb.then((database){
        Future<List<SalaryModel>> proLists=productDatabaseHelper.salaryToMapList();
        proLists.then((lists){

          setState(() {
            this.salarys=lists;
            this.count=lists.length;

          });
        });
      });


    }
void updatelistLoans(){
      final Future<Database> prodb=productDatabaseHelper.databaseIntiolize();
      prodb.then((database){
        Future<List<LoanModel>> proLists=productDatabaseHelper.loanToMapList();
        proLists.then((lists){

          setState(() {
            this.loans=lists;
          });
        });
      });


    }

    double totalServiceGrossProfit=0;
    double totalProductGrossProfit=0;
    double totalExpense=0;
    double interestExpense=0;
    double otherExpense=0;
    double salaryExpense=0;
    double totalPurchaseCost=0;
    double totalGrossProfit=0;
    double totalIncome=0;
    double totalDepracationCost=0;


 var totalList;
 @override
  void initState() {
    super.initState();
  }
  String message="";
  @override
  Widget build(BuildContext context) {
     if(products==null){
       products=List<ProductsModel>();
       updatelistProducts();
     }
     if(services==null){
       services=List<ServiceModel>();
       updatelistServices();
     }
     if(others==null){
       others=List<OtherExpenseModel>();
       updatelistOthers();
     }
     if(materials==null){
       materials=List<MaterialModel>();
       updatelistMaterials();
     }
     if(salarys==null){
       salarys=List<SalaryModel>();
       updatelistSalarys();
     }
     if(loans==null){
       loans=List<LoanModel>();
       updatelistLoans();
     }

     for(int i=0; i<services.length; i++){
       setState(() {
         totalServiceGrossProfit += services[i].grossProfit;
       });
     }
     for(int i=0; i<products.length; i++){
       setState(() {
         totalProductGrossProfit += products[i].grossProfit;
       });
     }
     for(int i=0; i<salarys.length; i++){
       setState(() {
         salaryExpense += salarys[i].totalPayment;
       });
     }
     for(int i=0; i<materials.length; i++){
        setState(() {
          totalPurchaseCost+= materials[i].purchaseCost;
          totalDepracationCost+=materials[i].deprecationCostPerMonth;
        });
     }

     setState(() {
       totalExpense = totalPurchaseCost+salaryExpense+interestExpense;
       totalIncome = totalServiceGrossProfit+totalProductGrossProfit;
       totalGrossProfit = totalIncome-totalExpense;
     });



     List<double> _valueCalculator(String value, double cost){
       List<double>  values;
       switch(value){
         case "rent":
           values = [
             cost,
             0,
             0,
             0,
             0
           ];
           break;
         case "supply&utility":
           values = [
             0,
             cost,
             0,
             0,
             0
           ];
           break;
         case "advertise cost":
           values = [
             0,
             0,
             cost,
             0,
             0
           ];
           break;
         case "payable":
           values = [
             0,
             0,
             0,
             cost,
             0
           ];
           break;
         case "other":
           values = [
             0,
             0,
             0,
             0,
             cost,
           ];
           break;
       }

       return values;
     }
totalList= {
    "gross_profit": totalGrossProfit,
    "total_expense": totalExpense,
    "service_revenue": totalServiceGrossProfit,
    "product_revenue": totalProductGrossProfit,
    "deprecation_cost": totalDepracationCost,
    "product": [
      for (int i = 0; i < products.length; i++)
        {
            "product_name": products[i].itemName,
            "selling_price":products[i].sellingPrice,
            "product_qty":products[i].quantity,
            "product_cost": products[i].productCost,
            "total_cost": products[i].totalCost,
            "total_price":products[i].totalPrice,
            "gross_profit":products[i].grossProfit,
            "date":products[i].serviceDate
        },
    ],
    "service": [
      for (int i = 0; i < services.length; i++)
          {
            "service_name": services[i].serviceName,
            "customer_segment": services[i].segment,
            "labor_cost": services[i].laborCost,
            "other_cost": services[i].otherExpense,
            "selling_price": services[i].sellingPrice,
            "hours_of_work": services[i].hourWork,
            "gross_profit": services[i].grossProfit,
            "date":services[i].date
          },
    ],
    "material": [
      for (int i = 0; i < materials.length; i++)
          {
            "material_name": materials[i].materialName,
            "material_type":materials[i].materialName,
            "material_cost": materials[i].purchaseCost,
            "quantity": materials[i].quantity,
            "total_cost": materials[i].totalCost,
          },
    ],
    "loan": [
      for (int i = 0; i < loans.length; i++)
          {
            "lender": loans[i].lender,
            "interest_paid": loans[i].interestPaid,
            "monthly_payment": loans[i].paymentPerMonth,
            "remaining_loan": loans[i].remain,
            "loan_amount": loans[i].loanAmount,
            "date_of_payment": loans[i].paymentDate,
          },
    ],
     "expense": [
      for (int i = 0; i < others.length; i++)
        
          {

            "rent": _valueCalculator(others[i].expenseName, others[i].purchaseCost)[0],
            "supply&utility": _valueCalculator(others[i].expenseName, others[i].purchaseCost)[1],
            "advertise_cost": _valueCalculator(others[i].expenseName, others[i].purchaseCost)[2],
            "payable": _valueCalculator(others[i].expenseName, others[i].purchaseCost)[3],
            "other": _valueCalculator(others[i].expenseName, others[i].purchaseCost)[4],
            "total_expense": others[i].purchaseCost
          },


        
    ],

  };

   
    print(totalList.toString());
    //print(products.toList().toString());
   // print(totalList.toString());
    return Scaffold(
        appBar: AppBar(
          title: Text('generate Json'),
        ),

        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Text("$message"),
              ),
              Center(
                child: Card(

                  child: Container(
                    height: 80,
                    child: RaisedButton(onPressed: generateCSV,
                    child: Text('Press To generate json file'),),
                  ),
                ),
              ),

            ],
          ),
        ),

     );
  }
  generateCSV() async {
debugPrint('start');
  try {

final  String dir =(await getExternalStorageDirectory()).path;
    final String path='$dir/report.json';
     File f =  File(path);
     f.createSync();
     print(f);
     print(dir.toString());
 String csv = json.encode(totalList);
     await f.writeAsStringSync(csv);
     if(f.existsSync()){
       print("file exist");
     }else{
       print("file Note exist");
     }
     print('values gone on ${f.absolute.path}');
      print('the lists comming');
      setState(() {
        message ="The File is Generated to path \n Internal storage/android/data/com.example.dot/files/report.json";
      });
      print(csv.toString());

    
  } catch (e) {

    debugPrint(e.toString());
  }
//    
    
//     }
  }
  
}
