import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mindcapitalsimulator/src/bloc/login_bloc.dart';
import 'package:mindcapitalsimulator/src/bloc/state/login_state.dart';
import 'package:mindcapitalsimulator/src/locale/locales.dart';
import 'package:mindcapitalsimulator/src/page/login/login_page.dart';
import 'package:mindcapitalsimulator/src/page/simulator/simulator_page.dart';
import 'package:mindcapitalsimulator/src/page/track_record/track_record_page.dart';
import 'package:mindcapitalsimulator/src/widget/custom_button.dart';
import 'package:mindcapitalsimulator/src/widget/rate_app_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:mindcapitalsimulator/src/bloc/home_bloc.dart';
import 'package:mindcapitalsimulator/src/bloc/state/home_state.dart';
import 'package:mindcapitalsimulator/src/bloc/event/home_event.dart';

import '../about_page.dart';

class HomeDesktopPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Widget> _pages = [LoginPage(), LoginPage(), AboutPage()];
    int _currentPage = 0;
    return BlocBuilder<HomeBloc, HomeState>(
        builder: (BuildContext context, state) {
      if (state is ChangePageState) {
        _currentPage = state.pageIndex;
      } else if (state is RateMyAppState) {
        RateAppWidget(state.rateMyApp).showRateDialog(context);
      }

      return BlocBuilder<LoginBloc, LoginState>(
          builder: (BuildContext context, state) {
        if (state is LoginInitState) {
          if (state.isUserLogin) {
            _pages[0] = SimulatorPage();
            _pages[1] = TrackRecordPage();
          }
        } else if (state is SignInSuccess) {
          _pages[0] = SimulatorPage();
          _pages[1] = TrackRecordPage();
        } else if (state is SignInFail) {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            Flushbar(
              duration: Duration(seconds: 3),
              icon: Icon(FontAwesomeIcons.user),
              message: AppLocalizations.of(context).loginFail,
              backgroundGradient: LinearGradient(
                colors: [
                  Color.fromRGBO(242, 0, 83, 1),
                  Color.fromRGBO(242, 0, 83, 0.5)
                ],
              ),
            )..show(context);
          });
        }
        return Scaffold(
          appBar: _appBar(context, _currentPage),
          body: _pages[_currentPage],
        );
      });
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
