import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mindcapitalsimulator/src/locale/locales.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../page/home/home_page.dart';
// import 'package:flutter_cupertino_localizations/flutter_cupertino_localizations.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateTitle: (BuildContext context) => AppLocalizations.of(context).title,
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
      theme: ThemeData(textTheme: GoogleFonts.montserratTextTheme(Theme.of(context).textTheme,),),
    );
  }
}
