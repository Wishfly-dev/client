import 'package:flutter/material.dart';
import 'package:wishfly/src/ui/theme/spacing.dart';
import 'package:wishfly/src/ui/theme/theme.dart';
import 'package:wishfly_shared/wishfly_shared.dart';

class WishflyListTile extends StatelessWidget {
  final WishResponseDto wish;
  final VoidCallback onVoteTap;

  const WishflyListTile({
    required this.wish,
    required this.onVoteTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      margin: const EdgeInsets.only(
        top: spacingS,
        bottom: spacingS / 2,
        left: spacingM,
        right: spacingM,
      ),
      decoration: BoxDecoration(
        color: WishflyTheme.of(context)?.tileBackgroundColor,
        boxShadow: WishflyTheme.of(context)?.shadowColor == null
            ? null
            : [
                BoxShadow(
                  color: WishflyTheme.of(context)!.shadowColor!,
                  spreadRadius: 2,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: onVoteTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "packages/wishfly_client/assets/images/upvote.png",
                    width: 20,
                    color: WishflyTheme.of(context)?.voteIconColor,
                  ),
                  const SizedBox(height: spacingS),
                  Text(
                    wish.votes.toString(),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: WishflyTheme.of(context)?.voteCountTextColor,
                          fontSize: 18,
                        ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  wish.title,
                  maxLines: 1,
                  overflow: TextOverflow.fade,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: WishflyTheme.of(context)?.titleTextColor,
                        fontSize: 18,
                      ),
                ),
                const SizedBox(height: spacingS + 2),
                Text(
                  wish.description,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: WishflyTheme.of(context)?.descriptionTextColor,
                        fontSize: 15,
                      ),
                ),
              ],
            ),
          ),
          const SizedBox(width: spacingS),
        ],
      ),
    );
  }
}
