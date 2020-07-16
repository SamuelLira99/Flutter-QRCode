import 'dart:async';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:barcode_scan/barcode_scan.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QR Code',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String _barcodeString = "Nenhum código foi lido ainda";
  String data = "https://github.com/SamuelLira99?tab=repositories";

  TextEditingController ctrlGen = TextEditingController();

  List prod = ["", ""];

  void _genQR() {
    setState(() {
      data = ctrlGen.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('QR Code - Samuel Lira'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[


            TextField(
              controller: ctrlGen,
            ),

            RaisedButton(
              child: Text('GERAR'),
              onPressed: _genQR,
            ),

            QrImage(
              data: data,
              version: QrVersions.auto,
              size: 200.0,
            ),

//            Text(_barcodeString),

            prod[0].length > 0 ?
            Text(prod[0]) : Text(''),

            prod[1].length > 0 ?
            Text(prod[1] != null ? 'R\$${prod[1].toString().replaceAll(".", ",")}' : '') : Text(''),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var result = await BarcodeScanner.scan();
          setState(() {
            _barcodeString = result.rawContent;
            data = _barcodeString;
            prod = data.split(":");
            print('prod: $prod');
          });
        },
        tooltip: 'Reader the QRCode',
        child: Icon(Icons.add_a_photo),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
