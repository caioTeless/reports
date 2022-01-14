import 'package:uuid/uuid.dart';

class DataModel {
  String? id;
  String date;
  String name;
  double value;

  DataModel({
    this.id,
    required this.date,
    required this.name,
    required this.value,
  });

  Map<String, dynamic> toMap() {
    var dataMap = {
      'date': date,
      'name': name,
      'value': value,
    };
    if (id != null || id == '') {
      dataMap['id'] = const Uuid().v1();
    }
    return dataMap;
  }

  factory DataModel.fromMap(Map<String, dynamic> dataMap) {
    return DataModel(
      id: dataMap['id'],
      date: dataMap['date'],
      name: dataMap['name'],
      value: dataMap['value'],
    );
  }


}
