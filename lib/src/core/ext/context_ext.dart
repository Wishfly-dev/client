import 'package:flutter/material.dart';
import 'package:wishfly_client/wishfly_client.dart';

extension BuildContextExt on BuildContext {
  /// Returns the translated text for the given [key].
  String translate(String key) {
    return WishflyLocalizations.of(this)!.translate(key);
  }

  /// Overrides the translation for the given [key] with the given [translatedText].
  void overrideKey(String key, String translatedText) {
    return WishflyLocalizations.of(this)!.overrideKey(key, translatedText);
  }
}
