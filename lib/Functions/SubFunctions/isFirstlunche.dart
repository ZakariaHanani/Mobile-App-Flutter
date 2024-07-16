import 'package:shared_preferences/shared_preferences.dart';

Future<bool> isFirstLaunch() async {
  final prefs = await SharedPreferences.getInstance();
  final isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;

  if (isFirstLaunch) {
    // Marquer comme non premier lancement pour les futurs démarrages de l'app
    await prefs.setBool('isFirstLaunch', false);
    return true;
  }

  return false;
}
