import 'package:reports/data/data_model_db.dart';
import 'package:reports/model/data_model.dart';

class DataModelController {
  final DataModelDB _dataModelDb;

  DataModelController(this._dataModelDb);

  int? id;
  String date = '';
  String name = '';
  double value = 0.0;
  bool loading = false;
  String deposit = '';
  List<DataModel> items = [];


  int get length => items.isEmpty ? 0 : items.length;

  void setDate(String newDate) => date = newDate;
  void setName(String? newName) => name = newName!;
  void setValue(String? newValue) => value = double.parse(newValue!);

  Future readAll() async {
    loading = true;
    items = await _dataModelDb.readAll();
    loading = false;
  }

  Future saveData() async {
    final data = DataModel(
      id: id,
      date: date,
      name: name,
      value: value,
    );
    if (id == null) {
      await _dataModelDb.insert(data);
    } else {
      await _dataModelDb.update(data);
    }
  }

  Future removeData(DataModel dataModel) async {
    loading = true;
    await _dataModelDb.delete(dataModel);
    loading = false;
  }

  Future removeAll() async {
    loading = true;
    await _dataModelDb.deleteAll();
    loading = false;
  }

  double getSumList() {
    double sum = 0.0;
    if (items.isNotEmpty) {
      loading = true;
      sum = items
          .map((e) => e.value)
          .reduce((value, element) => value + element);
      sum > 0 ? sum : 0;
      loading = false;
    }
    return sum;
  }
}
