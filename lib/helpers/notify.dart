import "package:flutter/material.dart";

class Notify {
  static _clear(BuildContext context) {
    ScaffoldMessenger.of(context).clearSnackBars();
  }

  static showError({required BuildContext context, required String message}) {
    _clear(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: Theme.of(context).textTheme.labelMedium!.copyWith(
            color: Theme.of(context).colorScheme.error,
            fontWeight: FontWeight.w500,
          ),
        ),
        showCloseIcon: true,
        behavior: SnackBarBehavior.fixed,
        backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
      ),
    );
  }

  static showSuccess({required BuildContext context, required String message}) {
    _clear(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: Theme.of(context).textTheme.labelMedium!.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
            fontWeight: FontWeight.w500,
          ),
        ),
        showCloseIcon: true,
        behavior: SnackBarBehavior.fixed,
        backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
      ),
    );
  }
}
