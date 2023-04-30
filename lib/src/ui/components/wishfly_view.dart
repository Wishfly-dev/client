import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wishfly/src/core/ext/context_ext.dart';
import 'package:wishfly/src/ui/components/wishfly_adaptive_progress_bar.dart';
import 'package:wishfly/src/ui/components/wishfly_list_tile.dart';
import 'package:wishfly/src/ui/components/wishfly_new_wish_modal.dart';
import 'package:wishfly/src/ui/theme/spacing.dart';
import 'package:wishfly/src/ui/theme/wishfly_theme.dart';
import 'package:wishfly/src/ui/wishfly_controller.dart';

class WishflyView extends StatelessWidget {
  const WishflyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WishflyTheme.of(context)?.primaryBackgroundColor,
      body: RefreshIndicator(
        color: WishflyTheme.of(context)?.addWishButtonColor,
        onRefresh: () async =>
            await context.read<WishflyController>().refresh(),
        child: context.watch<WishflyController>().fetchWishResult.when(
              (wishes) => wishes.isEmpty
                  ? Center(
                      child: Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: spacingL),
                        child: Text(
                          context.translate('noWishes'),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: WishflyTheme.of(context)?.titleTextColor,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.only(top: spacingS + 4),
                      itemCount: wishes.length,
                      itemBuilder: (context, index) {
                        final wish = wishes[index];
                        return WishflyListTile(
                          wish: wish,
                          onVoteTap: () => context
                              .read<WishflyController>()
                              .toggleVote(wish),
                        );
                      },
                    ),
              (error) => const _InitialFetchError(),
              () => const WishflyAdaptiveProgressBar(),
            ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: WishflyTheme.of(context)?.addWishButtonColor,
        onPressed: () => NewWishModalController.showNewWishModal(context),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

/// Displays an error message when the initial fetch fails
class _InitialFetchError extends StatelessWidget {
  const _InitialFetchError();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        context.translate('errorLoadingWishes'),
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: WishflyTheme.of(context)?.titleTextColor,
            ),
      ),
    );
  }
}
