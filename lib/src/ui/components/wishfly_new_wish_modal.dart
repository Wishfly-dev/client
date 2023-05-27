import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wishfly/src/core/ext/context_ext.dart';
import 'package:wishfly/src/io/models/new_wish_model.dart';
import 'package:wishfly/src/ui/theme/spacing.dart';
import 'package:wishfly/src/ui/theme/theme.dart';
import 'package:wishfly/src/ui/wishfly_controller.dart';

/// Controller for showing new wish modal
class NewWishModalController {
  /// Showing modal for new wish
  ///
  /// This will show modal based on the device layout (mobile or web)
  static Future<void> showNewWishModal(BuildContext context) async {
    final theme = WishflyTheme.of(context)!;
    final isMobile = MediaQuery.of(context).size.width < 600;
    await showModal(isMobile, theme, context);
  }

  // Handles tap event when save wish button is pressed
  static Future<void> _onCreateWishTapped(
    NewWishModel newWish,
    BuildContext context,
  ) async {
    final navigator = Navigator.of(context);
    await context.read<WishflyController>().createNewWish(
          newWish.title,
          newWish.description,
        );
    navigator.pop();
  }

  /// Showing modal based on the param [isMobile]
  static Future<void> showModal(
    bool isMobile,
    WishflyThemeData theme,
    BuildContext context,
  ) async {
    if (isMobile) {
      await _showMobileWishModal(
        context,
        theme,
        (_) => _onCreateWishTapped(_, context),
      );
    } else {
      await _showWebWishModel(
        context,
        theme,
        (_) => _onCreateWishTapped(_, context),
      );
    }
  }

  /// Showing [showModalBottomSheet] for mobile layout
  static Future<void> _showMobileWishModal(
    BuildContext context,
    WishflyThemeData theme,
    ValueChanged<NewWishModel> onCreateWishTapped,
  ) async {
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: theme.primaryBackgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(spacingM),
          topRight: Radius.circular(spacingM),
        ),
      ),
      context: context,
      builder: (_) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: spacingM),
        child: _FormBody(
          theme,
          onCreateWishTapped: onCreateWishTapped,
        ),
      ),
    );
  }

  /// Showing [showGeneralDialog] for web layout
  /// To support web layout flow, the animation is set from right to left
  static Future<void> _showWebWishModel(
    BuildContext context,
    WishflyThemeData theme,
    ValueChanged<NewWishModel> onCreateWishTapped,
  ) async {
    showGeneralDialog(
      context: context,
      barrierLabel: "",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.3),
      transitionDuration: const Duration(milliseconds: 380),
      pageBuilder: (context, _, __) {
        return Align(
          alignment: (Alignment.centerRight),
          child: Material(
            elevation: 15,
            color: theme.primaryBackgroundColor,
            borderRadius: BorderRadius.circular(0),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: spacingM,
                vertical: spacingM,
              ),
              decoration: BoxDecoration(
                color: WishflyTheme.of(context)?.primaryBackgroundColor,
                borderRadius: BorderRadius.circular(0),
              ),
              height: double.infinity,
              constraints: const BoxConstraints(maxWidth: 500),
              child: _FormBody(
                theme,
                onCreateWishTapped: onCreateWishTapped,
              ),
            ),
          ),
        );
      },
      transitionBuilder: (context, animation1, animation2, child) {
        return SlideTransition(
          position: Tween(begin: const Offset(1, 0), end: const Offset(0, 0)).animate(animation1),
          child: child,
        );
      },
    );
  }
}

class _FormBody extends StatefulWidget {
  final WishflyThemeData _theme;
  final ValueChanged<NewWishModel> onCreateWishTapped;
  const _FormBody(
    WishflyThemeData theme, {
    required this.onCreateWishTapped,
    Key? key,
  })  : _theme = theme,
        super(key: key);

  @override
  State<_FormBody> createState() => _FormBodyState();
}

class _FormBodyState extends State<_FormBody> {
  final _formKey = GlobalKey<FormState>();

  String title = "";
  String description = "";

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Stack(
        children: [
          const _CloseButton(),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: spacingXL),
              Text(
                context.translate('newWishTitle'),
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: widget._theme.titleTextColor,
                    ),
              ),
              const SizedBox(height: spacingL),
              Text(
                context.translate('newWishText'),
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: widget._theme.titleTextColor,
                    ),
              ),
              const SizedBox(height: spacingS),
              TextFormField(
                autocorrect: false,
                cursorColor: widget._theme.titleTextColor,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: widget._theme.titleTextColor,
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
                  border: OutlineInputBorder(borderSide: BorderSide(color: widget._theme.titleTextColor!)),
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: widget._theme.titleTextColor!)),
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: widget._theme.titleTextColor!)),
                ),
              ),
              const SizedBox(height: spacingL),
              Text(
                context.translate('newWishDescription'),
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: widget._theme.titleTextColor,
                    ),
              ),
              const SizedBox(height: spacingS),
              TextFormField(
                autocorrect: false,
                cursorColor: widget._theme.titleTextColor,
                minLines: 7,
                maxLines: 10,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontSize: 16,
                      color: widget._theme.titleTextColor,
                    ),
                onChanged: (text) {
                  description = text;
                },
                decoration: InputDecoration(
                  filled: true,
                  border: OutlineInputBorder(borderSide: BorderSide(color: widget._theme.titleTextColor!)),
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: widget._theme.titleTextColor!)),
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: widget._theme.titleTextColor!)),
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
              const SizedBox(height: spacingM),
              Center(
                child: MaterialButton(
                  child: Text(
                    context.translate('saveNewWish'),
                    style: TextStyle(
                      color: widget._theme.titleTextColor,
                      fontSize: 18,
                    ),
                  ),
                  onPressed: () => _validate(
                    title,
                    description,
                    _formKey,
                    () => widget.onCreateWishTapped(
                      NewWishModel(title: title, description: description),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: spacingL),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _validate(
    String title,
    String description,
    GlobalKey<FormState> formKey,
    VoidCallback onValidationSuccess,
  ) async {
    if (formKey.currentState!.validate()) {
      onValidationSuccess();
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
