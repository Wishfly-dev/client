import 'package:client/wishfly_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wishfly Demo',
      theme: ThemeData.light(),
      debugShowCheckedModeBanner: false,
      supportedLocales: const [Locale('en'), Locale('cs')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        WishflyLocalizationsDelegate(),
      ],
      home: const WishflyScreen(),
    );
  }
}

class WishflyScreen extends StatelessWidget {
  const WishflyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Wishfly"),
        backgroundColor: Colors.black,
      ),
      body: Wishfly(
        apiKey: "your-api-key-here", // Paste your API key here
        projectId: 0, // Paste your project ID here
        theme: WishflyThemeData.light(
          voteIconColor: Colors.black,
          addWishButtonColor: Colors.black,
        ),
      ),
    );
  }
}
