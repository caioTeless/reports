import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reports/controller/data_model_controller.dart';
import 'package:reports/helpers/validator_app.dart';

class DateInput extends StatefulWidget {
  final DataModelController dataModelController;
  final TextEditingController dateController;
  const DateInput({
    Key? key,
    required this.dataModelController,
    required this.dateController,
  }) : super(key: key);

  @override
  State<DateInput> createState() => _DateInputState();
}

class _DateInputState extends State<DateInput> {
  Future _selectDate(BuildContext context) async {
    await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2022),
        lastDate: DateTime(2030),
        cancelText: 'Cancelar',
        confirmText: 'Selecionar',
        builder: (context, child) {
          return Theme(
              data: ThemeData.light().copyWith(colorScheme: const ColorScheme.light(primary: Colors.red)),
              child: child!);
        }).then(
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
  void dispose() {
    widget.dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: ValidatorApp.stringValidator,
      controller: widget.dateController,
      readOnly: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Colors.black)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Colors.redAccent)),
        label: const Text('Data'),
        labelStyle: const TextStyle(color: Colors.black),
        prefixIcon: const Icon(Icons.date_range_outlined, color: Colors.grey),
        suffixIcon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
      ),
      onTap: () => _selectDate(context),
      onSaved: (value) => widget.dataModelController.date = value!,
    );
  }
}
