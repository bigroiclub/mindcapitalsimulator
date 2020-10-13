import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mindcapitalsimulator/src/bloc/home_bloc.dart';
import 'package:mindcapitalsimulator/src/bloc/login_bloc.dart';
import 'package:mindcapitalsimulator/src/bloc/state/home_state.dart';
import 'package:mindcapitalsimulator/src/bloc/state/login_state.dart';
import 'package:mindcapitalsimulator/src/locale/locales.dart';
import 'package:mindcapitalsimulator/src/page/about_page.dart';
import 'package:mindcapitalsimulator/src/page/login/login_page.dart';
import 'package:mindcapitalsimulator/src/page/simulator/simulator_page.dart';
import 'package:mindcapitalsimulator/src/page/track_record/track_record_page.dart';
import 'package:mindcapitalsimulator/src/widget/custom_button.dart';
import 'package:mindcapitalsimulator/src/widget/rate_app_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeMobilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Tab> tabs = <Tab>[
      Tab(text: AppLocalizations.of(context).simulator),
      Tab(text: AppLocalizations.of(context).trackRecord),
      Tab(text: AppLocalizations.of(context).about),
    ];

    Widget _page1 = LoginPage();
    Widget _page2 = LoginPage();

    return BlocBuilder<HomeBloc, HomeState>(
      builder: (BuildContext context, state) {
        if (state is ChangePageState) {
          // _currentPage = state.pageIndex;
        } else if (state is RateMyAppState) {
          RateAppWidget(state.rateMyApp).showRateDialog(context);
        }

        return BlocBuilder<LoginBloc, LoginState>(
          builder: (BuildContext context, state) {
            if (state is LoginInitState) {
              if (state.isUserLogin) {
                _page1 = SimulatorPage();
                _page2 = TrackRecordPage();
              }
            } else if (state is SignInSuccess) {
              _page1 = SimulatorPage();
              _page2 = TrackRecordPage();
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

            return DefaultTabController(
              length: tabs.length,
              child: Scaffold(
                appBar: _appBar(context, tabs),
                body: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TabBarView(
                    children: [_page1, _page2, AboutPage()],
                  ),
                ),
              ),
            );
          },
        );
      },
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
