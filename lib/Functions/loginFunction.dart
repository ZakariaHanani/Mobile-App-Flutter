// ignore_for_file: unused_local_variable, use_build_context_synchronously, prefer_const_constructors, no_leading_underscores_for_local_identifiers, unnecessary_new, avoid_print


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'dart:async';

import '../Pages/HomePage.dart';
import 'SubFunctions/SecureStorage.dart';
import 'SubFunctions/StudentInfo.dart';

Future<void> login(String username, String password, BuildContext context) async {
var url = Uri.parse('http://192.168.43.10:8000/api/login/');
  try{
    
     //var url = Uri.parse('http://192.168.56.1:8000/api/login/');
  final response = await http.post(
    url,
    headers: <String, String>{
      "Content-Type": "application/json"},
    body: jsonEncode(<String,dynamic>{
      'id': username,
      'password': password,
    }),
  );
   if (response.statusCode == 200)  {
    try{
      var data = json.decode(response.body);
      await saveStudentInfo(data['student']);
      await  SecureStorage().storeToken(data['token']) ;
       print(" HERE AFFichage ");
      if (data['detail'] == 'successfully loged in') { 
        var token = await SecureStorage().getToken();
        print(" HERE AFFichage ");
        print("Token  is is ${token}");
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => HomePage()));
        
      } else {
        _showDialog(context, "Échec de la connexion", "Nom d'utilisateur ou mot de passe incorrect.");
      }
    }  catch (error) {
    print("Error saving data: $error");
    _showDialog(context, "Erreur du serveur", "Veuillez réessayer plus tard ");
    }
       
    } else {
      // Gérer l'erreur du serveur
      _showDialog(context, "Erreur du serveur", "Veuillez réessayer plus tard.");
     }
    }on SocketException catch (socketException) {
    // Specific handling for network-related issues
    print('SocketException caught: ${socketException.message}');
    } on TimeoutException catch (e) {
    // Handle the TimeoutException, which is thrown when the request times out
    print('TimeoutException: ${e.message}');
  }
    catch (e) {
    // Ici, vous pouvez gérer toutes les exceptions non traitées précédemment.
    _showDialog(context, "Erreur", "Une erreur est survenue lors de la tentative de connexion. Veuillez vérifier votre connexion Internet et réessayer.");
    print(e.toString()); // Pour le débogage, vous pourriez vouloir imprimer l'erreur dans la console.
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
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  