import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';



Future<void> saveStudentInfo(Map<String, dynamic> studentInfo) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  String studentInfoJson = jsonEncode(studentInfo); // Convertit Map en String JSON
  await prefs.setString('studentInfo', studentInfoJson);
}


Future<Map<String, dynamic>?> getStudentInfo() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  String? studentInfoJson = prefs.getString('studentInfo');
  if (studentInfoJson != null) {
    return jsonDecode(studentInfoJson); // Convertit String JSON en Map
  }
  return null;
}
