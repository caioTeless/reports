import 'package:flutter/material.dart';

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
      controller: widget.controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10)),
        label: Text(widget.textLabel),
        prefixIcon: Icon(widget.iconPrefix),
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
