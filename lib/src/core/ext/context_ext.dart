import 'package:flutter/material.dart';
import 'package:wishfly_client/wishfly_client.dart';

extension BuildContextExt on BuildContext {
  String translate(String key) {
    return WishflyLocalizations.of(this)!.translate(key);
  }
}
