import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:mindcapitalsimulator/src/locale/locales.dart';
import 'package:rate_my_app/rate_my_app.dart';

class RateAppWidget {
  final RateMyApp rateMyApp;

  RateAppWidget(this.rateMyApp);

  void showRateDialog(BuildContext context) {
    if (rateMyApp.shouldOpenDialog) {
      SchedulerBinding.instance.addPostFrameCallback(
        (_) {
          rateMyApp.showRateDialog(
            context,
            title: AppLocalizations.of(context).rateTitle, // The dialog title.
            message: AppLocalizations.of(context).rateMessage, // The dialog message.
            rateButton: AppLocalizations.of(context).rateButton, // The dialog "rate" button text.
            noButton: AppLocalizations.of(context).rateNoButton, // The dialog "no" button text.
            laterButton: AppLocalizations.of(context).rateLaterButton, // The dialog "later" button text.
            listener: (button) {
              // The button click listener (useful if you want to cancel the click event).
              switch (button) {
                case RateMyAppDialogButton.rate:
                  print('Clicked on "Rate".');
                  break;
                case RateMyAppDialogButton.later:
                  print('Clicked on "Later".');
                  break;
                case RateMyAppDialogButton.no:
                  print('Clicked on "No".');
                  break;
              }

              return true; // Return false if you want to cancel the click event.
            },
            ignoreIOS:
                false, // Set to false if you want to show the Apple's native app rating dialog on iOS.
            dialogStyle: DialogStyle(), // Custom dialog styles.
            onDismissed: () => rateMyApp.callEvent(RateMyAppEventType
                .laterButtonPressed), // Called when the user dismissed the dialog (either by taping outside or by pressing the "back" button).
            // contentBuilder: (context, defaultContent) => content, // This one allows you to change the default dialog content.
            // actionsBuilder: (context) => [], // This one allows you to use your own buttons.
          );
        },
      );
    }
  }
}
