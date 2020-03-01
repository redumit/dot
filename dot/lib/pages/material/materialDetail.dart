import 'package:dot/helper/databaseHelper.dart';
import 'package:dot/model/materialModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MaterialDetail extends StatefulWidget {
  MaterialDetail(this.material);
  MaterialModel material;
  @override
  _MaterialDetailState createState() => _MaterialDetailState(this.material);
}

class _MaterialDetailState extends State<MaterialDetail> {
  _MaterialDetailState(this.material);
  MaterialModel material;

  List<String> names = [
    'Material Name',
    'Quantity',
    'Purchase Cost',
    'Purchase Date',
    'Total Cost',
    'Deprecation Year',
    'Deprecation cost per Year',
    'Deprecation cost per month',
    'Rest Value',
  ];
  List<dynamic> materialValue;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        allowFontScaling: true);
    materialValue = [
      material.materialName,
      material.quantity,
      material.purchaseCost,
      material.purchaseDate,
      material.totalCost,
      material.deprecationYear,
      material.deprecationCostPerYear,
      material.deprecationCostPerMonth,
      material.restValue,
    ];
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Material Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
                height: ScreenUtil()
                    .setWidth(MediaQuery.of(context).size.height * 0.7),
                child: details()),
            Align(
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(
                        left: ScreenUtil().setWidth(10),
                        right: ScreenUtil().setWidth(15)),
                    child: OutlineButton(
                      borderSide: BorderSide(color: Colors.red),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      onPressed: () => Navigator.pop(context),
                      child: Row(
                        children: <Widget>[
                          Container(
                              padding: EdgeInsets.only(
                                  right: ScreenUtil().setWidth(8)),
                              child: Icon(Icons.cancel, color: Colors.brown)),
                          Text(
                            'cancel',
                            style: TextStyle(color: Colors.brown),
                          ),
                        ],
                      ),
                      color: Colors.red,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        left: ScreenUtil().setWidth(15),
                        right: ScreenUtil().setWidth(10)),
                    child: OutlineButton(
                      borderSide: BorderSide(color: Colors.red),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      onPressed: () {
                        _delete(material.id);
                      }, //
                      child: Row(
                        children: <Widget>[
                          Container(
                              padding: EdgeInsets.only(
                                  right: ScreenUtil().setWidth(8)),
                              child: Icon(Icons.delete, color: Colors.red)),
                          Text(
                            'Delete',
                            style: TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _delete(int id) async {
    var db = DatabaseHelper();
    int x = await db.deleteMaterial(id);
    if (x == null) {
      var snackbar = SnackBar(
        content: Text('Not deleted!'),
        backgroundColor: Colors.grey,
      );
      Scaffold.of(context).showSnackBar(snackbar);
    } else {
      Navigator.pop(context);
      var snackbar = SnackBar(
        content: Text('material deleted!'),
        backgroundColor: Colors.red,
      );
//      Scaffold.of(context).showSnackBar(snackbar);

    }
  }

  Widget details() {
    return ListView.builder(
        itemCount: names.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: <Widget>[
              ListTile(
                title: Text(names[index]),
                trailing: Text(materialValue[index].toString()),
              ),
              Divider(),
            ],
          );
        });
  }
}
