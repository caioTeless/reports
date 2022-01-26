import 'package:flutter/material.dart';

class GeneralButton extends StatelessWidget {
  final void Function() onPressed;
  final String nameForButton;
  const GeneralButton({
    Key? key,
    required this.onPressed,
    required this.nameForButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(nameForButton),
      style: ElevatedButton.styleFrom(
        primary: Colors.orange[200],
        onPrimary: Colors.black,
        elevation: 2,
      ),
    );
  }
}
