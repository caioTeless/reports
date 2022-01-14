import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reports/controller/data_model_controller.dart';
import 'package:reports/data/firebase_data.dart';

class HomePage extends StatefulWidget {
  // final DatabaseReference ref =
  //     FirebaseDatabase.instance.ref().child('dataModelDB');

  HomePage({
    Key? key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  final _dateController = TextEditingController();
  final _dataModelController = DataModelController(FirebaseData());
  
  // final DatabaseReference newReference = FirebaseDatabase.instance.ref('dataModelDB/0/name'); get data
  // final DatabaseReference newReference = FirebaseDatabase.instance.ref('dataModelDB/0'); update data
  // final DatabaseReference newReference = FirebaseDatabase.instance.ref('dataModelDB/1'); remove data

  Future _selectDate(BuildContext context) async {
    await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2022),
            lastDate: DateTime(2030))
        .then(
      (date) {
        if (date != null) {
          setState(() {
            _dateController.text = DateFormat('dd/MM/yyyy').format(date);
          });
        }
      },
    );
    var teste = await _dataModelController.readAll(0.toString());
    print(teste);
    // await newReference.remove(); remote data
    // await newReference.update({'name': 'joao'}); update data
    // DatabaseEvent event = await newReference.once(); get data
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('teste'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _dateController,
              readOnly: true,
              decoration: const InputDecoration(
                label: Text('Date'),
              ),
              onTap: () => _selectDate(context),
              onSaved: (newDate) => _dataModelController.date = newDate!,
            ),
            TextFormField(
              decoration: const InputDecoration(
                label: Text('Name'),
              ),
              onSaved: (newName) => _dataModelController.name = newName!,
            ),
            TextFormField(
              decoration: const InputDecoration(
                label: Text('Value'),
              ),
              onSaved: (newValue) =>
                  _dataModelController.value = double.parse(newValue!),
            ),
            ElevatedButton(
              onPressed: save,
              child: const Text('Press'),
            ),
          ],
        ),
      ),
    );
  }

  Future save() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      await _dataModelController.setItems();
      // await widget.ref.set(_dataModelController.setNewMap());
    }
  }
}
