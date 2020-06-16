import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mindcapitalsimulator/src/locale/locales.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(8.0),
      children: <Widget>[
        Container(
          decoration: BoxDecoration(border: Border.all(width: 3)),
          padding: EdgeInsets.all(8.0),
          margin: EdgeInsets.all(8.0),
          child: ListTile(
            title: Text(
              'Mind.capital',
              style: TextStyle(fontSize: 20),
            ),
            subtitle: Row(
              children: <Widget>[
                Text('${AppLocalizations.of(context).infFile}'),
                IconButton(
                  icon: Icon(Icons.info),
                  tooltip: '${AppLocalizations.of(context).infFile}',
                  onPressed: () {
                    _launchDosier(context);
                  },
                ),
                Text('${AppLocalizations.of(context).faq}'),
                IconButton(
                  icon: Icon(Icons.question_answer),
                  onPressed: () {
                    _launchFAQ(context);
                  },
                )
              ],
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(border: Border.all(width: 3)),
          margin: EdgeInsets.all(8.0),
          padding: EdgeInsets.all(8.0),
          child: ListTile(
            title: Row(
              children: <Widget>[
                Text(
                  'BigRoi Club',
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Column(
                children: [
                  Text(
                    '${AppLocalizations.of(context).bigroiResume}',
                    style: TextStyle(fontSize: 18),
                  ),
                  ButtonBar(
                    children: [
                      // FlatButton.icon(
                      //   icon: Icon(FontAwesomeIcons.facebook,
                      //       color: Colors.blueAccent),
                      //   label: Text('${AppLocalizations.of(context).goFacebook}'),
                      //   color: Colors.white,
                      //   onPressed: () {
                      //     _launchFacebookBigRoiClub();
                      //   },
                      // ),
                      IconButton(
                          icon: Icon(FontAwesomeIcons.facebook,
                              color: Colors.blueAccent),
                          onPressed: () {
                            _launchFacebookBigRoiClub();
                          }),
                      IconButton(
                          icon: Icon(FontAwesomeIcons.twitter,
                              color: Colors.blueAccent),
                          onPressed: () {
                            _launchTwitterBigRoiClub();
                          }),
                      IconButton(
                          icon: Icon(FontAwesomeIcons.instagram,
                              color: Colors.redAccent),
                          onPressed: () {
                            _launchInstagramBigRoiClub();
                          }),
                      Visibility(
                        visible: false,
                        child: IconButton(
                            icon: Icon(FontAwesomeIcons.telegram,
                                color: Colors.blueAccent),
                            onPressed: () {
                              _launchTelegramBigRoiClub();
                            }),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  _launchDosier(BuildContext context) {
    String url = AppLocalizations.of(context).dosierUrl;

    _launch(url);
  }

  _launchFAQ(BuildContext context) {
    String url = AppLocalizations.of(context).faqUrl;

    _launch(url);
  }

  _launchFacebookBigRoiClub() {
    const url = 'https://www.facebook.com/bigroiclub/';

    _launch(url);
  }

  _launchTwitterBigRoiClub() {
    const url = 'https://twitter.com/bigroi_club/';

    _launch(url);
  }

  _launchInstagramBigRoiClub() {
    const url = 'https://www.instagram.com/bigroiclub/';

    _launch(url);
  }

  _launchTelegramBigRoiClub() {
    const url = 'https://t.me/bigroiclub';

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
