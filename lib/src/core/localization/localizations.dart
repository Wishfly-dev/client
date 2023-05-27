import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WishflyLocalizations {
  final Map<String, String> _localizedStrings;

  WishflyLocalizations(this._localizedStrings);

  static WishflyLocalizations? of(BuildContext context) {
    return Localizations.of<WishflyLocalizations>(
      context,
      WishflyLocalizations,
    );
  }

  static const LocalizationsDelegate<WishflyLocalizations> delegate = _WishflyLocalizationsDelegate();
  static LocalizationsDelegate<WishflyLocalizations> customDelegate({required List<Locale> supportedLocales}) =>
      _WishflyLocalizationsDelegate(supportedLocales);

  String translate(String key) {
    return _localizedStrings[key] ?? '';
  }

  void overrideKey(String key, String value) {
    if (_localizedStrings.containsKey(key)) {
      _localizedStrings[key] = value;
    }
  }
}

final _supportedLanguages = ['en'];

class _WishflyLocalizationsDelegate extends LocalizationsDelegate<WishflyLocalizations> {
  final List<Locale>? supportedLanguages;
  const _WishflyLocalizationsDelegate([this.supportedLanguages]);

  @override
  bool isSupported(Locale locale) => _supportedLanguages.contains(locale.languageCode);

  @override
  Future<WishflyLocalizations> load(Locale locale) async {
    late String jsonString;

    try {
      jsonString = await rootBundle.loadString('assets/l10n/${locale.languageCode}.json');
    } catch (e) {
      jsonString = await rootBundle.loadString('packages/wishfly/assets/l10n/${locale.languageCode}.json');
    }

    Map<String, dynamic> jsonMap = json.decode(jsonString);

    return SynchronousFuture<WishflyLocalizations>(
      WishflyLocalizations(jsonMap.cast<String, String>()),
    );
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<WishflyLocalizations> old) => false;
}
