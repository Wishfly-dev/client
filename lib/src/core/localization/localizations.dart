import 'package:flutter/material.dart';

class WishflyLocalizations {
  final Map<String, String> _localizedStrings;

  WishflyLocalizations(this._localizedStrings);

  static WishflyLocalizations? of(BuildContext context) {
    return Localizations.of<WishflyLocalizations>(context, WishflyLocalizations);
  }

  String translate(String key) {
    return _localizedStrings[key] ?? '';
  }

  void overrideKey(String key, String value) {
    _localizedStrings[key] = value;
  }
}
