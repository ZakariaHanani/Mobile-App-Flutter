import 'package:shared_preferences/shared_preferences.dart';
import 'SubFunctions/SecureStorage.dart' ;

Future<void> signOut() async {
  final prefs = await SharedPreferences.getInstance();
 
  await prefs.setBool('isFirstLaunch', true);
  SecureStorage().deleteToken() ;
  
}