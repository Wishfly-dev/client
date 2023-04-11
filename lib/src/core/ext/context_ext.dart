import 'package:client/wishfly_client.dart';
import 'package:flutter/material.dart';

extension BuildContextExt on BuildContext {
  String translate(String key) {
    return WishflyLocalizations.of(this)!.translate(key);
  }
}
