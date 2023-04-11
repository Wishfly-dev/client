Put your users to driver's seat. Wishfly allows you to know what functions should your app have. 

![](./images/hero.png)

## Features
- User can create wish with title and description. 
- In [Admin](https://admin.wishfly.dev) you can change status of each wish (all new wishes must be approved before showing in list for users).

## Getting started
1. Add dependency to your pubspec file
```yaml
wishfly_client:
    https://github.com/Wishfly-dev/client.git
```

2. Import and configure it with your API key and project. You can find your API key in your admin dashboard on <a href="https://admin.wishfly.dev" target="_blank">wishfly.dev</a>

```dart
import 'package:wishfly_client/wishfly_client.dart';
```

3. You can place Widget in you widget tree. It could be a screen, modal or whatever you want. 

```dart
child: Wishfly(
    apiKey: "your-api-key-here", // Paste your API key here
    projectId: 0, // Paste your project ID here        
),
```

## Additional information

### Localization
Wishfly currently support two locales: English and Czech. You can see string [here](https://github.com/Wishfly-dev/client/tree/dev/assets/l10n). If you want to add a locale, don't hesitate to create a pull request. 

### Theme 
You can customize colors in UI. Here you can see what you can customize:

```dart
class WishflyThemeData {
  final Brightness brightness;
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