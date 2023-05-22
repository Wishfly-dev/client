import 'package:example/app_theme.dart';
import 'package:example/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:wishfly/wishfly.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool themeDark = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wishfly Demo',
      theme: themeDark ? AppTheme.darkTheme : AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      supportedLocales: const [Locale('en')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        WishflyLocalizations.delegate,
      ],
      home: DashboardScreen(
        toggleTheme: () {
          setState(() => themeDark = !themeDark);
        },
      ),
    );
  }
}
