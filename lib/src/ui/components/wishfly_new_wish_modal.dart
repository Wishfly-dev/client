import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wishfly/src/core/ext/context_ext.dart';
import 'package:wishfly/src/ui/theme/spacing.dart';
import 'package:wishfly/src/ui/theme/theme.dart';
import 'package:wishfly/src/ui/wishfly_controller.dart';

class NewWishModalController {
  /// Showing modal for new wish
  static Future<void> showNewWishModal(BuildContext context) async {
    final formKey = GlobalKey<FormState>();

    String title = "";
    String description = "";

    showModalBottomSheet(
      backgroundColor: WishflyTheme.of(context)?.primaryBackgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(spacingM),
          topRight: Radius.circular(spacingM),
        ),
      ),
      context: context,
      builder: (_) => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: spacingM,
        ),
        child: Form(
          key: formKey,
          child: Stack(
            children: [
              const _CloseButton(),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: spacingXL),
                  Center(
                    child: Text(
                      context.translate('newWishTitle'),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: WishflyTheme.of(context)?.titleTextColor,
                          ),
                    ),
                  ),
                  const SizedBox(height: spacingL),
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
                        return context
                            .translate('emptyTitleValidationErrorMessage');
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      filled: true,
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color:
                                  WishflyTheme.of(context)!.titleTextColor!)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color:
                                  WishflyTheme.of(context)!.titleTextColor!)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color:
                                  WishflyTheme.of(context)!.titleTextColor!)),
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
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontSize: 16,
                        color: WishflyTheme.of(context)!.titleTextColor),
                    onChanged: (text) {
                      description = text;
                    },
                    decoration: InputDecoration(
                      filled: true,
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color:
                                  WishflyTheme.of(context)!.titleTextColor!)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color:
                                  WishflyTheme.of(context)!.titleTextColor!)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color:
                                  WishflyTheme.of(context)!.titleTextColor!)),
                    ),
                  ),
                  const SizedBox(height: spacingS),
                  Text(
                    context.translate("newlyCreatedWishWarning"),
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                  ),
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
                            onPressed: () => _onCreateWishTapped(
                                title, description, formKey, context),
                          )
                        : MaterialButton(
                            child: Text(
                              context.translate('saveNewWish'),
                              style: TextStyle(
                                color: WishflyTheme.of(context)?.titleTextColor,
                                fontSize: 18,
                              ),
                            ),
                            onPressed: () => _onCreateWishTapped(
                                title, description, formKey, context),
                          ),
                  ),
                  const SizedBox(height: spacingL),
                ],
              ),
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

class _CloseButton extends StatelessWidget {
  const _CloseButton();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: spacingS,
      right: 0,
      child: Container(
        padding: const EdgeInsets.all(spacingS),
        child: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: const Icon(Icons.close),
        ),
      ),
    );
  }
}
