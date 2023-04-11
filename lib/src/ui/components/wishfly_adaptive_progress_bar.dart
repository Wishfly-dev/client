import 'package:client/wishfly_client.dart';
import 'package:flutter/material.dart';

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
