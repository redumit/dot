import 'package:dot/helper/databaseHelper.dart';
import 'package:dot/model/materialModel.dart';
import 'package:dot/pages/material/materialAdd.dart';
import 'package:dot/pages/material/materialDetail.dart';
import 'package:dot/pages/material/materialEdit.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class MaterialList extends StatefulWidget {
  @override
  _MaterialListState createState() => _MaterialListState();
}

class _MaterialListState extends State<MaterialList> {

  DatabaseHelper helper = new DatabaseHelper();
  List<MaterialModel> materialList;
  int count = 0;
  @override
  Widget build(BuildContext context) {

    if (materialList == null) {
      materialList = List<MaterialModel>();
      updateListView();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Material Expense"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.refresh), onPressed: updateListView)
        ],
      ),
      body: ListView.builder(
          itemCount: count,
          itemBuilder: (BuildContext context, index) {
            return Column(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.computer),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(materialList[index].materialName),
                      Text(materialList[index].totalCost.toString()),
                    ],
                  ),
                  subtitle: Text(materialList[index].purchaseDate),
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MaterialDetail(materialList[index])));
                  },
                  trailing: CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: IconButton(icon: Icon(Icons.edit), onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MaterialEdit(materialList[index])));
                    }),
                  ),
                ),
                Divider()
              ],
            );
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        child: Icon(Icons.add),
        onPressed: () {
          debugPrint("Pressed");
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => MaterialAdd()));
        },
      ),
    );
  }

  void updateListView() {
    final Future<Database> dbfuture = helper.databaseIntiolize();
    dbfuture.then((database) {
      Future<List<MaterialModel>> materialListFuture = helper.materialToMapList();
      materialListFuture.then((materiallist) {
      setState(() {
      this.materialList = materiallist;
      this.count = materiallist.length;
      });
      });
    });
  }
}
