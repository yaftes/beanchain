import 'package:beanchain/features/coffee/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyApp extends StatefulWidget {
  final Locale locale;
  const MyApp({required this.locale, super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Locale _locale;

  @override
  void initState() {
    super.initState();
    _locale = widget.locale;
  }

  void setLocale(Locale newLocale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('langCode', newLocale.languageCode);

    setState(() {
      _locale = newLocale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: _locale,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      debugShowCheckedModeBanner: false,
      home: HomePage(onChangeLanguage: setLocale),
    );
  }
}
