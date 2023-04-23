import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wishfly/src/core/ext/context_ext.dart';
import 'package:wishfly/src/ui/components/wishfly_view.dart';
import 'package:wishfly/src/ui/theme/wishfly_theme.dart';
import 'package:wishfly/src/ui/theme/wishfly_theme_data.dart';
import 'package:wishfly/src/ui/wishfly_controller.dart';

class Wishfly extends StatefulWidget {
  const Wishfly({
    required this.apiKey,
    required this.projectId,
    this.theme,
    this.localizationOverrides,
    super.key,
  });

  /// Your Wishfly API key
  final String apiKey;

  /// The ID of the project you want to display
  final int projectId;

  /// Custom theme data
  final WishflyThemeData? theme;

  /// Override localization strings
  final Map<String, String>? localizationOverrides;

  @override
  State<Wishfly> createState() => _WishflyState();
}

class _WishflyState extends State<Wishfly> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => WishflyController(
        apiKey: widget.apiKey,
        projectId: widget.projectId,
      )..fetchProject(),
      child: WishflyTheme(
        data: widget.theme ?? WishflyThemeData.light(),
        child: const WishflyView(),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    /// Override localization strings
    if (widget.localizationOverrides != null) {
      widget.localizationOverrides!.forEach(
        (key, value) => context.overrideKey(key, value),
      );
    }
  }
}
