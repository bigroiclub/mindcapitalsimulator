import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mindcapitalsimulator/src/l10n/messages_all.dart';

// This file was generated in two steps, using the Dart intl tools. With the
// app's root directory (the one that contains pubspec.yaml) as the current
// directory:
//
// flutter pub get
// flutter pub pub run intl_translation:extract_to_arb --output-dir=lib/src/l10n lib/src/locale/locales.dart
// flutter pub pub run intl_translation:generate_from_arb --output-dir=lib/src/l10n --no-use-deferred-loading lib/src/l10n/intl_en.arb lib/src/l10n/intl_es.arb lib/src/l10n/intl_ca.arb lib/src/locale/locales.dart
//
// The second command generates intl_messages.arb and the third generates
// messages_all.dart. There's more about this process in
// https://pub.dev/packages/intl.

class AppLocalizations {
  AppLocalizations(this.localeName);

  static Future<AppLocalizations> load(Locale locale) {
    final String name = locale.countryCode != null
        ? locale.countryCode.isEmpty ? locale.languageCode : locale.toString()
        : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((_) {
      return AppLocalizations(localeName);
    });
  }

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  final String localeName;

  String get title {
    return Intl.message(
      'Mind.capital Simulator',
      name: 'title',
      desc: 'Title for the App application',
      locale: localeName,
    );
  }

  String get appBarButton {
    return Intl.message(
      'Free Registration!',
      name: 'appBarButton',
      desc: 'Title for appBar Button',
      locale: localeName,
    );
  }

  String get simulator {
    return Intl.message(
      'Simulator',
      name: 'simulator',
      desc: 'Simulator text',
      locale: localeName,
    );
  }

  String get trackRecord {
    return Intl.message(
      'Track Record',
      name: 'trackRecord',
      desc: 'Track Record text',
      locale: localeName,
    );
  }

  String get about {
    return Intl.message(
      'About',
      name: 'about',
      desc: 'About text',
      locale: localeName,
    );
  }

  String get compContribution {
    return Intl.message(
      'Composite Contribution',
      name: 'compContribution',
      desc: 'Composite Contribution text',
      locale: localeName,
    );
  }

  String get profit {
    return Intl.message(
      'Profit',
      name: 'profit',
      desc: 'Profit text',
      locale: localeName,
    );
  }

  String get months {
    return Intl.message(
      'Months',
      name: 'months',
      desc: 'Months text',
      locale: localeName,
    );
  }

  String get reset {
    return Intl.message(
      'Reset',
      name: 'reset',
      desc: 'Reset text',
      locale: localeName,
    );
  }

  String get initContribution {
    return Intl.message(
      'Initial Contribution',
      name: 'initContribution',
      desc: 'Initial Contribution text',
      locale: localeName,
    );
  }

  String get referTotal {
    return Intl.message(
      'Total Contribution Referals',
      name: 'referTotal',
      desc: 'Total Contribution Referals text',
      locale: localeName,
    );
  }

  String get referProfit {
    return Intl.message(
      'Referals Profit',
      name: 'referProfit',
      desc: 'Total Profit Referals text',
      locale: localeName,
    );
  }

  String get referLevel1 {
    return Intl.message(
      'Level 1',
      name: 'referLevel1',
      desc: 'Level 1 text',
      locale: localeName,
    );
  }

  String get referLevel2 {
    return Intl.message(
      'Level 2',
      name: 'referLevel2',
      desc: 'Level 2 text',
      locale: localeName,
    );
  }

  String get referLevel3 {
    return Intl.message(
      'Level 3',
      name: 'referLevel3',
      desc: 'Level 3 text',
      locale: localeName,
    );
  }

  String get referLevel4 {
    return Intl.message(
      'Level 4',
      name: 'referLevel4',
      desc: 'Level 4 text',
      locale: localeName,
    );
  }

  String get referLevel5 {
    return Intl.message(
      'Level 5',
      name: 'referLevel5',
      desc: 'Level 5 text',
      locale: localeName,
    );
  }

  String get referLevel6 {
    return Intl.message(
      'Level 6',
      name: 'referLevel6',
      desc: 'Level 6 text',
      locale: localeName,
    );
  }

  String get referLevel7 {
    return Intl.message(
      'Level 7',
      name: 'referLevel7',
      desc: 'Level 7 text',
      locale: localeName,
    );
  }

  String get referLevel8 {
    return Intl.message(
      'Level 8',
      name: 'referLevel8',
      desc: 'Level 8 text',
      locale: localeName,
    );
  }

  String get referLevel9 {
    return Intl.message(
      'Level 9',
      name: 'referLevel9',
      desc: 'Level 9 text',
      locale: localeName,
    );
  }

  String get referLevel10 {
    return Intl.message(
      'Level 10',
      name: 'referLevel10',
      desc: 'Level 10 text',
      locale: localeName,
    );
  }

  String get minContribution {
    return Intl.message(
      'Minimum contribution',
      name: 'minContribution',
      desc: 'Minimum contribution text',
      locale: localeName,
    );
  }

  String get maxContribution {
    return Intl.message(
      'Maximum contribution',
      name: 'maxContribution',
      desc: 'Maximum contribution text',
      locale: localeName,
    );
  }

  String get compInterest {
    return Intl.message(
      'Composite Interest',
      name: 'compInterest',
      desc: 'Composite Interest text',
      locale: localeName,
    );
  }

  String get benefitsAvailable {
    return Intl.message(
      'Benefits Available',
      name: 'benefitsAvailable',
      desc: 'Benefits Available text',
      locale: localeName,
    );
  }

