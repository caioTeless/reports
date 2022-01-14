import 'dart:math';

import 'package:reports/data/firebase_data.dart';
import 'package:reports/model/data_model.dart';

class DataModelController {

  final FirebaseData firebaseData;

  DataModelController(this.firebaseData);

  String id = '';
  String date = '';
  String name = '';
  double value = 0.0;

  List<dynamic> items = [];

  int get length => items.isEmpty ? 0 : items.length;

  void setDate(String newDate) => date = newDate;
  void setName(String newName) => name = newName;
  void setValue(String newValue) => value = double.parse(newValue);

  Future setItems() async {
    var newModel = DataModel(
      id: id,
      date: date,
      name: name,
      value: value,
    );
    items.add(newModel.toMap()); 
    await firebaseData.insertDb(items);
  }

  Future readAll(String index) async{
    firebaseData.reference.child('dataModelDB').child(index);
    await firebaseData.readData();
  }

  Future remove(String index) async{
    firebaseData.createInstance('dataModelDB/$index');
  }

  Future update(DataModel dataModel) async{
    firebaseData.update(dataModel.toMap());
  }
}
