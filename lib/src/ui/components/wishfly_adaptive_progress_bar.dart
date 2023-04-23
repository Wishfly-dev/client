import 'package:flutter/material.dart';
import 'package:wishfly/src/ui/theme/theme.dart';

class WishflyAdaptiveProgressBar extends StatelessWidget {
  const WishflyAdaptiveProgressBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator.adaptive(
        backgroundColor: WishflyTheme.of(context)!.progressBarBackgroundColor,
      ),
    );
  }
}
