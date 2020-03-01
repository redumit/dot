import 'dart:io';

import 'package:csv/csv.dart';
import 'package:dot/model/serviceModel.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class GenerateCSV extends StatefulWidget {
  @override
  _GenerateCSVState createState() => _GenerateCSVState();
}

class _GenerateCSVState extends State<GenerateCSV> {
  List<ServiceModel> associateList = new List<ServiceModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CSV Generator"),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: getCSV,
          child: Text("Generate"),
        ),
      ),
    );
  }

  void getCSV() async {
    //create an element rows of type list of list. All the above data set are stored in associate list
    //Let associate be a model class with attributes name,gender and age and associateList be a list of associate model class.

    try {
      for (int i = 0; i < 5; i++) {
        ServiceModel sm = new ServiceModel(0, "Generator", "HW", 20.0, 10.0, 40.0, 4, "12/4/2020", "2:30",23);

        associateList.add(sm);
      }
    } catch (e) {
      print("Exception in list " + e);
    }

    List<List<dynamic>> rows = List<List<dynamic>>();
    for (int i = 0; i < associateList.length; i++) {
//row refer to each column of a row in csv file and rows refer to each row in a file
      List<dynamic> row = List();
      row.add(associateList[i].serviceName);
      row.add(associateList[i].segment);
      row.add(associateList[i].laborCost);
      row.add(associateList[i].otherExpense);
      row.add(associateList[i].sellingPrice);
      row.add(associateList[i].hourWork);
      row.add(associateList[i].date);
      row.add(associateList[i].time);
      rows.add(row);
    }

//store file in documents folder
    final dir = (await getApplicationDocumentsDirectory()).absolute;

    var file = dir.path;
    print(" FILE " + file);
    File f = new File(file + "/filename.csv");
    print(f);

// convert rows to String and write as csv file

    String csv = const ListToCsvConverter().convert(rows);
    f.writeAsString(csv);
  }
}
