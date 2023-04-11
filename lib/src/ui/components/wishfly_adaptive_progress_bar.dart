import 'package:flutter/material.dart';
import 'package:wishfly_client/wishfly_client.dart';

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
