import 'package:flutter/material.dart';

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

  WishflyThemeData({
    this.brightness = Brightness.light,
    this.voteIconColor,
    this.titleTextColor,
    this.descriptionTextColor,
    this.shadowColor,
    this.tileBackgroundColor,
    this.voteCountTextColor,
    this.addWishButtonColor,
    this.primaryBackgroundColor,
    this.itemTileColor,
    this.progressBarBackgroundColor,
  });

  factory WishflyThemeData.light({
    Color? voteIconColor,
    Color? addWishButtonColor,
    Color? titleTextColor,
    Color? voteCountTextColor,
    Color? descriptionTextColor,
    Color? primaryBackgroundColor,
    Color? tileBackgroundColor,
    Color? itemTileColor,
    Color? progressBarBackgroundColor,
  }) {
    return WishflyThemeData.defaultTheme().copyWith(
      brightness: Brightness.light,
      voteIconColor: voteIconColor,
      addWishButtonColor: addWishButtonColor,
      titleTextColor: titleTextColor,
      voteCountTextColor: voteCountTextColor,
      descriptionTextColor: descriptionTextColor,
      primaryBackgroundColor: primaryBackgroundColor,
      tileBackgroundColor: tileBackgroundColor,
      itemTileColor: itemTileColor,
      progressBarBackgroundColor: progressBarBackgroundColor,
    );
  }

  factory WishflyThemeData.dark({
    Color? voteIconColor,
    Color? addWishButtonColor,
    Color? titleTextColor,
    Color? voteCountTextColor,
    Color? descriptionTextColor,
    Color? primaryBackgroundColor,
    Color? tileBackgroundColor,
    Color? itemTileColor,
    Color? progressBarBackgroundColor,
  }) {
    return WishflyThemeData.defaultTheme()
      ..copyWith(
        brightness: Brightness.dark,
        voteIconColor: voteIconColor,
        addWishButtonColor: addWishButtonColor,
        titleTextColor: titleTextColor,
        voteCountTextColor: voteCountTextColor,
        descriptionTextColor: descriptionTextColor,
        primaryBackgroundColor: primaryBackgroundColor,
        tileBackgroundColor: tileBackgroundColor,
        itemTileColor: itemTileColor,
        progressBarBackgroundColor: progressBarBackgroundColor,
      );
  }

  factory WishflyThemeData.defaultTheme() {
    return WishflyThemeData(
      titleTextColor: Colors.black,
      descriptionTextColor: Colors.grey,
      voteIconColor: Colors.black,
      addWishButtonColor: Colors.black,
      tileBackgroundColor: Colors.white,
      shadowColor: Colors.grey.withOpacity(0.2),
      voteCountTextColor: Colors.black,
      primaryBackgroundColor: const Color(0xffefefef),
      progressBarBackgroundColor: Colors.black,
    );
  }

  WishflyThemeData copyWith({
    Brightness? brightness,
    Color? voteIconColor,
    Color? addWishButtonColor,
    Color? titleTextColor,
    Color? voteCountTextColor,
    Color? descriptionTextColor,
    Color? primaryBackgroundColor,
    Color? tileBackgroundColor,
    Color? itemTileColor,
    Color? progressBarBackgroundColor,
  }) {
    return WishflyThemeData(
      brightness: brightness ?? this.brightness,
      voteIconColor: voteIconColor ?? this.voteIconColor,
      addWishButtonColor: addWishButtonColor ?? this.addWishButtonColor,
      titleTextColor: titleTextColor ?? this.titleTextColor,
      tileBackgroundColor: tileBackgroundColor ?? this.tileBackgroundColor,
      voteCountTextColor: voteCountTextColor ?? this.voteCountTextColor,
      descriptionTextColor: descriptionTextColor ?? this.descriptionTextColor,
      primaryBackgroundColor: primaryBackgroundColor ?? this.primaryBackgroundColor,
      itemTileColor: itemTileColor ?? this.itemTileColor,
      progressBarBackgroundColor: progressBarBackgroundColor ?? this.progressBarBackgroundColor,
    );
  }
}
