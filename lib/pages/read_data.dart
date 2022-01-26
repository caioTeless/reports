import 'package:flutter/material.dart';
import 'package:reports/controller/data_model_controller.dart';
import 'package:reports/controller/observations_controller.dart';
import 'package:reports/data/data_model_db.dart';

import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pdf;
import 'package:reports/helpers/app_bar.dart';
import 'package:reports/helpers/date_helper.dart';
import 'package:reports/widgets/general_button.dart';
import 'package:reports/widgets/header_widget.dart';
import 'package:reports/widgets/list_view_data.dart';
import 'package:reports/widgets/list_view_observations.dart';

class ReadDataPage extends StatefulWidget {
  const ReadDataPage({Key? key}) : super(key: key);

  @override
  _ReadDataPageState createState() => _ReadDataPageState();
}

class _ReadDataPageState extends State<ReadDataPage> {
  final _dataController = DataModelController(DataModelDB());
  final _textController = TextEditingController();
  final _obsController = ObservationsController();
  final _depositFormKey = GlobalKey<FormState>();
  final myPdf = pdf.Document();
  String deposit = '';

  @override
  void initState() {
    _getData();
    super.initState();
  }

  Future _getData() async {
    await _dataController.readAll();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (_dataController.items.isNotEmpty) {
      return Scaffold(
        appBar: appBar,
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                HeaderWidget(const ['Data', 'Item', 'Valor']),
                const Divider(),
                ListViewData(
                  listData: _dataController.items,
                  primaryHeight: 0.5,
                  secondaryHeight: 0.05,
                ),
                if (_obsController.length > 0)
                  Column(
                    children: [
                      const Divider(),
                      const Text(
                        'Observações',
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      HeaderWidget(const ['Descrição', 'Valor']),
                      const Divider(),
                      ListViewObservations(
                          listData: _obsController.listItems,
                          primaryHeight: 0.25),
                      const Divider(),
                    ],
                  ),
                const SizedBox(
                  height: 10,
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      HeaderWidget(const ['Depósito', 'Valor total']),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () => _showDialog(),
                            child: Text(
                              _dataController.deposit.isEmpty
                                  ? 'Valor'
                                  : _dataController.deposit,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          _dataController.loading
                              ? const CircularProgressIndicator()
                              : Text(getValueScreen()),
                        ],
                      ),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GeneralButton(
                              onPressed: () => _dataController.loading
                                  ? const CircularProgressIndicator()
                                  : deleteAll(),
                              nameForButton: 'Apagar'),
                          GeneralButton(
                              onPressed: () => _showDialogObservations(),
                              nameForButton: 'Observações'),
                          GeneralButton(
                              onPressed: () => savePdf(), nameForButton: 'PDF'),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else if (_dataController.loading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return const Center(
        child: Text('Não há itens'),
      );
    }
  }

  // Deposit
  Future _showDialog() async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Mudar depósito'),
          content: SingleChildScrollView(
            child: TextFormField(
              key: _depositFormKey,
              controller: _textController,
              decoration: const InputDecoration(
                label: Text('Novo'),
              ),
              keyboardType: TextInputType.number,
              onSaved: (value) => _textController.text = value!,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                _depositFormKey.currentState?.save();
                setState(() {
                  _dataController.deposit = _textController.text;
                });

                Navigator.of(context).pop();
              },
              child: const Text('Enviar'),
            ),
          ],
        );
      },
    );
  }

  Future _showDialogObservations() async {
    setState(() {});
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Observações'),
          content: SingleChildScrollView(
            child: Form(
              key: _depositFormKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      label: Text('Descrição'),
                    ),
                    onSaved: _obsController.setDescription,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      label: Text('Valor'),
                    ),
                    keyboardType: TextInputType.number,
                    onSaved: _obsController.setValue,
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (_depositFormKey.currentState!.validate()) {
                  _depositFormKey.currentState!.save();
                  _obsController.addListItems();
                  setState(() {});
                }
                Navigator.of(context).pop();
              },
              child: const Text('Ok'),
            ),
          ],
        );
      },
    );
  }

  String getValueScreen() {
    return (_dataController.getSumList() + _obsController.getTotalValue())
        .toString();
  }

  String getValuePdf() {
    var fromText =
        int.parse(_textController.text.isEmpty ? '0' : _textController.text);
    double sum;
    sum = (fromText -
            (_dataController.getSumList() + _obsController.getTotalValue()))
        .abs();

    return sum.toString();
  }

  String getTest() {
    var fromText =
        int.parse(_textController.text.isEmpty ? '0' : _textController.text);
    double test = double.parse(getValuePdf());
    String condition = '';
    if (test > fromText && fromText != 0) {
      setState(() {
        condition = 'Adicionado';
      });
    } else if (test < fromText) {
      setState(() {
        condition = 'Sobrou';
      });
    } else {
      setState(() {
        condition = 'Saldo';
      });
    }
    return condition;
  }

  Future deleteAll() async {
    _dataController.removeAll();
    _getData();
  }

  Future savePdf() async {
    final appDocDir =
        await getExternalStorageDirectories(type: StorageDirectory.downloads);
    myPdf.addPage(
      pdf.Page(
          pageFormat: PdfPageFormat.a4,
          margin: const pdf.EdgeInsets.all(50),
          build: (pdf.Context context) {
            return pdf.Container(
                padding: const pdf.EdgeInsets.all(20),
                child: pdf.Column(children: [
                  pdf.Center(
                    child: pdf.Row(
                      mainAxisAlignment: pdf.MainAxisAlignment.spaceEvenly,
                      children: [
                        pdf.Text(
                            DateHelper.getDate(
                                _dataController.items.map((e) => e.date).first),
                            style: const pdf.TextStyle(fontSize: 22)),
                        pdf.Text('Depósito - R\$ ${_textController.text}',
                            style: const pdf.TextStyle(fontSize: 22)),
                      ],
                    ),
                  ),
                  pdf.SizedBox(height: 12),
                  pdf.Center(
                    child: pdf.Row(
                      mainAxisAlignment: pdf.MainAxisAlignment.spaceBetween,
                      children: [
                        pdf.Text('Data',
                            style: const pdf.TextStyle(fontSize: 16)),
                        pdf.Text('Item',
                            style: const pdf.TextStyle(fontSize: 16)),
                        pdf.Text('Valor',
                            style: const pdf.TextStyle(fontSize: 16)),
                      ],
                    ),
                  ),
                  pdf.Divider(),
                  pdf.ListView.builder(
                      itemCount: _dataController.length,
                      itemBuilder: (ctx, index) {
                        return pdf.Row(
                            mainAxisAlignment:
                                pdf.MainAxisAlignment.spaceBetween,
                            children: [
                              pdf.Text(_dataController.items[index].date,
                                  style: const pdf.TextStyle(fontSize: 12),
                                  textScaleFactor: 1.2),
                              pdf.Text(_dataController.items[index].name,
                                  style: const pdf.TextStyle(fontSize: 12),
                                  textScaleFactor: 1.2),
                              pdf.Text(
                                  _dataController.items[index].value.toString(),
                                  style: const pdf.TextStyle(fontSize: 12),
                                  textScaleFactor: 1.2),
                            ]);
                      }),
                  pdf.Divider(),
                  if (_obsController.length > 0)
                    pdf.Column(children: [
                      pdf.Text('Observações',
                          textAlign: pdf.TextAlign.center,
                          style: const pdf.TextStyle(fontSize: 16)),
                      pdf.ListView.builder(
                          itemCount: _obsController.length,
                          itemBuilder: (ctx, index) {
                            return pdf.Container(
                              child: pdf.Row(
                                mainAxisAlignment:
                                    pdf.MainAxisAlignment.spaceBetween,
                                children: [
                                  pdf.Text(_obsController
                                      .listItems[index].description
                                      .toString()),
                                  pdf.Text(_obsController.listItems[index].value
                                      .toString()),
                                ],
                              ),
                            );
                          }),
                      pdf.Divider(),
                    ]),
                  pdf.Text('${getTest()} - R\$ ${getValuePdf()}',
                      style: const pdf.TextStyle(fontSize: 16),
                      textAlign: pdf.TextAlign.right),
                ]));
          }),
    );

    final file = File(
        '${appDocDir!.first.path}/${DateHelper.getDate(_dataController.items.map((e) => e.date).first)}.pdf');
    // if(file.exists()){
    //   await file.writeAsBytes(await myPdf.save());
    // }
    // else{
    // await file.writeAsBytes(await myPdf.editPage(1, 'page'));
    // }
    await file.writeAsBytes(await myPdf.save());
  }
}
