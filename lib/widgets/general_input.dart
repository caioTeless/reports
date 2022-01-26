import 'package:flutter/material.dart';
import 'package:reports/helpers/validator_app.dart';

class GeneralInput extends StatefulWidget {
  final String textLabel;
  final void Function(String?) onSaved;
  final IconData iconPrefix;
  final bool? isNumber;
  final TextEditingController? controller;

  const GeneralInput({
    Key? key,
    required this.textLabel,
    required this.onSaved,
    required this.iconPrefix,
    this.isNumber,
    this.controller,
  }) : super(key: key);

  @override
  State<GeneralInput> createState() => _GeneralInputState();
}

class _GeneralInputState extends State<GeneralInput> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.isNumber == true
          ? ValidatorApp.doubleValidator
          : ValidatorApp.stringValidator,
      controller: widget.controller,
      decoration: InputDecoration(
        focusColor: Colors.grey,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.redAccent)),
        label: Text(widget.textLabel),
        labelStyle: const TextStyle(color: Colors.black),
        prefixIcon: Icon(widget.iconPrefix, color: Colors.grey),
        suffixIcon: widget.controller!.text.isNotEmpty
            ? IconButton(
                onPressed: () {
                  setState(() {});
                  widget.controller!.clear();
                },
                icon: const Icon(
                  Icons.clear,
                  color: Colors.grey,
                ))
            : null,
      ),
      onChanged: (value) {
        setState(() {});
      },
      keyboardType:
          widget.isNumber == true ? TextInputType.number : TextInputType.name,
      onSaved: widget.onSaved,
    );
  }
}
