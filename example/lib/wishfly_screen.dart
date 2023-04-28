import 'package:flutter/material.dart';
import 'package:wishfly/wishfly.dart';

class WishflyScreen extends StatelessWidget {
  const WishflyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Wishfly(
      apiKey: "your-api-key", // Paste your API key here
      projectId: 0, // Paste your project ID here
      localizationOverrides: const {
        "noWishes":
            "No wishes here, but you can be the first one!", // override specific key in localization
      },
      theme: WishflyThemeData.light(
        voteIconColor: Colors.black,
        addWishButtonColor: Colors.black,
      ),
    );
  }
}
