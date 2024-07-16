// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, non_constant_identifier_names, use_build_context_synchronously

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Functions/SubFunctions/StudentInfo.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';


import '../Functions/UpdateAttendanceFunctions.dart';

class QRViewpage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewpage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  bool isLoading = false;

  @override
void reassemble() {
  super.reassemble();
  if (Platform.isAndroid) {
    controller!.pauseCamera();
  } else if (Platform.isIOS) {
    controller!.resumeCamera(); 
  }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child:  Text('Veuillez Scanner le Code QR',style: TextStyle(color: Color.fromARGB(255, 4, 0, 66),fontSize: 26,fontWeight:FontWeight.bold)),
            ),
          ),
          if (isLoading)
          Container(
            color: Color.fromARGB(255, 0, 0, 0),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
       reassemble();
      setState(() {
        result = scanData;
        isLoading = true;
       
      });
      await Future.delayed(Duration(seconds: 3));
      
     
      String SeanceID = result!.code!;
      Map<String, dynamic>? studentId = await getStudentInfo();
      String Id =studentId?['id'] ;
      await updateAttendance(Id,SeanceID,context);
    
      if (mounted) {
        setState(() {
        isLoading = false; 
          });
          }
    }

    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}