import 'package:flutter/material.dart';
import 'package:reports/controller/data_model_controller.dart';
import 'package:reports/data/data_model_db.dart';
import 'package:reports/helpers/app_bar.dart';
import 'package:reports/widgets/date_input.dart';
import 'package:reports/widgets/general_button.dart';
import 'package:reports/widgets/general_input.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  final _dataModelController = DataModelController(DataModelDB());
  final _dateController = TextEditingController();
  final textController = TextEditingController();
  final numberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: Center(     
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  DateInput(
                      dateController: _dateController,
                      dataModelController: _dataModelController),
                  const SizedBox(height: 10),
                  GeneralInput(
                    textLabel: 'Nome',
                    onSaved: _dataModelController.setName,
                    iconPrefix: Icons.description_outlined,
                    controller: textController,
                  ),
                  const SizedBox(height: 10),
                  GeneralInput(
                    textLabel: 'Valor',
                    onSaved: _dataModelController.setValue,
                    iconPrefix: Icons.attach_money_outlined,
                    isNumber: true,
                    controller: numberController,
                  ),
                  const SizedBox(height: 50),
                  GeneralButton(
                    onPressed: _saveData,
                    nameForButton: 'Enviar dados',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future _saveData() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      await _dataModelController.saveData();
      _formKey.currentState!.reset();
      _dateController.clear();
      textController.clear();
      numberController.clear();
    }
    setState(() {});
  }
}
