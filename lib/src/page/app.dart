import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mindcapitalsimulator/src/bloc/event/home_event.dart';
import 'package:mindcapitalsimulator/src/bloc/home_bloc.dart';
import 'package:mindcapitalsimulator/src/locale/locales.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mindcapitalsimulator/src/page/home/home_page.dart';
import 'package:rate_my_app/rate_my_app.dart';

// import 'package:flutter_cupertino_localizations/flutter_cupertino_localizations.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RateMyAppBuilder(
      builder: (context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateTitle: (BuildContext context) =>
            AppLocalizations.of(context).title,
        localizationsDelegates: [
          // ... app-specific localization delegate[s] here
          const AppLocalizationsDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('en'), // English
          const Locale('es'), // Spanish
          const Locale('ca'), // Catalonian
        ],
        home: HomePage(),
        theme: ThemeData(
          textTheme: GoogleFonts.montserratTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
      ),
      onInitialized: (context, rateMyApp) {
        rateMyApp.conditions.clear();
        rateMyApp.populateWithDefaultConditions(minLaunches: 3, remindLaunches: 10, minDays: 2, remindDays: 15);
        rateMyApp.init().then((_) => BlocProvider.of<HomeBloc>(context).add(RateMyAddEvent(rateMyApp)));
        // rateMyApp.reset();
      },
    );
  }
}
