
// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, use_build_context_synchronously, must_be_immutable, override_on_non_overriding_member, library_private_types_in_public_api, unused_local_variable, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Pages/LoginPage.dart';
import 'package:flutter_application_1/Functions/SignoutFunction.dart';
import 'package:flutter_application_1/Pages/QrCodePage.dart';

import '../Functions/SubFunctions/StudentInfo.dart';

class HomePage extends StatefulWidget {   
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<Map<String, dynamic>?> studentInfo;

  @override
  void initState() {
    super.initState();
    // Initialisez studentInfo ici
    studentInfo = getStudentInfo();
  }
  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Color.fromARGB(255, 0, 10, 138),
        title: Text("Page d'Accueil",style: TextStyle(color: Colors.white)),
        centerTitle: true,
        automaticallyImplyLeading :false ,
         actions: <Widget>[ 
    IconButton(
      icon: Icon(Icons.exit_to_app,color: Colors.white,),
      onPressed: () async {
        //  fonction de déconnexion 
        await signOut();
        // Naviguer vers la page de connexion après la déconnexion
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => loginpage()),
          (Route<dynamic> route) => false,
        );
      },
    ),
  ],
      ),
      body:FutureBuilder<Map<String, dynamic>?>(
        future: studentInfo,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Erreur de chargement"));
          } else {
            // Ici, vous avez accès à snapshot.data qui contient vos informations d'étudiant
            final studentInfo = snapshot.data!; 
            final nom =studentInfo['fname'];
            final prenom =studentInfo['lname'];
            final email =studentInfo['email'];
            final filier= studentInfo['Identifiant_Filiere'];
            
            return Center(
        child:Column(
          crossAxisAlignment :CrossAxisAlignment.center ,
          children: <Widget>[
            SizedBox(height: 140),
            Icon(
               Icons.account_box_outlined ,
              size: 130.0, // Taille de l'icône
              color: Color.fromARGB(255, 0, 10, 138), // Couleur de l'icône
              
            ),
            SizedBox(height: 40), // Espacement entre l'icône et le texte
            Text("Nom :  $nom ", style: TextStyle(fontWeight:FontWeight.bold ,fontSize: 20)),
             SizedBox(height: 20),
            Text("Prénom :  $prenom", style: TextStyle(fontWeight:FontWeight.bold , fontSize: 20)),
             SizedBox(height: 20),
            Text("Filière :  Genie Informatique", style: TextStyle(fontWeight:FontWeight.bold ,fontSize: 20)),
             SizedBox(height: 20),
            Text("Email :  $email", style: TextStyle(fontWeight:FontWeight.bold , fontSize: 20)),
            SizedBox(height: 60),
              Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color:  Color.fromARGB(255, 0, 10, 138)),
              child: TextButton(
                onPressed: () {
                  // la logique de connexion avant de naviguer
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => QRViewpage()));
                },
                child: Text(
                  'Scanner ',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            )
          ],
        ),
      );
      }
        },
    ),
    );
  }
}
