import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reports/controller/data_model_controller.dart';

class DateInput extends StatefulWidget {
  final DataModelController dataModelController;
  final TextEditingController dateController;
  const DateInput({
    Key? key,
    required this.dataModelController,
    required this.dateController,
  }) : super(key: key);

  @override
  _DateInputState createState() => _DateInputState();
}

class _DateInputState extends State<DateInput> {
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
            widget.dateController.text = DateFormat('dd/MM/yyyy').format(date);
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.dateController,
      readOnly: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10)),
        label: const Text('Data'),
        prefixIcon: const Icon(Icons.date_range_outlined),
        suffixIcon: const Icon(Icons.arrow_drop_down),
      ),
      onTap: () => _selectDate(context),
      onSaved: (value) => widget.dataModelController.date = value!,
    );
  }
}
