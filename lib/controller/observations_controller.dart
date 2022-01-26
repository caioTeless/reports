import 'package:reports/controller/data_model_controller.dart';
import 'package:reports/data/data_model_db.dart';
import 'package:reports/model/observations_model.dart';

class ObservationsController {
  final itemModel = ObservationsModel();
  final dataModelController = DataModelController(DataModelDB());

  List<ObservationsModel> listItems = [];

  int get length => listItems.isEmpty ? 0 : listItems.length;

  void setDescription(String? description) => itemModel.description = description;
  void setValue(String? value) => itemModel.value = double.parse(value!);

  void addListItems() {
    listItems.add(itemModel.getData(itemModel.toMap()));
  }

  double getTotalValue() {
    dynamic value; 
    if (listItems.isNotEmpty) {
      value = listItems
        .map((e) => e.value!)
        .reduce((value, element) => value + element);
    }
    return value ?? 0.0;
  }
}
