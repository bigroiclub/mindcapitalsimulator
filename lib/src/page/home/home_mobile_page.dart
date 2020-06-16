import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:mindcapitalsimulator/src/locale/locales.dart';
import 'package:mindcapitalsimulator/src/page/about_page.dart';
import 'package:mindcapitalsimulator/src/page/simulator/simulator_page.dart';
import 'package:mindcapitalsimulator/src/widget/custom_button.dart';
import 'package:url_launcher/url_launcher.dart';

import '../track_record/track_record_page.dart';

class HomeMobilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Tab> tabs = <Tab>[
      Tab(text: AppLocalizations.of(context).simulator),
      Tab(text: AppLocalizations.of(context).trackRecord),
      Tab(text: AppLocalizations.of(context).about),
    ];
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: _appBar(context, tabs),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TabBarView(
            children: [SimulatorPage(), TrackRecordPage(), AboutPage()],
          ),
        ),
      ),
    );
  }

  _appBar(BuildContext context, List<Widget> tabs) {
    return AppBar(
      elevation: 0.0,
      backgroundColor: Colors.white,
      leading: GestureDetector(
        child: Image(
          image: AssetImage('assets/logoMindCapital.png'),
          // width: 100,
          // height: 100,
        ),
        onTap: () {
          // _launchMindCapital();
        },
      ),
      title: Text(
        AppLocalizations.of(context).title,
        style: TextStyle(color: Colors.blue),
      ),
      actions: <Widget>[
        CustomButton(
          child:
              Text(AppLocalizations.of(context).appBarButton), //'¡Alta Gratis!'
          onPressed: _launchAlta,
        ),
      ],
      bottom: TabBar(
        isScrollable: true,
        unselectedLabelColor: Colors.grey,
        labelColor: Colors.white,
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: BubbleTabIndicator(
          indicatorHeight: 25.0,
          indicatorColor: Colors.blueAccent,
          tabBarIndicatorSize: TabBarIndicatorSize.tab,
        ),
        tabs: tabs,
      ),
    );
  }

  _launchAlta() {
    const url = 'https://mind.capital/?referral=28z2gI2Wz2';

    _launch(url);
  }

  // _launchMindCapital() {
  //   const url = 'https://mind.capital/';

  //   _launch(url);
  // }

  _launch(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
