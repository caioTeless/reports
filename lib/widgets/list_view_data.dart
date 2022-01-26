import 'package:flutter/material.dart';
import 'package:reports/model/data_model.dart';

class ListViewData extends StatelessWidget {
  List<DataModel> listData = [];
  double primaryHeight;
  double secondaryHeight;
  ListViewData({
    Key? key,
    required this.listData,
    required this.primaryHeight,
    required this.secondaryHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.5,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: listData.length,
          itemBuilder: (ctx, index) {
            return Container(
              padding: const EdgeInsets.all(8),
              height: MediaQuery.of(ctx).size.height * 0.05,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(listData[index].date),
                  Text(listData[index].name),
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

                      // SingleChildScrollView(
                      //   child: Container(
                      //     height: MediaQuery.of(context).size.height * 0.25,
                      //     child: ListView.builder(
                      //       shrinkWrap: true,
                      //       itemCount: _obsController.length,
                      //       itemBuilder: (ctx, index) {
                      //         return getObservations(index);
                      //       },
                      //     ),
                      //   ),
                      // ),



  // Widget getObservations(int index) {
  //   return Container(
  //     padding: const EdgeInsets.all(8.0),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: [
  //         Text(_obsController.listItems[index].description.toString()),
  //         Text(_obsController.listItems[index].value.toString()),
  //       ],
  //     ),
  //   );
  // }