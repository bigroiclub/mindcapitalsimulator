import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../track_record/tack_record_desktop_page.dart';
import '../track_record/tack_record_mobile_page.dart';

class TrackRecordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: TrackRecordMobilePage(),
      tablet: TrackRecordDesktopPage(),
      desktop: TrackRecordDesktopPage(),
      );
  }
}