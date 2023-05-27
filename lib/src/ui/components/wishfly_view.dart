import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wishfly/src/core/ext/context_ext.dart';
import 'package:wishfly/src/io/models/project_plan_model.dart';
import 'package:wishfly/src/ui/components/wishfly_adaptive_progress_bar.dart';
import 'package:wishfly/src/ui/components/wishfly_list_tile.dart';
import 'package:wishfly/src/ui/components/wishfly_new_wish_modal.dart';
import 'package:wishfly/src/ui/theme/spacing.dart';
import 'package:wishfly/src/ui/theme/wishfly_theme.dart';
import 'package:wishfly/src/ui/wishfly_controller.dart';
import 'package:wishfly_shared/wishfly_shared.dart';

class WishflyView extends StatelessWidget {
  const WishflyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WishflyTheme.of(context)?.primaryBackgroundColor,
      body: RefreshIndicator(
        color: WishflyTheme.of(context)?.addWishButtonColor,
        onRefresh: () async => await context.read<WishflyController>().refresh(),
        child: context.watch<WishflyController>().fetchWishResult.when(
              (wishes) => wishes.isEmpty
                  ? const _NoWishesText()
                  : Stack(
                      children: [
                        _WishesListView(wishes: wishes),
                        const _MadeByWishflyText(),
                      ],
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

class _WishesListView extends StatelessWidget {
  final List<WishResponseDto> wishes;
  const _WishesListView({required this.wishes});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(
        top: spacingS + 4,
        bottom: spacingL + spacingM,
      ),
      itemCount: wishes.length,
      itemBuilder: (context, index) {
        final wish = wishes[index];
        return WishflyListTile(
          wish: wish,
          onVoteTap: () => context.read<WishflyController>().toggleVote(wish),
        );
      },
    );
  }
}

class _MadeByWishflyText extends StatelessWidget {
  const _MadeByWishflyText();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Visibility(
        visible: context.watch<WishflyController>().userCurrentPlan == ProjectPlan.free,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Text(
            "${context.translate("poweredBy")} Wishfly.dev",
            style: TextStyle(color: WishflyTheme.of(context)!.descriptionTextColor),
          ),
        ),
      ),
    );
  }
}

class _NoWishesText extends StatelessWidget {
  const _NoWishesText();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: spacingL,
        ),
        child: Text(
          context.translate('noWishes'),
          textAlign: TextAlign.center,
          style: TextStyle(
            color: WishflyTheme.of(context)?.titleTextColor,
            fontSize: 18,
          ),
        ),
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
