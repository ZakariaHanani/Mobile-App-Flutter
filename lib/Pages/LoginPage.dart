// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, camel_case_types, library_private_types_in_public_api

import 'package:flutter/material.dart';

import '/Functions/loginFunction.dart';

class loginpage extends StatefulWidget {
  @override
  _LoginDemoState createState() => _LoginDemoState();
}

class _LoginDemoState extends State<loginpage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        toolbarHeight: 80 ,
        backgroundColor: Color.fromARGB(255, 0, 10, 138),
        centerTitle: true,
        title:  Text("Page d'authentification " ,style: TextStyle(color: Color.fromARGB(255, 232, 232, 233), fontSize: 25))
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 90.0),
              child: Center(
                child: SizedBox(
                    width: 300,
                    height: 200,
                    child: Image.asset('assets/images/Estg Guelmim .jpg')),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: TextField(
                controller: _usernameController, 
                decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(width: 1, color:Color.fromARGB(255, 2, 6, 61)),
                  borderRadius: BorderRadius.circular(3),
                ),
              
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(width: 1.8, color: Color.fromARGB(255, 0, 8, 97)),
                  borderRadius: BorderRadius.circular(3),
                ) ,
                    labelText: "Nom d'utilisateur" , 
                    labelStyle: TextStyle(
                    color: Color.fromARGB(255, 2, 6, 61),
                    ),
                    hintText: 'Entrer votre nom'), 
                     ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: _passwordController,
                obscureText: true, 
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(width: 1, color:Color.fromARGB(255, 2, 6, 61)),
                  borderRadius: BorderRadius.circular(3),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(width: 1.8, color: Color.fromARGB(255, 0, 8, 97)),
                  borderRadius: BorderRadius.circular(3),
                ) ,
                     labelText: 'Mot de  passe',
                     labelStyle: TextStyle(
                    color: Color.fromARGB(255, 2, 6, 61),
                    ),
                    hintText: 'Entrer votre mot de pass'),
              ),
            ),
            SizedBox(height: 20),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color:  Color.fromARGB(255, 10, 17, 114) ),
              child: ElevatedButton(
                onPressed: () => login(_usernameController.text,_passwordController.text,context),
                style: ElevatedButton.styleFrom(
                 backgroundColor: Color.fromARGB(255, 0, 10, 138)
                ),
                child: Text(
                  'Se connecter',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
            SizedBox(height: 130),
          ],
        ),
      ),
    );
  }
}