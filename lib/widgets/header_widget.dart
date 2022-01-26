import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  
  List<String> textHeader = [];

  HeaderWidget(this.textHeader, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        for (int i = 0; i < textHeader.length; i++) Text(textHeader[i], style: const TextStyle(fontSize: 16)),
      ],
    );
  }
}
