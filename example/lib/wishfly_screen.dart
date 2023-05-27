import 'package:flutter/material.dart';
import 'package:wishfly/wishfly.dart';

class WishflyScreen extends StatelessWidget {
  const WishflyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Wishfly(
      apiKey: "your-api-key",
      projectId: 0,
      theme: Theme.of(context).brightness == Brightness.dark
          ? WishflyThemeData.dark(
              voteIconColor: Colors.red,
              addWishButtonColor: Colors.red,
              titleTextColor: Colors.white70,
              descriptionTextColor: Colors.white70,
              voteCountTextColor: Colors.white70,
              tileBackgroundColor: Colors.grey.withOpacity(0.3),
              primaryBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
            )
          : WishflyThemeData.light(
              addWishButtonColor: Colors.black,
            ),
    );
  }
}
