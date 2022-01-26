import 'package:flutter/material.dart';
import 'package:reports/model/observations_model.dart';

class ListViewObservations extends StatelessWidget {
  List<ObservationsModel> listData = [];
  double primaryHeight;

  ListViewObservations({
    Key? key,
    required this.listData,
    required this.primaryHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.25,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: listData.length,
          itemBuilder: (ctx, index) {
            return Container(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(listData[index].description!),
                  Text(listData[index].value.toString()),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
