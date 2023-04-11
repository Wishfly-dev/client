import 'dart:async';
import 'dart:convert';

import 'package:client/wishfly_client.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final _supportedLanguages = ['en', 'cs'];

class WishflyLocalizationsDelegate extends LocalizationsDelegate<WishflyLocalizations> {
  const WishflyLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => _supportedLanguages.contains(locale.languageCode);

  @override
  Future<WishflyLocalizations> load(Locale locale) async {
    String jsonString = await rootBundle.loadString('packages/client/assets/l10n/${locale.languageCode}.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);

    return SynchronousFuture<WishflyLocalizations>(
      WishflyLocalizations(jsonMap.cast<String, String>()),
    );
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<WishflyLocalizations> old) => false;
}
