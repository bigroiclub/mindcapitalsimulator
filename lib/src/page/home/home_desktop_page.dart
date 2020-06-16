import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mindcapitalsimulator/src/locale/locales.dart';
import 'package:mindcapitalsimulator/src/widget/custom_button.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:mindcapitalsimulator/src/bloc/home_bloc.dart';
import 'package:mindcapitalsimulator/src/bloc/state/home_state.dart';
import 'package:mindcapitalsimulator/src/bloc/event/home_event.dart';

import '../about_page.dart';
import '../simulator/simulator_page.dart';
import '../track_record/track_record_page.dart';

class HomeDesktopPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Widget> _pages = [SimulatorPage(), TrackRecordPage(), AboutPage()];
    int _currentPage = 0;
    return BlocBuilder<HomeBloc, HomeState>(
        builder: (BuildContext context, state) {
      if (state is ChangePageState) {
        _currentPage = state.pageIndex;
      }

      return Scaffold(
        appBar: _appBar(context, _currentPage),
        body: _pages[_currentPage],
      );
    });
  }

  _appBar(BuildContext context, int currentPage) {
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
        ButtonBar(
          alignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            IconButton(
              icon: Icon(
                FontAwesomeIcons.tachometerAlt,
                color: currentPage == 0 ? Colors.blueAccent : Colors.black,
                size: 40.0,
              ),
              onPressed: () =>
                  BlocProvider.of<HomeBloc>(context).add(ChangePageEvent(0)),
            ),
            IconButton(
              icon: Icon(
                FontAwesomeIcons.chartLine,
                color: currentPage == 1 ? Colors.blueAccent : Colors.black,
                size: 40.0,
              ),
              onPressed: () =>
                  BlocProvider.of<HomeBloc>(context).add(ChangePageEvent(1)),
            ),
            IconButton(
              icon: Icon(
                FontAwesomeIcons.infoCircle,
                color: currentPage == 2 ? Colors.blueAccent : Colors.black,
                size: 40.0,
              ),
              onPressed: () =>
                  BlocProvider.of<HomeBloc>(context).add(ChangePageEvent(2)),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.all(5.0),
          child: CustomButton(
            child: Text(
                AppLocalizations.of(context).appBarButton), //'¡Alta Gratis!'
            onPressed: _launchAlta,
          ),
        ),
      ],
    );
  }

  _launchAlta() {
    const url = 'https://mind.capital/?referral=28z2gI2Wz2';

    _launch(url);
  }

  _launch(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
