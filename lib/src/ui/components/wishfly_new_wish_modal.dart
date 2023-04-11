import 'dart:io';

import 'package:client/src/core/ext/context_ext.dart';
import 'package:client/src/ui/theme/spacing.dart';
import 'package:client/src/ui/wishfly_controller.dart';
import 'package:client/wishfly_client.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewWishModalController {
  static Future<void> showNewWishModal(BuildContext context) async {
    final formKey = GlobalKey<FormState>();

    String title = "";
    String description = "";

    showModalBottomSheet(
      backgroundColor: WishflyTheme.of(context)?.primaryBackgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      context: context,
      builder: (_) => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: spacingM,
          vertical: spacingM,
        ),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  context.translate('newWishTitle'),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: WishflyTheme.of(context)?.titleTextColor,
                      ),
                ),
              ),
              const SizedBox(height: spacingXL),
              Text(
                context.translate('newWishText'),
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: WishflyTheme.of(context)?.titleTextColor,
                    ),
              ),
              const SizedBox(height: spacingS),
              TextFormField(
                autocorrect: false,
                cursorColor: WishflyTheme.of(context)?.titleTextColor,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: WishflyTheme.of(context)?.titleTextColor,
                    ),
                onChanged: (text) {
                  title = text;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return context.translate('emptyTitleValidationErrorMessage');
                  }
                  return null;
                },
                decoration: InputDecoration(
                  filled: true,
                  border: OutlineInputBorder(borderSide: BorderSide(color: WishflyTheme.of(context)!.titleTextColor!)),
                  focusedBorder:
                      OutlineInputBorder(borderSide: BorderSide(color: WishflyTheme.of(context)!.titleTextColor!)),
                  enabledBorder:
                      OutlineInputBorder(borderSide: BorderSide(color: WishflyTheme.of(context)!.titleTextColor!)),
                ),
              ),
              const SizedBox(height: spacingM),
              Text(
                context.translate('newWishDescription'),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: WishflyTheme.of(context)?.titleTextColor,
                    ),
              ),
              const SizedBox(height: spacingS),
              TextFormField(
                autocorrect: false,
                cursorColor: WishflyTheme.of(context)?.titleTextColor,
                minLines: 4,
                maxLines: 7,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(fontSize: 16, color: WishflyTheme.of(context)!.titleTextColor),
                onChanged: (text) {
                  description = text;
                },
                decoration: InputDecoration(
                  filled: true,
                  border: OutlineInputBorder(borderSide: BorderSide(color: WishflyTheme.of(context)!.titleTextColor!)),
                  focusedBorder:
                      OutlineInputBorder(borderSide: BorderSide(color: WishflyTheme.of(context)!.titleTextColor!)),
                  enabledBorder:
                      OutlineInputBorder(borderSide: BorderSide(color: WishflyTheme.of(context)!.titleTextColor!)),
                ),
              ),
              const SizedBox(height: spacingL),
              Center(
                child: Platform.isIOS
                    ? CupertinoButton(
                        child: Text(
                          context.translate('saveNewWish'),
                          style: TextStyle(
                            color: WishflyTheme.of(context)?.titleTextColor,
                            fontSize: 18,
                          ),
                        ),
                        onPressed: () => _onCreateWishTapped(title, description, formKey, context),
                      )
                    : MaterialButton(
                        child: Text(
                          context.translate('saveNewWish'),
                          style: TextStyle(
                            color: WishflyTheme.of(context)?.titleTextColor,
                            fontSize: 18,
                          ),
                        ),
                        onPressed: () => _onCreateWishTapped(title, description, formKey, context),
                      ),
              ),
              const SizedBox(height: spacingL),
            ],
          ),
        ),
      ),
    );
  }

  static Future<void> _onCreateWishTapped(
    String title,
    String description,
    GlobalKey<FormState> formKey,
    BuildContext context,
  ) async {
    if (formKey.currentState!.validate()) {
      final navigator = Navigator.of(context);
      await context.read<WishflyController>().createNewWish(title, description);
      navigator.pop();
    }
  }
}
