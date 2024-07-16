// ignore_for_file: file_names, use_build_context_synchronously, prefer_const_constructors, unnecessary_new, avoid_print, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Functions/SubFunctions/SecureStorage.dart';
import 'package:flutter_application_1/Pages/HomePage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'SubFunctions/StudentInfo.dart';

Future<void> updateAttendance(String studentID, String SeanceID,BuildContext context) async {
  String? Token =await SecureStorage().getToken();
  var url = Uri.parse('http://192.168.43.10:8000/api/update/'); 
  try{
  var response = await http.put(
    url,
    headers: {"Content-Type": "application/json" },
    body: json.encode({
     // ignore: unnecessary_string_interpolations
     'Identifiant_Seance' : '1' , //SeanceID,
     // ignore: unnecessary_string_interpolations
     'Identifiant_Etudiant' : studentID,
     'Token' :Token
    }),
  );
  
  if (response.statusCode == 200) {
    final stdinfo =await getStudentInfo() ;
    final completName =stdinfo?['fname'] +" "+ stdinfo?['lname'];
     print("Mise à jour réussie");
    _showDialog(context, "Done", "La présence a été enregistrée Mr, $completName");
  } else {
    print("Une erreur s'est produit lors de l'enregistrement de la présence : ${response.body}");
    _showDialog(context, "Erreur", "Une erreur s'est produit lors de l'enregistrement de la présence : ${response.body}");
  } 
}catch (e) {
   
    _showDialog(context, "Erreur", "Une erreur est survenue lors de la tentative de connexion. Veuillez vérifier votre connexion Internet et réessayer.");
    print(e.toString()); 
  } 
}

void _showDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(title),
          content: new Text(message),
          actions: <Widget>[
            new TextButton(
              child: new Text("Fermer"),
              onPressed: () {
                 Navigator.push(
                      context, MaterialPageRoute(builder: (_) => HomePage()));
              },
            ),
          ],
        );
      },
    );
  }

  /*
  void Attendance(String idStudent ,String idSession ,BuildContext context) async{
  if (result != null) {
     
      String sessionId = result!.code!;

      String studentId = "VotreMéthodePourObtenirLID"; 
      
      await updateAttendance(studentId, sessionId,context);
    }
  }
  */