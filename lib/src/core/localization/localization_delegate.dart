import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wishfly/src/core/localization/localizations.dart';

final _supportedLanguages = ['en'];

class WishflyLocalizationsDelegate extends LocalizationsDelegate<WishflyLocalizations> {
  const WishflyLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => _supportedLanguages.contains(locale.languageCode);

  @override
  Future<WishflyLocalizations> load(Locale locale) async {
    late String jsonString;

    try {
      jsonString = await rootBundle.loadString('assets/l10n/${locale.languageCode}.json');
    } catch (e) {
      jsonString = await rootBundle.loadString('packages/wishfly_client/assets/l10n/${locale.languageCode}.json');
    }

    Map<String, dynamic> jsonMap = json.decode(jsonString);

    return SynchronousFuture<WishflyLocalizations>(
      WishflyLocalizations(jsonMap.cast<String, String>()),
    );
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<WishflyLocalizations> old) => false;
}