  String get total {
    return Intl.message(
      'Total',
      name: 'total',
      desc: 'Total text',
      locale: localeName,
    );
  }

  String get platform {
    return Intl.message(
      'Platform Profit',
      name: 'platform',
      desc: 'Platform text',
      locale: localeName,
    );
  }

  String get daily {
    return Intl.message(
      'Daily',
      name: 'daily',
      desc: 'Daily text',
      locale: localeName,
    );
  }

  String get weekly {
    return Intl.message(
      'Weekly',
      name: 'weekly',
      desc: 'Weekly text',
      locale: localeName,
    );
  }

  String get monthly {
    return Intl.message(
      'Monthly',
      name: 'monthly',
      desc: 'Monthly text',
      locale: localeName,
    );
  }

  String get infFile {
    return Intl.message(
      'Information file',
      name: 'infFile',
      desc: 'Information file. text',
      locale: localeName,
    );
  }

  String get faq {
    return Intl.message(
      'FAQ',
      name: 'faq',
      desc: 'FAQ text',
      locale: localeName,
    );
  }

  String get bigroiResume {
    return Intl.message(
      'BigRoi Club was born as a platform of knowledge and promotion of the best businesses and investments on the Internet. BigRoi Club will offer to its members the tools, supports and media needed to inform and communicate with all its members.\nThis is one of the many tools that BigRoi Club will make and give to all its members.\nThis is just the beginning, if you want to keep up with the updates and news about this great project follow us through our social networks and do not miss anything.',
      name: 'bigroiResume',
      desc: 'BigRoi Resume text',
      locale: localeName,
    );
  }

  String get goFacebook {
    return Intl.message(
      'Go to Facebook',
      name: 'goFacebook',
      desc: 'Go to Facebook text',
      locale: localeName,
    );
  }

  String get dayAverage {
    return Intl.message(
      'Day Historical Average',
      name: 'dayAverage',
      desc: 'Week Historical Average text',
      locale: localeName,
    );
  }

  String get weekAverage {
    return Intl.message(
      'Week Historical Average',
      name: 'weekAverage',
      desc: 'Week Historical Average text',
      locale: localeName,
    );
  }

  String get monthAverage {
    return Intl.message(
      'Month Historical Average',
      name: 'monthAverage',
      desc: 'Month Historical Average text',
      locale: localeName,
    );
  }

  String get januaryShort {
    return Intl.message(
      'JAN',
      name: 'januaryShort',
      desc: 'JAN text',
      locale: localeName,
    );
  }

  String get februaryShort {
    return Intl.message(
      'FEB',
      name: 'februaryShort',
      desc: 'FEB text',
      locale: localeName,
    );
  }

  String get marchShort {
    return Intl.message(
      'MAR',
      name: 'marchShort',
      desc: 'MAR text',
      locale: localeName,
    );
  }

  String get aprilShort {
    return Intl.message(
      'APR',
      name: 'aprilShort',
      desc: 'APR text',
      locale: localeName,
    );
  }

  String get mayShort {
    return Intl.message(
      'MAY',
      name: 'mayShort',
      desc: 'MAY text',
      locale: localeName,
    );
  }

  String get juneShort {
    return Intl.message(
      'JUN',
      name: 'juneShort',
      desc: 'JUN text',
      locale: localeName,
    );
  }

  String get julyShort {
    return Intl.message(
      'JUL',
      name: 'julyShort',
      desc: 'JUL text',
      locale: localeName,
    );
  }

  String get augustShort {
    return Intl.message(
      'AUG',
      name: 'augustShort',
      desc: 'AUG text',
      locale: localeName,
    );
  }

  String get septemberShort {
    return Intl.message(
      'SEP',
      name: 'septemberShort',
      desc: 'SEP text',
      locale: localeName,
    );
  }

  String get octoberShort {
    return Intl.message(
      'OCT',
      name: 'octoberShort',
      desc: 'OCT text',
      locale: localeName,
    );
  }

  String get novemberShort {
    return Intl.message(
      'NOV',
      name: 'novemberShort',
      desc: 'NOV text',
      locale: localeName,
    );
  }

  String get decemberShort {
    return Intl.message(
      'DEC',
      name: 'decemberShort',
      desc: 'DEC text',
      locale: localeName,
    );
  }

  String get infoPlatform {
    return Intl.message(
      '35% profit for Mind.capital',
      name: 'infoPlatform',
      desc: 'infoPlatform text',
      locale: localeName,
    );
  }

  String get infoInteresCompuesto {
    return Intl.message(
      'Reinvest profit',
      name: 'infoInteresCompuesto',
      desc: 'infoInteresCompuesto text',
      locale: localeName,
    );
  }

  String get ofWhich {
    return Intl.message(
      'of which',
      name: 'ofWhich',
      desc: 'ofWhich text',
      locale: localeName,
    );
  }

  String get back {
    return Intl.message(
      'Back',
      name: 'back',
      desc: 'Back text',
      locale: localeName,
    );
  }

  String get dosierUrl {
    return Intl.message(
      'https://mind.capital/en/attach/mind-capital.pdf',
      name: 'dosierUrl',
      desc: 'dosierUrl text',
      locale: localeName,
    );
  }

  String get faqUrl {
    return Intl.message(
      'https://mind.capital/en/attach/mind-capital-faq.pdf',
      name: 'faqUrl',
      desc: 'faqUrl text',
      locale: localeName,
    );
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      ['en', 'es', 'ca'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) => AppLocalizations.load(locale);

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
