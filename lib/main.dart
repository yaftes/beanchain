import 'package:beanchain/app.dart';
import 'package:beanchain/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final prefs = await SharedPreferences.getInstance();
  final langCode = prefs.getString('langCode') ?? 'am';

  runApp(MyApp(locale: Locale(langCode)));
}
