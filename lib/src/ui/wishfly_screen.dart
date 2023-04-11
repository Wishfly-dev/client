import 'package:client/src/ui/components/wishfly_view.dart';
import 'package:client/src/ui/theme/wishfly_theme.dart';
import 'package:client/src/ui/theme/wishfly_theme_data.dart';
import 'package:client/src/ui/wishfly_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wishfly extends StatelessWidget {
  const Wishfly({
    required this.apiKey,
    required this.projectId,
    this.theme,
    super.key,
  });

  /// Your Wishfly API key
  final String apiKey;

  /// The ID of the project you want to display
  final int projectId;

  /// Custom theme data
  final WishflyThemeData? theme;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => WishflyController(
        apiKey: apiKey,
        projectId: projectId,
      )..fetchProject(),
      child: WishflyTheme(
        data: theme ?? WishflyThemeData.light(),
        child: const WishflyView(),
      ),
    );
  }
}
