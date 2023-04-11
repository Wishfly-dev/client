import 'package:flutter/material.dart';
import 'package:wishfly_client/src/ui/theme/wishfly_theme_data.dart';

class WishflyTheme extends StatelessWidget {
  const WishflyTheme({
    Key? key,
    required this.data,
    required this.child,
  }) : super(key: key);

  final WishflyThemeData data;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return _InheritedWishflyTheme(
      themeData: data,
      child: child,
    );
  }

  static WishflyThemeData? of(BuildContext context, {bool listen = true}) {
    if (listen) {
      final _InheritedWishflyTheme? inheritedTheme =
          context.dependOnInheritedWidgetOfExactType<_InheritedWishflyTheme>();
      return inheritedTheme?.themeData;
    }
    final _InheritedWishflyTheme? theme = context.findAncestorWidgetOfExactType<_InheritedWishflyTheme>();
    return theme?.themeData;
  }
}

class _InheritedWishflyTheme extends InheritedWidget {
  const _InheritedWishflyTheme({
    Key? key,
    required this.themeData,
    required Widget child,
  }) : super(key: key, child: child);

  final WishflyThemeData themeData;

  @override
  bool updateShouldNotify(_InheritedWishflyTheme oldWidget) => themeData != oldWidget.themeData;
}
