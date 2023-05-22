# Wishfly

[![pub package](https://img.shields.io/pub/v/wishfly.svg)](https://pub.dev/packages/wishfly)
[![Website](https://img.shields.io/badge/website-wishfly.dev-blue.svg)](https://wishfly.dev/)
[![Twitter](https://img.shields.io/badge/Twitter-@Wishflydev-00c573.svg)](https://twitter.com/Wishflydev)

## Put your users to driver's seat. Wishfly allows you to know what functions should your app have. 


![](./images/hero.png)

## Features
- User can create feature request with title and description. 
- In [Admin](https://admin.wishfly.dev) you can change status of each feature request.
- All new feature requests must be approved by you before popping up in user list.

## Getting started
> 🤘 It takes less than 180 seconds to integrate Wishfly into your app.<br />

1. Go to the [Wishfly Admin](https://admin.wishfly.dev) and create account. <br />Click on plus button to create a new project and enter your app's name.

2. Add dependency to your `pubspec.yaml` file

```bash
$ flutter pub add wishfly: ^<latest version>
```
or 

```yaml
dependencies:
  flutter:
    sdk: flutter
  ...
  wishfly: ^<latest version>
```

Don't forget to `flutter pub get`.

3. Import package in your dart file

```dart
import 'package:wishfly/wishfly.dart';
```

4. You can place Widget in you widget tree. It could be a screen, modal or whatever you want. You can see example below.

```dart
import 'package:wishfly/wishfly.dart';

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Wishfly(
      apiKey: "your-api-key-here", // your API key
      projectId: 0, // your project ID
    );
  }
}
```
---

## Additional information
Even though you can customize almost every color, Wishfly doesn't have to perfectly fit your needs. No problem. There is [API client](https://github.com/Wishfly-dev/api_client) so you can perfectly match it with your design system. 

### Localization
Default language is English.

For supporting other languages, you can add corresponding keys to your own localization file and pass it to Wishfly widget. You can see localization keys [here](https://github.com/Wishfly-dev/client/blob/dev/assets/l10n/en.json).

To get localization done, add ```WishflyLocalizations.delegate``` to your MaterialApp widget. 

```dart
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wishfly Demo',
      supportedLocales: const [Locale('en')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        WishflyLocalizations.delegate, // Add this line
      ],
      home: ...,
    );
  }
}
```

### Theme 
You can customize colors in UI. Here you can see what you can customize:

```dart
class WishflyThemeData {
  final Color? voteIconColor;
  final Color? addWishButtonColor;
  final Color? titleTextColor;
  final Color? tileBackgroundColor;
  final Color? descriptionTextColor;
  final Color? shadowColor;
  final Color? voteCountTextColor;
  final Color? primaryBackgroundColor;
  final Color? itemTileColor;
  final Color? progressBarBackgroundColor;

  //...
}
```

In order to support dark or light mode, use ```WishflyThemeData.light()``` or ```WishflyThemeData.dark()``` factory method. 

Example usage could be: 

```dart
child: Wishfly(
    apiKey: "your-api-key-here", // Paste your API key here
    projectId: 0, // Paste your project ID here        
    theme: WishflyThemeData.light(
        voteIconColor: Colors.black,
        addWishButtonColor: Colors.black,
        // more..
    ),      
),
``` 

You can see complete example [here](https://github.com/Wishfly-dev/client/blob/dev/example/lib/wishfly_screen.dart)

--- 
### Note: ⚠️ Wishfly is currently in beta and under development. The SDK API might change in future.
